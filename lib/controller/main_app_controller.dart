import 'dart:async';
import 'package:fashion_network/outils/allerte.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';
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

class MainAppController extends StatefulWidget {

  String id;
  MainAppController(this.id);

  _MainState createState() => _MainState();
}

class _MainState extends State<MainAppController>{

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState >();
  StreamSubscription streamLst;

  int index = 0;

  @override
  void initState(){
    //TODO
    super.initState();
    streamLst = FirebaseUtilisateur().userFirestore.document(widget.id).snapshots().listen((document){
      setState(() {
        moi = Utilisateur(document);
      });
    });
  }

  @override
  void dispose() {
    //TODO
    streamLst.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    //TODO
    //return ChargementPage();
    return (moi == null) ? ChargementPage() : Scaffold(
        key: _globalKey,
        backgroundColor: roseTresClair,
        bottomNavigationBar: PiedDePage(items: [
          ItemBarre(icon: homeIcon, onPressed: (()=>selectionnerBouton(0)), selected: index==0),
          ItemBarre(icon: profileIcon, onPressed: (()=>selectionnerBouton(1)), selected: index==1),
          ItemBarre(icon: friendsIcon, onPressed: (()=>selectionnerBouton(2)), selected: index==2),
          Container(width:30.0,height:0.0),
          ItemBarre(icon: notifIcon, onPressed: (()=>selectionnerBouton(3)), selected: index==3),
          ItemBarre(icon: parameterIcon, onPressed: (()=>selectionnerBouton(4)), selected: index==4),
          ItemBarre(icon: logoutIcon, onPressed: (()=>Allerte().deconnexion(context)), selected: index==5),
        ]),
        body:montrerPage(),
        floatingActionButton: FloatingActionButton(onPressed: ecrire, child: writeIcon),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  ecrire() {
    _globalKey.currentState.showBottomSheet((builder) => NouveauStatut());
  }

  selectionnerBouton(int index){
    setState(() {
      this.index=index;
    });
  }


  Widget montrerPage() {
    switch (index){
      case 0: return FilActualite();
      case 1: return Profil(moi);
      case 2: return PageUtilisateurs();
      case 3: return PageNotif();
      default: return Parametres();
    }
  }
}