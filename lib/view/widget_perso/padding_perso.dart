import 'package:flutter/material.dart';

class PaddingPerso extends Padding {

  PaddingPerso({
    @required Widget widget,
    double haut: 10.0,
    double gauche: 0.0,
    double droite: 0.0,
    double bas: 0.0,}): super(
    padding: EdgeInsets.only(
      top:haut,
      left:gauche,
      right:droite,
      bottom:bas
    ),
    child: widget
  );
}