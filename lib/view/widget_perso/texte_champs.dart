import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:flutter/services.dart';

class TexteChamps extends TextField {
  TexteChamps({
    @required TextEditingController controller,
    keyboardType: TextInputType.multiline,
    maxLines: null,
    expands: true,
    TextInputType type: TextInputType.text,
    String hint: "",
    Icon icon,
    bool obscure: false
  }): super(
    controller: controller,
    keyboardType: type,
    obscureText: obscure,
    decoration: InputDecoration(
      hintText: hint,
      icon: icon,
    )
  );
}