import 'package:flutter/material.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/fonts.dart';


class AuthButton extends StatelessWidget {
String text;
var tap;
Color color;
   AuthButton({
    Key? key,
    this.color = const Color.fromARGB(255, 32, 112, 100),
    required this.text,
     this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          color: ColorManager.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: DText(color: ColorManager.textColorWhite, text: text, weight: FontWeightManager.bold, size: FontSize.s20)),
      ),
    );
  }
}

class AuthTextBox extends StatelessWidget {
    IconData? icon;
    int? maxlength;
    TextInputType? type;
    String labelText;
    bool hide;
    var tap;
    var validation;
    int maxLines;
    bool readO;
    TextEditingController? controller;
   AuthTextBox({
    Key? key,
    this.type,
    this.maxlength,
    this.readO=false,
    this.validation,
    this.controller,
    this.icon,
    this.maxLines = 1,
    this.tap,
     this.hide = false,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      readOnly: readO,
      controller: controller,
      validator: validation,
              cursorColor: ColorManager.primaryColor,
              obscureText: hide,
              keyboardType: type,
              maxLength: maxlength,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: tap,
                  child: Icon(icon)),
                labelText: labelText,
                labelStyle: TextStyle(
                  color: ColorManager.primaryColor
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 4,
                    color: ColorManager.primaryColor
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 2,
                    color: ColorManager.primaryColor
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: ColorManager.primaryColor
                  )
                )
              ),
            );
  }
}


class DText extends StatelessWidget {
  TextAlign align;
  int? lines;
String text;
FontWeight weight;
double size;
Color color;
   DText({
    Key? key,
    this.lines,
    this.align=TextAlign.start,
    required this.color,
    required this.text,
    required this.weight,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.clip,
      textAlign: align,
      maxLines: lines,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight
      ),
    );
  }
}