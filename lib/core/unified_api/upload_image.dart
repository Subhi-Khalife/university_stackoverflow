import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:university/core/entities/upload_image_model.dart';
import 'package:university/core/unified_api/initial_api.dart';
import 'package:university/features/post/domain/usecases/upload_image.dart';

class UploadImageApi extends InitialApi {
  File file;
  String token;
  UploadImageApi({
    @required this.file,
    @required this.token,
  }) : super(
          requestName: "",
          url: "",
          token: token,
        );

  @override
  Future<String> callRequest() async {
    var url = baseURL + "media/upload";
    try {
      var dir = await path_provider.getTemporaryDirectory();
      var image = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        dir.absolute.path + "/temp.jpg",
        quality: 60,
        minWidth: 640,
        minHeight: 480,
      );
      file = image;
      var stream = new http.ByteStream(DelegatingStream(file.openRead()));
      var length = await file.length();
      var uri = Uri.parse(url);
      var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile(
        'file',
        stream,
        length,
        filename: basename(file.path),
      );
      // request.fields['type'] = imageType;
      request.headers.addAll(header);
      request.files.add(multipartFile);
      http.StreamedResponse response =
          await request.send().timeout(Duration(seconds: 300));
      String data = "";
   String x=  await response.stream.transform(utf8.decoder).single ;
   UploadImageModel uploadImageModel=uploadImageModelFromJson(x);
   if(uploadImageModel.status=='OK'){
     return uploadImageModel.data;
   }else{
      throw getException(statusCode: response.statusCode);
   }
   print("the x value is $x");
    } catch (exception) {
      throw (exception);
    }
  }
}
