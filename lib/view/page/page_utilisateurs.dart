import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_network/view/tile/tile_utilisateur.dart';
import 'package:fashion_network/view/widget_perso/entete_perso.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/classes/utilisateur.dart';
import 'package:fashion_network/outils/allerte.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';

class PageUtilisateurs extends StatefulWidget {


  _EtatUtilisateur createState() => _EtatUtilisateur();

}

class _EtatUtilisateur extends State<PageUtilisateurs> {

  @override
  Widget build(BuildContext context) {
    //TODO
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseUtilisateur().userFirestore.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data.documents;
          return NestedScrollView(
              headerSliverBuilder: (BuildContext ctxBuild, bool scrolled) {
                return [
                  EntetePerso(titre: "Liste des utilisateurs")
                ];
              },
              body: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (BuildContext ctx, int index) {
                  Utilisateur utilisateur = Utilisateur(documents[index]);
                    return TileUtilisateur(utilisateur);
                }
              ));
        } else {
          return ChargementPage();
        }
      },
    );
  }
}