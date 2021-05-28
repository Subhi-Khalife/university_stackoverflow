import 'package:university/core/entities/user.dart';

class ConstantInfo {
 static ConstantInfo constantInfo =new ConstantInfo();
  User userInfo;
 static ConstantInfo getInstance() {
    
    return constantInfo;
  }

  void setUserInfoValue(User info) {
    userInfo = info;
  }
}
