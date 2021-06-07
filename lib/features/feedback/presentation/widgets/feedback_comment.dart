import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:university/core/widget/app_bar.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/container_app_decoration.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/core/widget/text_field_app.dart';
import 'package:university/features/feedback/presentation/bloc/bloc/feedback_bloc.dart';

class HomePage extends StatefulWidget {
  final Function onPressed;

  const HomePage({Key key, this.onPressed}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var myFeedbackText = "COULD BE BETTER";
  var sliderValue = 0.0;
  TextEditingController _nameController;
  IconData myFeedback = FontAwesomeIcons.sadTear;
  Color myFeedbackColor = Colors.red;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appBar(
          context: context,
          centerTitle: false,
          widget: Text(
            "Feedback",
            style: boldStyle(
                color: Theme.of(context).hintColor,
                fontSize: Constant.mediumFont),
          )),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    child: Text(
                  "1. On a scale of 1 to 10, how happy are you at work?",
                  style: boldStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: Constant.largeFont,
                  ),
                )),
              ),
            ),
            Container(
              child: Align(
                child: Container(
                    width: 350.0,
                    height: 350.0,
                    child: Card(
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Text(
                              myFeedbackText,
                              style: TextStyle(
                                  color:firstColor, fontSize: 22.0),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Icon(
                              myFeedback,
                              color: myFeedbackColor,
                              size: 80.0,
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Slider(
                                min: 0.0,
                                max: 10.0,
                                divisions: 5,
                                value: sliderValue,
                                activeColor: Theme.of(context).primaryColor,
                                inactiveColor: firstColor,
                                onChanged: (newValue) {
                                  setState(() {
                                    sliderValue = newValue;
                                    if (sliderValue >= 0.0 &&
                                        sliderValue <= 2.0) {
                                      myFeedback = FontAwesomeIcons.sadTear;
                                      myFeedbackColor = Colors.red;
                                      myFeedbackText = "COULD BE BETTER";
                                    }
                                    if (sliderValue >= 2.1 &&
                                        sliderValue <= 4.0) {
                                      myFeedback = FontAwesomeIcons.frown;
                                      myFeedbackColor = Colors.yellow;
                                      myFeedbackText = "BELOW AVERAGE";
                                    }
                                    if (sliderValue >= 4.1 &&
                                        sliderValue <= 6.0) {
                                      myFeedback = FontAwesomeIcons.meh;
                                      myFeedbackColor = Colors.amber;
                                      myFeedbackText = "NORMAL";
                                    }
                                    if (sliderValue >= 6.1 &&
                                        sliderValue <= 8.0) {
                                      myFeedback = FontAwesomeIcons.smile;
                                      myFeedbackColor = Colors.green;
                                      myFeedbackText = "GOOD";
                                    }
                                    if (sliderValue >= 8.1 &&
                                        sliderValue <= 10.0) {
                                      myFeedback = FontAwesomeIcons.laugh;
                                      myFeedbackColor = Colors.pink;
                                      myFeedbackText = "EXCELLENT";
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextFieldApp(
                      controller: _nameController,
                      hintColor: firstColor,
                      isTextFieldPassword: false,
                      hintText: "Enter Question title",colorText: firstColor,
                    ),
                  ),
                          // Padding(
                          //   padding: const EdgeInsets.all(12.0),
                          //   child: Container(
                          //     child: TextFieldApp(
                          //       hintText: "Enter you Feedback",
                          //       controller: _nameController,
                          //       isLookAtPassword: false,
                          //       maxLength: 3,
                          //       isTextFieldPassword: false,
                          //     ),
                              
                          //     // TextField(
                          //     //   decoration: new InputDecoration(
                          //     //     border: new OutlineInputBorder(
                          //     //         borderSide: new BorderSide(
                          //     //             color: Colors.blueGrey)),
                          //     //     hintText: 'Add Comment',
                          //     //   ),
                          //     //   style: TextStyle(height: 3.0),
                          //     // ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Align(
                              alignment: Alignment.bottomRight,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                                onPressed: () {
                                  BlocProvider.of<FeedbackBloc>(context)
                                    ..add(
                                      SendingFeedbackEvent(
                                          email: "hiro@hiro.com",
                                          message: _nameController.text,
                                          name: myFeedbackText),
                                    );
                                },
                              ),
                            )),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
