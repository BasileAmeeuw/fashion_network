import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_network/classes/notif.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:fashion_network/view/tile/tile_publi.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/classes/publication.dart';
import 'package:fashion_network/classes/utilisateur.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:fashion_network/view/tile/tile_notif.dart';

class PageNotif extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //TODO
    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseUtilisateur().notifFirestore.document(moi.id).collection("simpleNotif").snapshots(),

      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child:TextePerso("pas de notification", color:bleuFonce, fontSize:25.0));
        } else {
          //Notif tiles
          List<DocumentSnapshot> documents = snapshot.data.documents;
          return ListView.builder(itemCount: documents.length,
              itemBuilder: (BuildContext ctx, int index) {
                Notif notification = Notif(documents[index]);
            return TileNotif(notification);
          });
        }
      });
  }
}