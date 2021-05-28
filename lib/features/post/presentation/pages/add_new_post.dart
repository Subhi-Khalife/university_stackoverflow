import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/app_button.dart';
import 'package:university/core/widget/text_field_app.dart';
import 'package:university/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:university/features/post/presentation/widget/text_editor.dart';

class AddNewPostScreen extends StatefulWidget {
  AddNewPostScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddNewPostScreen createState() => _AddNewPostScreen();
}

class _AddNewPostScreen extends State<AddNewPostScreen> {
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
  final _scaffoldState = GlobalKey<ScaffoldState>();
  String result = "";
  TextEditingController _controller = TextEditingController();
  PostBloc postBloc;
  FlutterSummernote flutterSummernote;
  @override
  void initState() {
    super.initState();
    postBloc = PostBloc();
    flutterSummernote = FlutterSummernote(
      hint: "Your text here...",
      key: _keyEditor,
      customToolbar: """
          [
              ['style', ['bold', 'italic', 'underline', 'clear']],
              ['font', ['strikethrough', 'superscript', 'subscript']],
              ['insert', ['link', 'table', 'hr']]
          ]
        """,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        backgroundColor: Colors.white,
        body: BlocProvider<PostBloc>(
          create: (context) => postBloc,
          child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextFieldApp(
                      controller: _controller,
                      isTextFieldPassword: false,
                      hintText: "Enter Question title",
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: flutterSummernote),
                  AppButton(
                      function: () async {
                        String values = await _keyEditor.currentState.getText();
                        List<String> image =
                            _keyEditor.currentState.getImageList();
                        for (int i = 0; i < image.length; i++) {
                          String x =
                              "<img alt='Google' src='${image[i]}' /><br />";
                          values += x;
                        }
                        postBloc.add(AddNewPost(
                            description: values,
                            tapID: _keyEditor.currentState.getTapsId(),
                            title: _controller.text));
                      },
                      name: "Save Post")
                ],
              );
            },
          ),
        ));
  }
}
/*
  String result = "";

  Map<String, CustomRender> getCustomRender() {
    var customRender = HashMap<String, CustomRender>();
    customRender["img"] = getImageCustomRender;
    return customRender;
  }

// create customRender for asset images
  Widget getImageCustomRender(RenderContext context, Widget parsedChild,
      Map<String, String> attributes, dom.Element element) {
    return new Image.network(
        "https://www.google.com/images${attributes["src"]}");
  }

  Widget build(BuildContext context) {
    Widget html = Html(
      data: """
           <img alt='Google' src='/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />  """,
      customRender: getCustomRender(),
    );
    */
