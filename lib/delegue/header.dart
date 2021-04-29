import 'package:fashion_network/classes/utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';

class HeaderPerso extends SliverPersistentHeaderDelegate {

  Utilisateur utilisateur;
  VoidCallback callback;
  bool scrolled;

  HeaderPerso({@required this.utilisateur, @required this.callback, @required this.scrolled});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
      return Container(
        margin: EdgeInsets.only(bottom: 5.0),
        padding: EdgeInsets.all(10.0),
        color: rosePale,
        child: (!scrolled) ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  elementChangeable("${utilisateur.pseudo}",fontSize:35.0),
                  Container(width:80.0,height:0.0),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        TextePerso("abonnés: ${utilisateur.abonnes.length}",color:bleuFonce),
                        TextePerso("abonnements: ${utilisateur.abonnements.length}",color:bleuFonce)
                      ])
                ]),
            Container(width:0.0,height:20.0),
            TextePerso("A propos:",fontSize:35.0,color:rouge),
            Container(width:0.0,height:10.0),
            elementChangeable((utilisateur.aPropos == null || utilisateur.aPropos == "") ?
            "Aucune description" : "${utilisateur.aPropos}")
          ],

        ): Container(
            width:0.0,
            height:50.0,
            color:roseTresClair,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextePerso("abonnés: ${utilisateur.abonnes.length}",color:bleuFonce),
                TextePerso("abonnements: ${utilisateur.abonnements.length}",color:bleuFonce)
              ],

        )),

    );
  }

  Widget elementChangeable(String text, {double fontSize = 16.0}) {
    return (utilisateur.id == moi.id) ?
        InkWell(
          child: TextePerso(text, fontSize: fontSize,),
          onTap: callback
        )
        : TextePerso(text);
  }

  @override double get maxExtent => (scrolled) ? 100.0:250.0;
  @override double get minExtent => (scrolled) ? 100.0:250.0;
  @override bool shouldRebuild(HeaderPerso vieuxDelegue) => scrolled != vieuxDelegue.scrolled || utilisateur != vieuxDelegue.utilisateur;
}