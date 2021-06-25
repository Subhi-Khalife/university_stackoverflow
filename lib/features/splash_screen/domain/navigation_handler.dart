import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/widget/main_screen_dialog.dart';
import 'package:university/features/common_and_global_question/common_and_global_question.dart';
import 'package:university/features/common_question/presentation/pages/public_common_question.dart';
import 'package:university/features/login/data/models/login_model.dart';
import 'package:university/features/post/presentation/pages/show_all_posts.dart';

class NavigationHandler {

  SharedPreferences _sharedPreferences;

  navigationPage(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    ConstantInfo constantInfo = ConstantInfo.getInstance();
    _sharedPreferences = constantInfo.sharedPreferences;
    if (_sharedPreferences.getBool("loginSuccess") != null) {
      String user = _sharedPreferences.getString("user");
      constantInfo.setUserInfoValue(loginModelFromJson(user).user);
    }
    if (_sharedPreferences.getBool("loginSuccess") == true) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CommonAndGlobalQuestion()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PublicCommonQuestion()));
    }
  }
  
}
