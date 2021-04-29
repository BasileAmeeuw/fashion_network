import 'package:flutter/material.dart';
import 'texte_perso.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/classes/utilisateur.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';

class BoutonAbonner extends TextButton {
  BoutonAbonner({@required Utilisateur utilisateur}) : super(
    child: TextePerso(moi.abonnements.contains(utilisateur.id) ? "Se désabonner" : "S'abonner", color: bleuFonce),
    onPressed: () {
      FirebaseUtilisateur().addAbonnement(utilisateur);
    },
  );
}