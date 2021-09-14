import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/features/login/data/models/login_model.dart';

class InitValue {
  SharedPreferences _sharedPreferences;
  Future<void> autoInitialValues() async {
    ConstantInfo constantInfo = ConstantInfo.getInstance();
    _sharedPreferences = await SharedPreferences.getInstance();
    constantInfo.setSharedPreference(_sharedPreferences);
    if (_sharedPreferences.getString("user") != null) {
      String user = _sharedPreferences.getString("user");
      constantInfo.setUserInfoValue(loginModelFromJson(user).user);
    }
  }
}
