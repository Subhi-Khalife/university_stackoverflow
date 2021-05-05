import 'package:flutter/material.dart';
import 'package:university/features/common_question/presentation/pages/public_common_question.dart';
import 'package:university/features/login/presentation/pages/login_screen.dart';

class MainScreenDialog extends StatelessWidget {
  static const double padding = 20;
  static const double avatarRadius = 45;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to our Application"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return contentBox(
                    context,
                  );
                },
              );
            },
            child: Text("Start"),
          ),
        ),
      ),
    );
  }

  contentBox(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: padding + 20,
              top: avatarRadius + padding,
              right: padding + 10,
              bottom: padding,
            ),
            margin: EdgeInsets.only(top: avatarRadius),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(padding),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Where do u wanna go ?",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PublicCommonQuestion(),
                      ),
                    );
                  },
                  child: Text(
                    "CommonQuestion",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Login/SignUp",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ), // bottom part
          Positioned(
            left: padding,
            right: padding + 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: avatarRadius,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(avatarRadius)),
                  child: Image.asset("assets/model.jpeg")),
            ),
          ), // top part
        ],
      ),
    );
  }
}
