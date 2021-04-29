import 'package:flutter/material.dart';

class GradientPerso extends BoxDecoration {

  static final FractionalOffset begin = FractionalOffset(0.0, 0.0);
  static final FractionalOffset endHorizontal = FractionalOffset(1.0, 0.0);
  static final FractionalOffset endVertical = FractionalOffset(0.0, 1.0);

  GradientPerso({
    @required Color startCouleur,
    @required Color endCouleur,
    bool horizontal: false,
    double rayon: 0.0 }) : super(
      gradient: LinearGradient(
          colors: [startCouleur, endCouleur],
          begin: begin,
          end: (horizontal) ? endHorizontal : endVertical,
          tileMode: TileMode.clamp
      ),
      borderRadius: BorderRadius.all(Radius.circular(rayon))
  );
}