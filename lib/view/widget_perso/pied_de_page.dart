import 'package:flutter/material.dart';
import 'constantes.dart';

class PiedDePage extends BottomAppBar {

  PiedDePage({@required List<Widget> items}): super(
      color:rosePale,
      shape:CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: items,
      )
  );
}