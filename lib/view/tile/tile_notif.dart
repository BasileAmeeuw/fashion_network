import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_network/classes/notif.dart';
import 'package:fashion_network/controller/detail_controller.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:fashion_network/view/page/detail.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/classes/publication.dart';
import 'package:fashion_network/classes/utilisateur.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/outils/date_arrangement.dart';
import 'package:fashion_network/controller/detail_controller.dart';
import 'package:fashion_network/view/page/profil.dart';

class TileNotif extends StatelessWidget {

  Notif notification;

  TileNotif(this.notification);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseUtilisateur().userFirestore.document(notification.idUtilisateur).snapshots(),
      builder: (BuildContext ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          Utilisateur utilisateur = Utilisateur(snapshot.data);
          return InkWell(
            onTap: () {
              notification.notifRef.updateData({vuKey: true});
              if (notification.type == abonnesKey){Navigator.push(context, MaterialPageRoute(builder: (BuildContext buildctx){
                return Scaffold(body: SafeArea(child: Profil(utilisateur)));
              }));} else {

                notification.reference.get().then((snap) {
                  Publication publication = Publication(snap);
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) {
                    return Detail(utilisateur, publication);
                  }));

                });
              }

            },
            child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(left:10.0,right:10.0,top: 5.0),
                child:Card(
                    elevation : 5.0,
                    color: (notification.vu) ? rosePale : rouge,
                    child: Container(
                        padding: EdgeInsets.all(7.5),
                        child:Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  PhotoProfil(urlString: utilisateur.imageUrl, onPressed: null),
                                  TextePerso(notification.date, color:bleuFonce),
                                ],
                              ),
                              TextePerso(notification.texte, color: bleuFonce),
                            ]
                        )
                    )
                )
            )
          );
        }
      }
    );
  }

}