import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  } //init

  late SharedPreferences _pref;

  //helper method to manage default values of preferences without the need to call the specific getType method of SharedPreferences
  dynamic _getFromDisk(String key, {dynamic defaultVal}) {
    var value = _pref.get(key);
    if (value == null) {
      _saveToDisk(key, defaultVal);
      return defaultVal;
    } else if (value is List) {
      var val = _pref.getStringList(key);
      return val;
    }
    return value;
  }

  // helper method to call the correct setType method of SharedPreferences
  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _pref.setString(key, content);
    }
    if (content is bool) {
      _pref.setBool(key, content);
    }
    if (content is int) {
      _pref.setInt(key, content);
    }
    if (content is double) {
      _pref.setDouble(key, content);
    }
    if (content is List<String>) {
      _pref.setStringList(key, content);
    }
    if (content == null) {
      _pref.remove(key);
    }
  }

  // Here we define all the keys we will need in the Preferences. We will then access the value with the getter as Preferences.key
  // The getter allows us to forget the specific string used as key in the SharedPreferences and get a list of all saved preferences as variables of the class

  String? get impactRefreshToken => _getFromDisk('impactRefreshToken');
  set impactRefreshToken(String? newImpactRefreshToken) => _saveToDisk("impactRefreshToken", newImpactRefreshToken);

  String? get impactAccessToken => _getFromDisk('impactAccessToken');
  set impactAccessToken(String? newImpactAccessToken) => _saveToDisk("impactAccessToken", newImpactAccessToken);

  String? get usernameUser => _getFromDisk('usernameUser');
  set usernameUser(String? newusernameUser) => _saveToDisk("usernameUser", newusernameUser);

  String? get passwordUser => _getFromDisk('passwordUser');
  set passwordUser(String? newpasswordUser) => _saveToDisk("passwordUser", newpasswordUser);

  bool get logOut => _getFromDisk('logOut', defaultVal: false);
  set logOut(bool newlogOut) => _saveToDisk("logOut", newlogOut);
  
  String? get name => _getFromDisk('name');
  set name(String? newname) => _saveToDisk("name", newname);

  String? get surname => _getFromDisk('surname');
  set surname(String? newsurname) => _saveToDisk("surname", newsurname);

  String? get nickname => _getFromDisk('nickname');
  set nickname(String? newnickname) => _saveToDisk("nickname", newnickname);

  String? get birthdate => _getFromDisk('birthdate');
  set birthdate(String? newbirthdate) => _saveToDisk("birthdate", newbirthdate);

  int get sex => _getFromDisk('sex', defaultVal: 0);
  set sex(int newsex) => _saveToDisk("sex", newsex);

  int get smoke => _getFromDisk('smoke', defaultVal: 1);
  set smoke(int newsmoke) => _saveToDisk("smoke", newsmoke);

  int get sporty => _getFromDisk('sporty', defaultVal: 2);
  set sporty(int newsporty) => _saveToDisk("sporty", newsporty);

  String? get height => _getFromDisk('height');
  set height(String? newheight) => _saveToDisk("height", newheight);

  String? get weight => _getFromDisk('weight');
  set weight(String? newweight) => _saveToDisk("weight", newweight);

  double? get bmi => _getFromDisk('bmi');
  set bmi(double? newbmi) => _saveToDisk("bmi", newbmi);

  String? get status => _getFromDisk('status');
  set status(String? newstatus) => _saveToDisk("status", newstatus);

}
