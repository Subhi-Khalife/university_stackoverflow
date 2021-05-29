import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:university/core/widget/colors.dart';
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
      appBar: AppBar(
        backgroundColor: colorSecondGrident,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //
            }),
        title: Text("Feedback"),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.solidStar),
              onPressed: () {
                //
              }),
        ],
      ),
      body: Container(
        color: colorFirstGrident,
        child: ListView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    child: Text(
                  "1. On a scale of 1 to 10, how happy are you at work?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Container(
              child: Align(
                child: Material(
                  color: colorSecondGrident,
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child: Container(
                      width: 350.0,
                      height: 400.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Text(
                              myFeedbackText,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.0),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Icon(
                              myFeedback,
                              color: myFeedbackColor,
                              size: 100.0,
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
                                activeColor: Color(0xffe05f2c),
                                inactiveColor: Colors.blueGrey,
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
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              child: TextField(
                                decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.blueGrey)),
                                  hintText: 'Add Comment',
                                ),
                                style: TextStyle(height: 3.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Align(
                              alignment: Alignment.bottomRight,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Color(0xffe05f2c),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Color(0xffffffff)),
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
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
