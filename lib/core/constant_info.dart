import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/entities/user.dart';

class ConstantInfo {
  static ConstantInfo constantInfo = new ConstantInfo();
  User userInfo;
  SharedPreferences sharedPreferences;
  String tokenFireBase = "";
  static ConstantInfo getInstance() {
    return constantInfo;
  }

  void setUserInfoValue(User info) {
    userInfo = info;
  }

  void setFireBaseToken(String token) {
    this.tokenFireBase = token;
  }

  void setSharedPreference(SharedPreferences item) {
    sharedPreferences = item;
  }
}
