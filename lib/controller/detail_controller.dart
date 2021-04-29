import 'dart:async';
import 'package:fashion_network/classes/publication.dart';
import 'package:fashion_network/controller/main_app_controller.dart';
import 'package:fashion_network/outils/allerte.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:fashion_network/view/page/detail.dart';
import 'package:fashion_network/view/page/page_statuts.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/classes/utilisateur.dart';
import 'package:fashion_network/view/page/fil_actualite.dart';
import 'package:fashion_network/view/page/page_notif.dart';
import 'package:fashion_network/view/page/page_utilisateurs.dart';
import 'package:fashion_network/view/page/profil.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:fashion_network/view/page/page_statuts.dart';
import 'package:fashion_network/view/page/parametre.dart';
import 'log_controller.dart';


class DetailController extends StatelessWidget {

  Utilisateur utilisateur;
  Publication publication;

  DetailController(this.publication, this.utilisateur);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child:
                InkWell(child: Detail(utilisateur,publication), onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
    }),),
                Container(width:MediaQuery.of(context).size.width, height: 1.0, color: bleuFonce),
                Container(width:MediaQuery.of(context).size.width, height: 100.0,
              color: rosePale,
              padding : EdgeInsets.only(left:0.0,right:10.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: retourIcon, onPressed: () => Navigator.pop(context, false)),
                  Container(
                    width: MediaQuery.of(context).size.width - 130.0,
                    child: TexteChamps(controller: controller, hint:"Ecrivez un commentaire..."),
                  ),
                  IconButton(icon: envoieIcon,  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (controller.text != null && controller.text != "") {
                      FirebaseUtilisateur().addCommentaire(publication.ref, controller.text, publication.idUtilisateur);
                    }
                  })
                ],
              ),

            )],
        )
      )
    );
  }

}