import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_network/controller/detail_controller.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/classes/publication.dart';
import 'package:fashion_network/classes/utilisateur.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/outils/date_arrangement.dart';

class TilePubli extends StatelessWidget {

  final Publication publi;
  final Utilisateur utilisateur;
  final bool detail;

  TilePubli({@required Publication this.publi, @required this.utilisateur, bool this.detail: false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Card(
        elevation: 5.0,
        child: PaddingPerso(
          haut:10.0, bas: 10.0, gauche: 10.0, droite: 10.0,
          widget: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PhotoProfil(urlString: utilisateur.imageUrl, onPressed: null),
                  Column(
                    children: <Widget>[
                      TextePerso("${utilisateur.pseudo}", color:rouge),
                      TextePerso(DateArrangement().maDate(publi.date),color:bleuFonce),
                    ]
                  )
                ]
              ),
              (publi.urlImage != null && publi.urlImage != "")
                  ? PaddingPerso(widget: Container(width:MediaQuery.of(context).size.width, height: 1.0, color:rouge))
                  : Container(height:0.0),
              (publi.urlImage != null && publi.urlImage != "")
              ? PaddingPerso(widget: Container(
                width:MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.width *0.85,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(image: CachedNetworkImageProvider(publi.urlImage), fit: BoxFit.cover))
              )) : Container(height: 0.0),
              (publi.texte != null && publi.texte != "")
                  ? PaddingPerso(widget: TextePerso(publi.texte, color: bleuFonce))
                  : Container(height:0.0),
              PaddingPerso(widget: Container(width:MediaQuery.of(context).size.width, height: 1.0, color:rouge)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  IconButton(icon: (publi.pouceBleus.contains(moi.id) ? pbFullIcon : pbIcon), onPressed: () => FirebaseUtilisateur().addPouceBleu(publi),),
                  TextePerso(publi.pouceBleus.length.toString(), color: bleuFonce),
                  IconButton(icon: (publi.pouceRouges.contains(moi.id) ? prFullIcon : prIcon), onPressed: () => FirebaseUtilisateur().addPouceRouge(publi)),
                  TextePerso(publi.pouceRouges.length.toString(), color: rouge),
                  IconButton(icon: commentaireIcon,
                      onPressed: (!detail) ?() { Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) {
                        return DetailController(publi, utilisateur);
                      })); }: null),
                  TextePerso(publi.commentaires.length.toString(), color: Colors.black)
                ]
              )

    ],
          )
        )
      )
    );
  }
}