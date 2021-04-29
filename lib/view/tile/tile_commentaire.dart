import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_network/controller/detail_controller.dart';
import 'package:fashion_network/controller/main_app_controller.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/classes/publication.dart';
import 'package:fashion_network/classes/utilisateur.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/outils/date_arrangement.dart';
import 'package:fashion_network/classes/commentaire.dart';
import 'package:fashion_network/view/page/profil.dart';

class TileCommentaire extends StatelessWidget {
  Commentaire commentaire;

  TileCommentaire(this.commentaire);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseUtilisateur()
            .userFirestore
            .document(commentaire.idUtilisateur)
            .snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
          Utilisateur utilisateur = Utilisateur(snapshot.data);
          return Container(
            color: roseTresClair,
            margin: EdgeInsets.only(left: 10.0, right: 2.0, top: 5.0),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        PhotoProfil(
                          urlString: utilisateur.imageUrl,
                          size: 15.0,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Scaffold(
                                backgroundColor: roseTresClair,
                                body: SafeArea(child: Profil(utilisateur)),
                              );
                            }));
                          },
                        ),
                        TextePerso("${utilisateur.pseudo}"),
                      ],
                    ),
                    TextePerso(
                      commentaire.date,
                      color: bleuFonce,
                    )
                  ],
                ),
                TextePerso(commentaire.texte, color: Colors.black),
              ],
            ),
          );
        });
  }
}
