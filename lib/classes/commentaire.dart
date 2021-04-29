import 'utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/outils/date_arrangement.dart';

class Commentaire {
  String idUtilisateur;
  String texte;
  String date;

  Commentaire(Map<dynamic, dynamic> map){
    idUtilisateur = map[idKey];
    texte=map[texteKey];
    date=DateArrangement().maDate(map[dateKey]);
  }
}