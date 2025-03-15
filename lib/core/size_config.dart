import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    defaultSize = screenWidth * 0.024;
  }

  static double getProportionateScreenHeight(double input) {
    return (input / 812.0) * screenHeight;
  }

  static double getProportionateScreenWidth(double input) {
    return (input / 375.0) * screenWidth;
  }
}
