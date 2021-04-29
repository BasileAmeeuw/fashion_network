import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';

class TextePerso extends Text {
  TextePerso(data,{
    keyboardType: TextInputType.multiline,
    maxLines: null,
    alignment: TextAlign.center,
    double fontSize: 16.0,
    FontStyle style: FontStyle.normal,
    Color color: blanc
  }):super (
    data,
    textAlign: alignment,
    style:TextStyle(
      fontSize: fontSize,
      fontStyle: style,
      color: color
    )
  );
}