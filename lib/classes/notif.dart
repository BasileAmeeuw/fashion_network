import 'utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/outils/date_arrangement.dart';

class Notif {

  DocumentReference notifRef;
  String texte;
  String date;
  String idUtilisateur;
  DocumentReference reference;
  bool vu;
  String type;

  Notif(DocumentSnapshot snap){
    notifRef = snap.reference;
    Map<String, dynamic> map = snap.data;
    texte = map[texteKey];
    date=DateArrangement().maDate(map[dateKey]);
    idUtilisateur=map[idKey];
    reference=map[refKey];
    vu=map[vuKey];
    type=map[typeKey];

  }

}