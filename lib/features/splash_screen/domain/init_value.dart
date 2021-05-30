import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/constant_info.dart';

class InitValue{
  SharedPreferences _sharedPreferences;
  Future<void> autoInitialValues()async
  {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String token = await _firebaseMessaging.getToken();
    ConstantInfo constantInfo = ConstantInfo.getInstance();
    _sharedPreferences = await SharedPreferences.getInstance();
    constantInfo.setSharedPreference(_sharedPreferences);
    constantInfo.setFireBaseToken(token);
  }
}