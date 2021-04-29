import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_network/classes/publication.dart';
import 'package:fashion_network/outils/allerte.dart';
import 'package:fashion_network/view/tile/tile_publi.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/classes/utilisateur.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:fashion_network/delegue/header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_network/view/tile/tile_publi.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fashion_network/outils/allerte.dart';

class Profil extends StatefulWidget {

  Utilisateur utilisateur;
  Profil(this.utilisateur);
  _EtatProfil createState() => _EtatProfil();

}

class _EtatProfil extends State<Profil> {

  bool _estCeMoi = false;
  ScrollController controller;
  TextEditingController _pseudo;
  TextEditingController _aPropos;
  final double expanded = 250.0;
  bool get _showTitle {
    return controller.hasClients && controller.offset > expanded - kToolbarHeight;
  }
  StreamSubscription sub;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _estCeMoi = (widget.utilisateur.id == moi.id);
    controller=ScrollController()..addListener(() {
      setState((){
      });
    });
    _pseudo = TextEditingController();
    _aPropos = TextEditingController();
    sub=FirebaseUtilisateur().userFirestore.document(widget.utilisateur.id).snapshots().listen((data) {
      setState(() {
        widget.utilisateur = Utilisateur(data);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    _pseudo.dispose();
    _aPropos.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    //TODO
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseUtilisateur().publisDe(widget.utilisateur.id),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return ChargementPage();
        } else {
          List<DocumentSnapshot> documents = snapshot.data.documents;
          return CustomScrollView(
            controller: controller,
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: expanded,
                actions: <Widget>[
                  (_estCeMoi) ? InkWell(onTap: (()=>Allerte().deconnexion(context)), child: Container(
                      color:Colors.transparent,
                      margin: EdgeInsets.all(2.5),
                      child:Column(
                        children: <Widget>[
                          Container(height:15.0),
                          TextePerso("Déconnexion",color:rouge,fontSize: 20.0,)
                        ],
                      ))) : BoutonAbonner(utilisateur: widget.utilisateur)
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: _showTitle ? TextePerso(widget.utilisateur.pseudo,fontSize:20.0,color:bleuFonce):TextePerso(""),
                  background: Container(
                    decoration: BoxDecoration(image:DecorationImage(image:logoImage, fit: BoxFit.cover)),
                    child: Center(child: PhotoProfil(urlString: widget.utilisateur.imageUrl, size:125.0, onPressed: (widget.utilisateur.id==moi.id) ? changerUtilisateurPhoto : null))
                  )
                )
          ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: HeaderPerso(utilisateur: widget.utilisateur, callback: changeUserParam, scrolled: _showTitle)),
              SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, index){
                if (index== documents.length) {
                  return ListTile(title: TextePerso("Création du compte", color:Colors.black));
                }
                if (index>documents.length){
                  return null;
                }
                Publication publi=Publication(documents[index]);
                return TilePubli(publi: publi, utilisateur: widget.utilisateur);
              }))
            ]
          );
        }
      }
    );
  }

  void changeUserParam() {
    Allerte().changerUtilisateurParametre(context, pseudo: _pseudo, aPropos: _aPropos);
  }
  
  void changerUtilisateurPhoto() {
    showModalBottomSheet(context: context, builder: (BuildContext ctx) {
      return Container(
          color:Colors.transparent,
        child: Card(
          color:Colors.transparent,
          elevation: 10.0,
          margin: EdgeInsets.all(20.0),
          child: Container(
              decoration: GradientPerso(startCouleur: rosePale, endCouleur: roseTresClair),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextePerso("Changer de PP"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget>[
                    IconButton(icon: cameraIcon, onPressed: (() {
                      prendrePhoto(ImageSource.camera);
                      Navigator.pop(ctx);
                      })),
                    IconButton(icon: galleryIcon, onPressed: (() {
                      prendrePhoto(ImageSource.gallery);
                      Navigator.pop(ctx);
                      })),
                  ],
                ),
                IconButton(icon: supprimerIcon,onPressed: null,)
              ]
            )
          ),
        )
      );
    });
  }

  Future<void> prendrePhoto(ImageSource source ) async {
    File file = await ImagePicker.pickImage(source: source, maxHeight: 300.0, maxWidth: 300.0);
    FirebaseUtilisateur().modifierPhoto(file);
  }

  validate() {

  }


}