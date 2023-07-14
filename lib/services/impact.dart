import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nix/database/entities/entities.dart';
import 'package:nix/services/server_strings.dart';
import 'package:nix/utils/shared_preferences.dart';

class ImpactService {
  ImpactService(this.prefs) {
    updateBearer();
  }

  Preferences prefs;

  final Dio _dio = Dio(BaseOptions(baseUrl: ServerStrings.baseUrl));

  String? retrieveSavedToken(bool refresh) {
    if (refresh) {
      return prefs.impactRefreshToken;
    } else {
      return prefs.impactAccessToken;
    }
  } //retriveSavedToken

  bool checkSavedToken({bool refresh = false}) {
    String? token = retrieveSavedToken(refresh);
    //Check if there is a token
    if (token == null) {
      return false;
    }
    try {
      return ImpactService.checkToken(token);
    } catch (_) {
      return false;
    }
  } //checkSavedToken

  // this method is static because we might want to check the token outside the class itself
  static bool checkToken(String token) {
    //Check if the token is expired
    if (JwtDecoder.isExpired(token)) {
      return false;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    //Check the iss claim
    if (decodedToken['iss'] == null) {
      return false;
    } else {
      if (decodedToken['iss'] != ServerStrings.issClaim) {
        return false;
      } //else
    } //if-else

    //Check the role of the user
    if (decodedToken['role'] == null) {
      return false;
    } else {
      if (decodedToken['role'] != ServerStrings.roleIdentifier) {
        return false;
      } //else
    } //if-else

    return true;
  } //checkToken

  // make the call to get the tokens
  Future<bool> getTokens(String username, String password) async {
    try {
      Response response = await _dio.post(
        ServerStrings.tokenEndpoint,
        data: {'username': username, 'password': password},
        options: Options(
          contentType: 'application/json',
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {"Accept": "application/json"}
        )
      );

      if (ImpactService.checkToken(response.data['access']) &&
          ImpactService.checkToken(response.data['refresh'])) {
        prefs.impactRefreshToken = response.data['refresh'];
        prefs.impactAccessToken = response.data['access'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> refreshTokens() async {
    String? refToken = await retrieveSavedToken(true);
    try {
      Response response = await _dio.post(
        ServerStrings.refreshEndpoint,
        data: {'refresh': refToken},
        options: Options(
          contentType: 'application/json',
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {"Accept": "application/json"}
        )
      );

      if (ImpactService.checkToken(response.data['access']) &&
          ImpactService.checkToken(response.data['refresh'])) {
        prefs.impactRefreshToken = response.data['refresh'];
        prefs.impactAccessToken = response.data['access'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateBearer() async {
    if (!await checkSavedToken()) {
      await refreshTokens();
    }
    String? token = await prefs.impactAccessToken;
    if (token != null) {
      _dio.options.headers = {'Authorization': 'Bearer $token'};
    }
  }

  Future<List<Steps>> getStepsFromDay(DateTime startTime) async {
    await updateBearer();
    Response r = await _dio.get(
       '/data/v1/steps/patients/${ServerStrings.subjectUsername}/day/${DateFormat('y-M-d').format(startTime)}/');
       
    Map<String, dynamic> data = r.data;
    if (data['data'] is List) { // day without steps data
      Map<String, dynamic> values = {'date': '${DateFormat('yyyy-MM-dd').format(startTime)}', 'data': [{'time': '00:00:10', 'value': '0' }]};
      data['data'] = values;
    }
    Map<String, dynamic> daydata = data['data'];
    List<Steps> step = [];
    String day = daydata['date'];
    for (var dataday in daydata['data']) {
      String hour = dataday['time'];
      String datetime = '${day}T$hour';
      DateTime timestamp = _truncateSeconds(DateTime.parse(datetime));
      Steps stepnew = Steps(null, timestamp, int.parse(dataday['value']),);
      if (!step.any((e) => e.dateTime.isAtSameMomentAs(stepnew.dateTime))) {
        step.add(stepnew);
      }
    }
    var steplist = step.toList()..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return steplist;
  }
  
  DateTime _truncateSeconds(DateTime input) {
    return DateTime(
        input.year, input.month, input.day, input.hour, input.minute);
  }

  Future<Sleep> getSleepFromDay(DateTime startTime) async {
    await updateBearer();
    Response r = await _dio.get(
        '/data/v1/sleep/patients/${ServerStrings.subjectUsername}/day/${DateFormat('y-M-d').format(startTime)}/');
    Map<String, dynamic> data = r.data;
      if (data['data'] is List) { // day without sleep data
        Map<String, dynamic> values = {'date': '${DateFormat('yyyy-MM-dd').format(startTime)}', 'data': [{'startTime': '00-00 00:00:00', 'endTime': '00-00 00:00:00', 'duration': 0, 'efficiency': 0}]};
        data['data'] = values;
      }
    Map<String, dynamic> daydata = data['data'];
    String day = daydata['date'];
    DateTime timestamp = _truncateSeconds(DateTime.parse(day));
    Map<String, dynamic> dataday = daydata['data'][0];
    String startSleep = dataday['startTime'].substring(6);
    String endSleep = dataday['endTime'].substring(6);
    double duration = dataday['duration']/3.6e+6; // conversion into hours
    String durationInStr = duration.toStringAsFixed(1);
    double durationHours = double.parse(durationInStr);
    int eff = dataday['efficiency'];
    Sleep sleep = Sleep(null, timestamp, startSleep, endSleep, durationHours, eff);
    return sleep;
  }
    
}
