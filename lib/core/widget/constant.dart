import 'dart:io';
import 'package:flutter/material.dart';

class Constant {
  static final String baseUrl = 'http://food.404developers.com/';
  static double verySmallFont;
  static double veryVerySmallFont;
  static double smallFont;
  static double mediumFont;
  static double largeFont;
  static double xlargeFont;
  static double cardHeight;
  static TextStyle style;
  static String restaurantId = "1";
  static double drawerMaxSlide = 60;
  static bool isSwitchAllowNotification;
  static String deviceId = "";
  static String firebaseToken = "";
  static String verificationPhoneId = "";

  static double converPercent(double values, double percentValues) {
    double convertValues = values.toDouble();
    print("The old values  is :: $convertValues ");

    print(
        "the percent is :: ${convertValues - (convertValues * (percentValues / 100))}");
    return (convertValues - (convertValues * (percentValues / 100))).toDouble();
  }

  static Map<String, String> getHeader(dynamic token) {
    Map<String, String> header = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json"
    };
    return header;
  }
}
