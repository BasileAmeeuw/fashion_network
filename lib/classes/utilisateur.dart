import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_network/view/widget_perso/constantes.dart';

class Utilisateur {

  String id;
  String pseudo;
  String imageUrl;
  List<dynamic> abonnes;
  List<dynamic> abonnements;
  DocumentReference reference;
  String documentId;
  String aPropos;

  Utilisateur(DocumentSnapshot snapshot) {
    reference = snapshot.reference;
    documentId = snapshot.documentID;
    Map<String, dynamic> map = snapshot.data;
    id = map[idKey];
    pseudo = map[pseudoKey];
    abonnes = map[abonnesKey];
    abonnements = map[abonnementsKey];
    imageUrl = map[imageKey];
    aPropos = map[aProposKey];
  }

  Map<String, dynamic> transformerEnMap(){
    return{
      idKey:id,
      pseudoKey:pseudo,
      imageKey:imageUrl,
      abonnesKey:abonnes,
      abonnementsKey:abonnements,
      aProposKey:aPropos,
    };
  }
}