import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/classes/utilisateur.dart';

class Parametres extends StatefulWidget {


  _EtatParametres createState() => _EtatParametres();

}

class _EtatParametres extends State<Parametres> {

  @override
  Widget build(BuildContext context) {
    //TODO
    return Center(child: TextePerso("parametre", color:bleuFonce));
  }
}