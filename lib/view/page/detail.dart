import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:fashion_network/view/tile/tile_publi.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/classes/publication.dart';
import 'package:fashion_network/classes/utilisateur.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:fashion_network/classes/commentaire.dart';
import 'package:fashion_network/view/tile/tile_commentaire.dart';

class Detail extends StatelessWidget{

  Utilisateur utilisateur;
  Publication publication;

  Detail(this.utilisateur, this.publication);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<DocumentSnapshot>(
        stream: publication.ref.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Publication nvlPubli = Publication(snapshot.data);
            return ListView.builder(
              itemCount: nvlPubli.commentaires.length+1,
              itemBuilder: (BuildContext ctx, int index) {
                if (index==0){
                  return TilePubli(publi: nvlPubli, utilisateur: utilisateur, detail: true,);
                }else {
                  Commentaire commentaire = Commentaire(nvlPubli.commentaires[index-1]);
                      return TileCommentaire(commentaire);
                }
            }


            );
          } else {
            Container(width:1.0,height:1.0);
          };
    });
  }
}