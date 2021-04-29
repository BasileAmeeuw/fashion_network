import 'package:flutter/material.dart';
import 'constantes.dart';

class ItemBarre extends IconButton {

  ItemBarre({@required Icon icon, @required VoidCallback onPressed, @required bool selected}):super(
    icon:icon,
    onPressed: onPressed,
    color: selected ? Colors.deepPurple : rouge,
  );
}

