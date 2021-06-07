import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/features/advertisement/presentation/bloc/bloc/advertisment_bloc.dart';
import 'package:university/features/rate/presentation/bloc/bloc/rate_bloc.dart';

class StarFeedback extends StatefulWidget {
  @override
  _StarFeedbackState createState() => _StarFeedbackState();
}

class _StarFeedbackState extends State<StarFeedback> {
  var myFeedbackText = "COULD BE BETTER";
  var sliderValue = 0.0;
  IconData myFeedback1 = FontAwesomeIcons.star,
      myFeedback2 = FontAwesomeIcons.star,
      myFeedback3 = FontAwesomeIcons.star,
      myFeedback4 = FontAwesomeIcons.star,
      myFeedback5 = FontAwesomeIcons.star;
  Color myFeedbackColor1 = Colors.grey,
      myFeedbackColor2 = Colors.grey,
      myFeedbackColor3 = Colors.grey,
      myFeedbackColor4 = Colors.grey,
      myFeedbackColor5 = Colors.grey;
  AdvertismentBloc advertismentBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advertismentBloc = AdvertismentBloc();
    advertismentBloc..add(FetchAdvertismentEvent());
  }

  @override
  void dispose() {
    advertismentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: blackWithOpacity,
        child: Column(
          children: <Widget>[
            _myAppBar(),
            Container(
              color: blackWithOpacity,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          child: Text(
                            "1. On a scale of 1 to 5, how do you rate our service?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    child: Align(
                      child: Material(
                        color: colorFirstGrident,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: Color(0x802196F3),
                        child: Container(
                          width: 350.0,
                          height: 300.0,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: starWidget(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Slider(
                                    min: 0.0,
                                    max: 5.0,
                                    divisions: 5,
                                    value: sliderValue,
                                    activeColor: Color(0xffed1e79),
                                    inactiveColor: Colors.blueGrey,
                                    onChanged: (newValue) {
                                      setState(() {
                                        sliderValue = newValue;
                                        if (sliderValue == 1.0) {
                                          myFeedback1 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor1 = Colors.yellow;
                                        } else if (sliderValue < 1.0) {
                                          myFeedback1 = FontAwesomeIcons.star;
                                          myFeedbackColor1 = Colors.grey;
                                        }
                                        if (sliderValue == 2.0) {
                                          myFeedback2 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor2 = Colors.yellow;
                                        } else if (sliderValue < 2.0) {
                                          myFeedback2 = FontAwesomeIcons.star;
                                          myFeedbackColor2 = Colors.grey;
                                        }
                                        if (sliderValue == 3.0) {
                                          myFeedback3 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor3 = Colors.yellow;
                                        } else if (sliderValue < 3.0) {
                                          myFeedback3 = FontAwesomeIcons.star;
                                          myFeedbackColor3 = Colors.grey;
                                        }
                                        if (sliderValue == 4.0) {
                                          myFeedback4 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor4 = Colors.yellow;
                                        } else if (sliderValue < 4.0) {
                                          myFeedback4 = FontAwesomeIcons.star;
                                          myFeedbackColor4 = Colors.grey;
                                        }
                                        if (sliderValue == 5.0) {
                                          myFeedback5 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor5 = Colors.yellow;
                                        } else if (sliderValue < 5.0) {
                                          myFeedback5 = FontAwesomeIcons.star;
                                          myFeedbackColor5 = Colors.grey;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                    child: Text(
                                  "Your Rating : $sliderValue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(30.0)),
                                      color: Color(0xffed1e79),
                                      child: Text(
                                        'Submit',
                                        style:
                                        TextStyle(color: Color(0xffffffff)),
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<RateBloc>(context)
                                          ..add(
                                            SendingPostRateEvent(
                                              commentId: "2",
                                              postId: "1",
                                              rate: "1",
                                            ),
                                          );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  BlocProvider(
                    create: (context) => advertismentBloc,
                    child: BlocBuilder<AdvertismentBloc, AdvertismentState>(
                      builder: (context, state) {
                        if (state is SuccessGettingAdsState) {
                          final successAds = state.advertisementModel.data;
                          return Container(
                            height: 100,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 2,
                            child: Swiper(
                              itemCount: successAds.length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  successAds[index].imageUrl,
                                  fit: BoxFit.fitWidth,
                                );
                              },
                            ),
                          );
                        } else {
                          return Container(
                            color: Colors.red,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> starWidget() {
    List<Widget> myContainer = new List();
    myContainer.add(Container(
        child: Icon(
      myFeedback1,
      color: myFeedbackColor1,
      size: 50.0,
    )));
    myContainer.add(Container(
        child: Icon(
      myFeedback2,
      color: myFeedbackColor2,
      size: 50.0,
    )));
    myContainer.add(
      Container(
        child: Icon(
          myFeedback3,
          color: myFeedbackColor3,
          size: 50.0,
        ),
      ),
    );
    myContainer.add(
      Container(
        child: Icon(
          myFeedback4,
          color: myFeedbackColor4,
          size: 50.0,
        ),
      ),
    );
    myContainer.add(
      Container(
        child: Icon(
          myFeedback5,
          color: myFeedbackColor5,
          size: 50.0,
        ),
      ),
    );
    return myContainer;
  }

  Widget _myAppBar() {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            colorThemApp,
            colorFirstGrident,
          ],
          begin: Alignment.centerRight,
          end: new Alignment(-1.0, -1.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Text(
                    'Rate',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.star,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
