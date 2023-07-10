import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nix/database/entities/entities.dart';
import 'package:nix/database/entities/sleep.dart';
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
  }

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
  }

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
      Response response = await _dio.post(ServerStrings.tokenEndpoint,
          data: {
            'username': username,
            'password': password,
          },
          options: Options(
              contentType: 'application/json',
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {"Accept": "application/json"}));

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
      Response response = await _dio.post(ServerStrings.refreshEndpoint,
          data: {'refresh': refToken},
          options: Options(
              contentType: 'application/json',
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {"Accept": "application/json"}));

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

/*
  Future<List<Steps>> getStepsFromDay(DateTime startTime) async {
    await updateBearer();
    Response r = await _dio.get(
        '${ServerStrings.stepsEndpoint}${ServerStrings.subjectUsername}/daterange/start_date/${DateFormat('y-M-d').format(startTime)}/end_date/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');
    Map<String, dynamic> response = r.data;
    List<Steps> steplist = [];
    for (var i = 0; i < response['data'].length; i++) {
      Map<String, dynamic> daydata = response['data'][i];
      for (var j = 0; j < daydata['data'].length; j++) {
        steplist.add(Steps.fromJson(null, daydata['date'], daydata['data'][j]));
      }
    }
    return steplist;
  }
  */

  Future<List<Steps>> getStepsFromDay(DateTime startTime) async {
    await updateBearer();
    Response r = await _dio.get(
       'data/v1/steps/patients/${ServerStrings.subjectUsername}/daterange/start_date/${DateFormat('y-M-d').format(startTime)}/end_date/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');
       //'/data/v1/steps/patients/${ServerStrings.subjectUsername}/day/${DateFormat('y-M-d').format(startTime)}');
    List<dynamic> data = r.data['data'];
    List<Steps> step = [];
    for (var daydata in data) {
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
    }
    var steplist = step.toList()..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return steplist;
  }
  
  /*
Future<List<Sleep>> getSleepFromDay(DateTime startTime) async {
    await updateBearer();
    Response r = await _dio.get(
       'data/v1/sleep/patients/${ServerStrings.subjectUsername}/daterange/start_date/${DateFormat('y-M-d').format(startTime)}/end_date/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');
    List<dynamic> data = r.data['data'];
    List<Sleep> sleep = [];
    for (var daydata in data) {
      String day = daydata['date'];
      for (var dataday in daydata['data']) {
        String hour = dataday['time'];
        String datetime = '${day}T$hour';
        DateTime timestamp = _truncateSeconds(DateTime.parse(datetime));
        String duration =daydata['duration'];
        String eff = daydata['efficiecy'];
        Steps stepnew = Sleep(null, DateFormat('yyyy-MM-dd').parse('${json["data"]["dateOfSleep"]}'),, int.parse(dataday['value']),);
        if (!step.any((e) => e.dateTime.isAtSameMomentAs(stepnew.dateTime))) {
          step.add(stepnew);
        }
      }
    }
    var steplist = step.toList()..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return steplist;
  }
  */

  DateTime _truncateSeconds(DateTime input) {
    return DateTime(
        input.year, input.month, input.day, input.hour, input.minute);
  }


/*
  Future<List<Sleep>> getSleepFromDay(DateTime startTime) async {
    await updateBearer();
    Response r = await _dio.get(
      '${ServerStrings.sleepEndpoint}${ServerStrings.subjectUsername}/daterange/start_date/${DateFormat('y-M-d').format(startTime)}/end_date/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');
    Map<String,dynamic> response = r.data;
    List<Sleep> sleeplist = [];
    for (var i = 0; i < response['data'].length; i++) {
      sleeplist.add(Sleep.fromJson(null, response['data'][i]));
    }
    return sleeplist;
  }
*/
}
