library flutter_summernote;

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:university/core/entities/search_model.dart';
import 'package:university/core/widget/app_button.dart';
import 'package:university/core/widget/cached_newtwok_image_view.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/container_app_decoration.dart';
import 'package:university/core/widget/drop_down_text_field.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/core/widget/loading_dialog.dart';
import 'package:university/core/widget/search_dialog.dart';
import 'package:university/core/widget/show_message.dart';
import 'package:university/features/general_question/data/models/filter_model.dart';
import 'package:university/features/general_question/data/models/year_semester_model.dart';
import 'package:university/features/general_question/presentaion/bloc/bloc/general_question_bloc.dart';
import 'package:university/features/post/data/models/taps_model.dart';
import 'package:university/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:university/features/post/presentation/bloc/tabs/tabs_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterSummernote extends StatefulWidget {
  final String value;
  final double height;
  final BoxDecoration decoration;
  final String widthImage;
  final String hint;
  final String customToolbar;

  FlutterSummernote(
      {Key key,
      this.value,
      this.height,
      this.decoration,
      this.widthImage: "100%",
      this.hint,
      this.customToolbar})
      : super(key: key);

  @override
  FlutterSummernoteState createState() => FlutterSummernoteState();
}

class FlutterSummernoteState extends State<FlutterSummernote> {
  TextEditingController _tagsController = TextEditingController();
  WebViewController _controller;
  List<String> images = [];
  String text = "";
  FilterModel filterModel = FilterModel();
  YearSemesterModel yearSemesterModel = YearSemesterModel();
  String _page;
  LoadingDialog loadingDialog;
  final Key _mapKey = UniqueKey();
  final _imagePicker = ImagePicker();
  int tagsId;
  PostBloc postBloc;
  TabsBloc tabsBloc;
  void handleRequest(HttpRequest request) {
    try {
      if (request.method == 'GET' && request.uri.queryParameters['query'] == "getRawTeXHTML") {
      } else {}
    } catch (e) {
      print('Exception in handleRequest: $e');
    }
  }

  int tabsId = -1;
  @override
  void initState() {
    super.initState();
    _page = _initPage(widget.customToolbar);
    postBloc = PostBloc();
    _tagsController.text = "Select tags";
    loadingDialog = LoadingDialog(context);
    tabsBloc = TabsBloc();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _getImage(bool fromCamera) async {
      final picked = await _imagePicker.getImage(
          source: (fromCamera) ? ImageSource.camera : ImageSource.gallery);
      if (picked != null) {
        loadingDialog.show(context);
        postBloc.add(UploadImage(imageFile: File(picked.path)));
      } else {
        return null;
      }
    }

    void _attach(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
                subtitle: Text("Attach image from camera"),
                onTap: () async {
                  Navigator.pop(context);
                  await _getImage(true);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Gallery"),
                subtitle: Text("Attach image from gallery"),
                onTap: () async {
                  Navigator.pop(context);
                  await _getImage(false);
                },
              ),
            ], mainAxisSize: MainAxisSize.min);
          });
    }

    return Container(
      height: widget.height ?? MediaQuery.of(context).size.height,
      decoration: widget.decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: Color(0xffececec), width: 1),
          ),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            child: WebView(
              key: _mapKey,
              onWebResourceError: (e) {
                print("error ${e.description}");
              },
              onWebViewCreated: (webViewController) {
                _controller = webViewController;
                final String contentBase64 = base64Encode(const Utf8Encoder().convert(_page));
                _controller.loadUrl('data:text/html;base64,$contentBase64');
              },
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              gestureRecognizers: [
                Factory(() => VerticalDragGestureRecognizer()..onUpdate = (_) {}),
              ].toSet(),
              javascriptChannels: <JavascriptChannel>[getTextJavascriptChannel(context)].toSet(),
              onPageFinished: (String url) {
                if (widget.hint != null) {
                  setHint(widget.hint);
                } else {
                  setHint("");
                }
                setFullContainer();
                if (widget.value != null) {
                  setText(widget.value);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
              left: 16.0,
            ),
            child: Row(children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () => _attach(context),
                  child: Row(
                      children: <Widget>[Icon(Icons.attach_file), Text("Attachments")],
                      mainAxisAlignment: MainAxisAlignment.center),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    String data = await getText();
                    Clipboard.setData(new ClipboardData(text: data));
                  },
                  child: Row(
                      children: <Widget>[Icon(Icons.content_copy), Text("Copy")],
                      mainAxisAlignment: MainAxisAlignment.center),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);

                    String txtIsi = data.text
                        .replaceAll("'", '\\"')
                        .replaceAll('"', '\\"')
                        .replaceAll("[", "\\[")
                        .replaceAll("]", "\\]")
                        .replaceAll("\n", "<br/>")
                        .replaceAll("\n\n", "<br/>")
                        .replaceAll("\r", " ")
                        .replaceAll('\r\n', " ");
                    String txt = "\$('.note-editable').append( '" + txtIsi + "');";
                    _controller.evaluateJavascript(txt);
                  },
                  child: Row(
                      children: <Widget>[Icon(Icons.content_paste), Text("Paste")],
                      mainAxisAlignment: MainAxisAlignment.center),
                ),
              )
            ]),
          ),
          BlocProvider<PostBloc>(
            create: (context) => postBloc,
            child: BlocListener<PostBloc, PostState>(
                listener: (context, state) {
                  if (state is SuccessUploadImage) {
                    loadingDialog.dismiss(context);
                    images.add(state.image);
                    showMessage("Success Upload Image");
                  } else if (state is FailedUploadImage) {
                    loadingDialog.dismiss(context);

                    showMessage("Failed Upload Image Try Again");
                  } else if (state is RemoveImageFromlist) {
                    images.removeAt(state.index);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Your Images",
                            style: TextStyle(color: colorThemApp, fontSize: Constant.largeFont),
                          ),
                          Container(
                            width: 200,
                            child: DropDownTextField(
                              handleTap: () {
                                beginBottomSheet().then((value) {
                                  if (value != null) {
                                    _tagsController.text = value["subject"];
                                    tabsId = value["id"];
                                    print("the tabs tabsIdis $tabsId");
                                  }
                                });
                              },
                              controller: _tagsController,
                              hintText: _tagsController.text,
                              errorText: "",
                              color: colorThemApp,
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<PostBloc, PostState>(
                        builder: (context, state) {
                          if (images.length == 0) {
                            return Center(
                              child: Text(
                                "No image selected yet",
                                style: boldStyle(fontSize: Constant.largeFont, color: firstColor),
                              ),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child: Card(
                                          color: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(18),
                                            ),
                                          ),
                                          child: CachedNetworkImageView(
                                            url: images[index],
                                            witRaduis: true,
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white60.withOpacity(0.7),
                                        child: IconButton(
                                            icon: Icon(Icons.clear, color: Colors.black),
                                            onPressed: () {
                                              postBloc.add(RemoveImageFromlistEvent(index: index));
                                            }),
                                      )
                                    ],
                                  );
                                },
                                itemCount: images.length,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  Future beginBottomSheet() {
    GeneralQuestionBloc generalQuestionBloc = GeneralQuestionBloc();
    TextEditingController semanticController = TextEditingController();
    TextEditingController yearController = TextEditingController();
    TextEditingController subJectController = TextEditingController();
    LoadingDialog loadingDialog = LoadingDialog(context);
    YearSemesterModel yearSemesterModel = YearSemesterModel();
    int semanticId = -1;
    int yearsId = -1;
    int subjectId = -1;
    bool showSemantic = true;
    Map<String, dynamic> param = {
      "subject": "",
      "id": -1,
    };
    void _handleGetAllSemantic() {
      List<SearchModel> seachItems = [];
      seachItems.clear();
      for (int i = 0; i < filterModel.data.semesters.length; i++) {
        seachItems.add(SearchModel(
          id: filterModel.data.semesters[i].id,
          name: filterModel.data.semesters[i].semester,
        ));
      }
      showDialog(
          context: context,
          builder: (context) => SearchDialog(
                data: seachItems,
              )).then(
        (val) {
          if (val != null) {
            print("the  value si seachItems[val].name ${seachItems[val].name}");
            semanticController.text = seachItems[val].name;
            semanticId = seachItems[val].id;
          }
        },
      );
    }

    void _handleGetAllYears() {
      List<SearchModel> seachItems = [];
      seachItems.clear();
      for (int i = 0; i < filterModel.data.years.length; i++) {
        seachItems.add(SearchModel(
          id: filterModel.data.years[i].id,
          name: filterModel.data.years[i].name,
        ));
      }
      showDialog(
          context: context,
          builder: (context) => SearchDialog(
                data: seachItems,
              )).then(
        (val) {
          if (val != null) {
            yearController.text = seachItems[val].name;
            yearsId = seachItems[val].id;
          }
        },
      );
    }

    void _handleGetAllSubjects() {
      List<SearchModel> seachItems = [];
      seachItems.clear();
      for (int i = 0; i < yearSemesterModel.data.length; i++) {
        seachItems.add(SearchModel(
          id: yearSemesterModel.data[i].id,
          name: yearSemesterModel.data[i].name,
        ));
      }
      showDialog(
          context: context,
          builder: (context) => SearchDialog(
                data: seachItems,
              )).then(
        (val) {
          if (val != null) {
            subJectController.text = seachItems[val].name;
            subjectId = seachItems[val].id;
            param["subject"] = seachItems[val].name;
            param["id"] = seachItems[val].id;
          }
        },
      );
    }

    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      enableDrag: true,
      builder: (BuildContext context) {
        return BlocProvider<GeneralQuestionBloc>.value(
          value: generalQuestionBloc,
          child: BlocListener<GeneralQuestionBloc, GeneralQuestionState>(
            listener: (context, state) {
              if (state is LoadingStateGeneralQuestion) {
                loadingDialog.show(context);
              } else if (state is SuccessGetAllFilter) {
                loadingDialog.dismiss(context);
                filterModel = state.filterModel;
                if (showSemantic)
                  _handleGetAllSemantic();
                else
                  _handleGetAllYears();
              } else if (state is SuccessGetAllYearSemantic) {
                yearSemesterModel = state.searSemesterModel;
                loadingDialog.dismiss(context);
                _handleGetAllSubjects();
              } else {
                loadingDialog.dismiss(context);
                showMessage("error happened try again");
              }
            },
            child: BlocBuilder<GeneralQuestionBloc, GeneralQuestionState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: containerDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropDownTextField(
                              hintText: 'select your year',
                              errorText: "",
                              handleTap: () {
                                showSemantic = false;
                                generalQuestionBloc.add(GetFilters());
                              },
                              color: Theme.of(context).hintColor,
                              controller: yearController,
                            ),
                            DropDownTextField(
                              hintText: 'select your sematic',
                              errorText: "",
                              handleTap: () {
                                showSemantic = true;
                                generalQuestionBloc.add(GetFilters());
                              },
                              color: Theme.of(context).hintColor,
                              controller: semanticController,
                            ),
                            DropDownTextField(
                              hintText: 'select your Subject',
                              errorText: "",
                              handleTap: () {
                                if (yearsId == -1)
                                  showMessage("please add years");
                                else if (semanticId == -1)
                                  showMessage("please add semester");
                                else {
                                  generalQuestionBloc.add(
                                      GetYearSemester(semesterId: semanticId, yearId: yearsId));
                                }
                              },
                              color: Theme.of(context).hintColor,
                              controller: subJectController,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppButton(
                                function: () {
                                  Navigator.of(context).pop(param);
                                },
                                name: "save subject",
                                fontColor: Theme.of(context).accentColor,
                              ),
                            )
                          ],
                        )),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  JavascriptChannel getTextJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'GetTextSummernote',
        onMessageReceived: (JavascriptMessage message) {
          String isi = message.message;
          if (isi.isEmpty || isi == "<p></p>" || isi == "<p><br></p>" || isi == "<p><br/></p>") {
            isi = "";
          }
          setState(() {
            text = isi;
          });
        });
  }

  Future<String> getText() async {
    await _controller.evaluateJavascript(
        "GetTextSummernote.postMessage(document.getElementsByClassName('note-editable')[0].innerHTML);");
    return text;
  }

  setText(String v) async {
    String txtIsi = v
        .replaceAll("'", '\\"')
        .replaceAll('"', '\\"')
        .replaceAll("[", "\\[")
        .replaceAll("]", "\\]")
        .replaceAll("\n", "<br/>")
        .replaceAll("\n\n", "<br/>")
        .replaceAll("\r", " ")
        .replaceAll('\r\n', " ");
    String txt =
        "document.getElementsByClassName('note-editable')[0].innerHTML = '" + txtIsi + "';";
    _controller.evaluateJavascript(txt);
  }

  setFullContainer() {
    _controller.evaluateJavascript('\$("#summernote").summernote("fullscreen.toggle");');
  }

  setFocus() {
    _controller.evaluateJavascript("\$('#summernote').summernote('focus');");
  }

  setEmpty() {
    _controller.evaluateJavascript("\$('#summernote').summernote('reset');");
  }

  setHint(String text) {
    String hint = '\$(".note-placeholder").html("$text");';
    _controller.evaluateJavascript(hint);
  }

  Widget widgetIcon(IconData icon, String title, {Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.black38,
            size: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              title,
              style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  String _initPage(String customToolbar) {
    String toolbar;
    if (customToolbar == null) {
      toolbar = _defaultToolbar;
    } else {
      toolbar = customToolbar;
    }

    return '''
    <!DOCTYPE html>
    <html lang="en">
    <head>
    <base href="www.google.com">
    </head>
    <head>
    <meta name="viewport" content="user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Summernote</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
    </head>
    <body>
    <div id="summernote" contenteditable="true"></div>
    <script type="text/javascript">
      \$("#summernote").summernote({
        placeholder: 'Your text here...',
        tabsize: 2,
        toolbar: $toolbar
      });
    </script>
    </body>
    </html>
    ''';
  }

  String _defaultToolbar = """
    [
      ['style', ['bold', 'italic', 'underline', 'clear']],
      ['font', ['strikethrough', 'superscript', 'subscript']],
      ['font', ['fontsize', 'fontname']],
      ['color', ['forecolor', 'backcolor']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['height', ['height']],
      ['view', ['fullscreen']]
    ]
  """;

  // void _addImage(File image) async {
  //   String filename = basename(image.path);
  //   List<int> imageBytes = await image.readAsBytes();
  //   String base64Image =
  //       "<img width=\"${widget.widthImage}\" src=\"data:image/png;base64, "
  //       "${base64Encode(imageBytes)}\" data-filename=\"$filename\">";

  //   String txt = "\$('.note-editable').append( '" + base64Image + "');";
  //   _controller.evaluateJavascript(txt);
  // }
  List<String> getImageList() {
    return images;
  }

  int getTapsId() {
    return tabsId;
  }
}
