import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadFile extends StatelessWidget {
  final String title;
  final String description;
  final String url;
  const DownloadFile({Key key, this.title, this.description, this.url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: 9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.book_outlined,
                size: 35,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: boldStyle(
                          fontSize: Constant.mediumFont,
                          color: Theme.of(context).accentColor)),
                  SizedBox(height: 4),
                  Text(
                      description.length > 18
                          ? description.substring(0, 18) + "..."
                          : description,
                      style: regularStyle(
                          fontSize: Constant.mediumFont,
                          color: Theme.of(context).hintColor))
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child:
                      IconButton(onPressed: () {
                        // downloadFile(url,title);
                      }, icon: Icon(Icons.download)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  //
  // Future<bool> checkPermission() async {
  //   if (Platform.isAndroid) {
  //     final status = await Permission.storage.status;
  //     if (status != PermissionStatus.granted) {
  //       final result = await Permission.storage.request();
  //       if (result == PermissionStatus.granted) {
  //         return true;
  //       }
  //     } else {
  //       return true;
  //     }
  //   } else {
  //     return true;
  //   }
  //   return false;
  // }
  //
  // static Future<String> findLocalPath() async {
  //   final directory = Platform.isAndroid
  //       ? await getExternalStorageDirectory()
  //       : await getApplicationDocumentsDirectory();
  //   return directory.path;
  // }
  //
  // downloadFile(String url, String fileName) async {
  //   try {
  //     bool _permissionReady = await checkPermission();
  //     if (!_permissionReady) return;
  //     String _localPath =
  //         (await findLocalPath()) + Platform.pathSeparator + 'Download';
  //     print("the _localPath is $_localPath");
  //     final savedDir = Directory(_localPath);
  //     print("the _localPath is 1$_localPath");
  //     bool hasExisted = await savedDir.exists();
  //     if (!hasExisted) {
  //       savedDir.create();
  //     }
  //     print("the _localPath is 2$_localPath");
  //     await FlutterDownloader.enqueue(
  //       url:url,
  //       savedDir: _localPath,
  //       fileName: fileName,
  //       showNotification:
  //           true, // show download progress in status bar (for Android)
  //       openFileFromNotification:
  //           true, // click on notification to open downloaded file (for Android)
  //     );
  //   } catch (e) {
  //     print("the error insoder file donwlaod is $e");
  //   }
  // }
}
