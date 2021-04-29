import 'utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_network/view/material_perso.dart';

class Publication {

  DocumentReference ref;
  String documentID;
  String id;
  String texte;
  String idUtilisateur;
  String urlImage;
  String stringId;
  int date;
  List<dynamic> pouceBleus;
  List<dynamic> pouceRouges;
  List<dynamic>commentaires;
  Utilisateur utilisateur;

  Publication( DocumentSnapshot snapshot) {
    ref = snapshot.reference;
    documentID = snapshot.documentID;
    Map<String, dynamic> map = snapshot.data;
    id=map[publicationIdKey];
    texte=map[texteKey];
    idUtilisateur = map[idKey];
    urlImage =map[imageKey];
    pouceBleus = map[pbKey];
    pouceRouges = map[prKey];
    commentaires=map[commentaireKey];
    date=map[dateKey];
  }

  Map<String, dynamic> transformerEnMap() {
    Map<String, dynamic> map= {
      publicationIdKey :id,
      idKey:idUtilisateur,
      dateKey:date,
      pbKey:pouceBleus,
      prKey:pouceRouges,
      commentaireKey:commentaires,
    };
    if (texte != null){
      map[texteKey] = texte;
    }
    if (urlImage != null){
      map[imageKey] = urlImage;
    }
    return map;

  }
}