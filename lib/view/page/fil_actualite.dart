import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:fashion_network/view/tile/tile_publi.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/classes/publication.dart';
import 'package:fashion_network/classes/utilisateur.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';

class FilActualite extends StatefulWidget {


  _EtatFilActu createState() => _EtatFilActu();

}

class _EtatFilActu extends State<FilActualite> {

  StreamSubscription subscription;
  List<Publication> publis = [];
  List<Utilisateur> utilisateurs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscriptionInitialisation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO
    return NestedScrollView(
        headerSliverBuilder: (BuildContext ctxBuild, bool scrolled) {
      return [
        EntetePerso(titre: "Fil d'actualité")
      ];},
        body: ListView.builder(
          itemCount: publis.length,
          itemBuilder: (BuildContext context, int index) {
            Publication publi = publis[index];
            Utilisateur uti = utilisateurs.singleWhere((u) => u.id == publi.idUtilisateur);
            return TilePubli(publi: publi, utilisateur: uti);
          }
        )
    );
  }

  subscriptionInitialisation(){
    subscription = FirebaseUtilisateur().userFirestore.where(abonnesKey, arrayContains: moi.id).snapshots().listen((data) {
      recupererUtilisateurs(data.documents);
      data.documents.forEach((docs) {
        docs.reference.collection("Publications").snapshots().listen((publi) {
          recupererPublis(publi.documents);
        });
      });
    });
  }

  List<Utilisateur> recupererUtilisateurs(List<DocumentSnapshot> utilisateurDocs) {
    List<Utilisateur> maListe = utilisateurs;
    utilisateurDocs.forEach((util) {
      Utilisateur utilisateur = Utilisateur(util);
      if (maListe.every((u) => u.id != utilisateur.id)){
        maListe.add(utilisateur);
      } else {
        Utilisateur aChanger = maListe.singleWhere((u) => u.id == utilisateur.id);
        maListe.remove(aChanger);
        maListe.add(utilisateur);
      }
    });
    setState(() {
      utilisateurs=maListe;
    });
  }

  List<Publication> recupererPublis(List<DocumentSnapshot> publisDocuments) {
    List<Publication> maListe = publis;
    publisDocuments.forEach((p) {
      Publication publi = Publication(p);
      if (maListe.every((p) => p.documentID != publi.documentID)){
        maListe.add(publi);
      } else {
        Publication aChanger = maListe.singleWhere((p) => p.documentID == publi.documentID);
        maListe.remove(aChanger);
        maListe.add(publi);
      }
      maListe.sort((a,b) => b.date.compareTo(a.date));
    });
    setState(() {
      publis=maListe;
    });
  }

}