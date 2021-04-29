import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';

class Allerte {
  Future<void> error(BuildContext context, String error) async {
    TextePerso titre = TextePerso("Erreur", color:Colors.black);
    TextePerso contenu = TextePerso(error, color:Colors.black);
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return AlertDialog(title:titre, content:contenu, actions: <Widget>[fermer(ctx,"ok")]);
        }
    );
  }

  TextButton fermer(BuildContext context, String text) {
    return TextButton(
        onPressed: (()=> Navigator.pop(context)),
        child: TextePerso(text, color:Colors.red)
    );
  }

  Future<void> deconnexion(BuildContext context) async {
    TextePerso titre = TextePerso("Voulez-vous vraiment vous déconnecter?", color:Colors.black);
    return showDialog(
      context:context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
       return AlertDialog(
           title: titre,
            actions: <Widget>[fermer(ctx, "NON"), deconnexionBouton(ctx)]);
      });
  }

  Future<void> changerUtilisateurParametre(BuildContext context, {@required TextEditingController pseudo, @required TextEditingController aPropos}) async {
    return showDialog(
        context:context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
              title: TextePerso("Modification de vos données (pseudo et/ou description)"),
              content:Column(
                children:<Widget>[
                  TexteChamps(controller: pseudo, hint: moi.pseudo),
                  TexteChamps(controller: aPropos, hint: (moi.aPropos != null && moi.aPropos != "") ? moi.aPropos : "Aucune description" ) ,
                ]),
              actions: <Widget>[fermer(ctx, "Annuler"),
                TextButton(
                  child:TextePerso("valider", color:Colors.blueGrey),
                  onPressed: () {
                    Map<String, dynamic> data = {};
                    if (pseudo.text != null && pseudo.text != "") {
                      data[pseudoKey] = pseudo.text;
                    }
                    if (aPropos.text != null) {
                      data[aProposKey] = aPropos.text;
                    }
                    FirebaseUtilisateur().modifierUtilisateur(data);
                    Navigator.pop(context);
                  }
                )]);
        });

  }

  TextButton deconnexionBouton(BuildContext context){
    return TextButton(
        onPressed: () {
          FirebaseUtilisateur().deconnexion();
          Navigator.pop(context);
        },
        child: TextePerso("OUI", color:Colors.black));
  }
}