import 'package:flutter/material.dart';

class ColorManager{
  static Color primaryColor= HexColor.fromHex("#9F2B68"); 
  static Color textColorWhite = HexColor.fromHex("#FEF5F5"); 
  static Color textColorBlack = HexColor.fromHex("#000000"); 
  static Color subjectColor = HexColor.fromHex("#1E7CD2"); 
  static Color boxGreen = HexColor.fromHex("#AA336A"); 
  static Color boxBlue = HexColor.fromHex("#1E7CD2"); 
  static Color boxDarkGreen = HexColor.fromHex("#236A21"); 
  static Color splashPage = HexColor.fromHex("#50EDFE"); 
  static Color backgroundColor = HexColor.fromHex("#000000");

  
}
extension HexColor on Color{
  static Color fromHex(String hexColorString){
    hexColorString=hexColorString.replaceAll('#', '');
    if(hexColorString.length==6){
      hexColorString='FF$hexColorString';
    }
    return Color(int.parse(hexColorString,radix:16));
  }
}