import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_network/view/page/profil.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/classes/publication.dart';
import 'package:fashion_network/classes/utilisateur.dart';
import 'package:fashion_network/view/material_perso.dart';

class TileUtilisateur extends StatelessWidget {
  Utilisateur utilisateur;
  TileUtilisateur(this.utilisateur);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: roseTresClair,
              body: SafeArea(child:Profil(utilisateur)),
            );
          }
        ));
      },
      child: Container(
        color:Colors.transparent,
        margin: EdgeInsets.all(2.5),
        child: Card(
          color: rosePale,
          elevation:5.0,
          child: Container(
            padding:EdgeInsets.all(2.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    PhotoProfil(urlString: utilisateur.imageUrl, onPressed: null,),
                    Container(width:15.0),
                    TextePerso("${utilisateur.pseudo}", color:rouge),
                  ],
                ),
                (utilisateur.id != moi.id) ? BoutonAbonner(utilisateur: utilisateur) : Container()
              ],
            )
          )

        )
      )

    );
  }
}