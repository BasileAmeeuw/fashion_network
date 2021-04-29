import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/outils/allerte.dart';
import 'package:fashion_network/outils/firebase_utilisateur.dart';

class LogController extends StatefulWidget {
  _LogState createState() => _LogState();
}

class _LogState extends State<LogController>{

  PageController _pageController;
  TextEditingController _mail;
  TextEditingController _mdp;
  TextEditingController _pseudo;
  TextEditingController _verifMdp;

  @override
  void initState() {
    //TODO
    super.initState();
    _pageController = PageController();
    _mail=TextEditingController();
    _mdp=TextEditingController();
    _pseudo=TextEditingController();
    _verifMdp=TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _mail.dispose();
    _mdp.dispose();
    _pseudo.dispose();
    _verifMdp.dispose();
    super.dispose();
  }

  Widget build(BuildContext context){
    // TODO
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          //On recoit la notification
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child:InkWell(
            onTap: (() =>  cacherClavier()),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height >= 650.0) ? MediaQuery.of(context).size.height : 650.0,
              decoration: GradientPerso(startCouleur: rosePale, endCouleur: rouge),
              child: SafeArea(
                child: Column(
                    children:<Widget>[
                      PaddingPerso(widget:Image(image:logoImage, height:200.0)),
                      PaddingPerso(widget: ButtonsAuth(button1: "Connexion", button2: "Création de compte", pageController: _pageController), haut: 20.0, bas:20.0),
                      Expanded(
                          flex: 2,
                          child:PageView(
                            controller: _pageController,
                            children: <Widget>[logView(0),logView(1)],
                          )
                      )
                    ]
                ),
              ),
            ),
          )
        ),
      ),
    );
  }

  Widget logView(int index){
    return Column(
      children: <Widget>[
        PaddingPerso(widget: Card(
          elevation: 10.0,
          color: blanc,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            margin: EdgeInsets.all(20.0),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: listeItems((index==0))
            ),
          )
        ), haut: 25.0, bas: 25.0, gauche:60.0, droite:60.0),
        PaddingPerso(
          haut: 15.0, bas: 15.0,
          widget:Card(
            elevation:10.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Container(
                width: 250.0,
                height: 50.0,
                decoration: GradientPerso(startCouleur: (index == 0) ? blanc: bleuFonce,
                    endCouleur: (index == 0) ? bleuFonce: blanc,
                    rayon: 20.0, horizontal:true),
                child: TextButton(
                    onPressed: () {
                      signIn((index == 0));
                    },
                    child: TextePerso((index == 0) ? "Se connecter": "Créer un compte", color:rouge,))
            ),
          )
        )
      ]
    );
  }

  List<Widget> listeItems(bool exists) {
    List<Widget> list = [];
    if (!exists) {
      list.add(TexteChamps(controller: _pseudo, hint: "Pseudo",));
    }
    list.add(TexteChamps(controller: _mail, hint: "Adresse mail", type: TextInputType.emailAddress));
    list.add(TexteChamps(controller: _mdp, hint:"Mot de passe", obscure: true));
    if (!exists) {
      list.add(TexteChamps(controller: _verifMdp, hint: "Vérification mot de passe (confirmation)",obscure: true));
    }

    return list;
  }

  signIn(bool exists){
    cacherClavier();
    if(_mail.text != null && _mail.text != ""){
      if (_mdp.text != null && _mdp.text !=""){
        if (exists) {
          //Connexion avec mail et mdp
          FirebaseUtilisateur().signIn(_mail.text, _mdp.text);
        } else {
          if (_pseudo.text != null && _pseudo.text != ""){
            if (_verifMdp.text != null && _verifMdp.text != ""){
              if (_verifMdp.text == _mdp.text){
                //Inscription
                FirebaseUtilisateur().createAccount(_mail.text, _mdp.text, _pseudo.text);
              } else {
                Allerte().error(context,"Votre mot de passe et mot de passe de confirmation doivent être identique !");
              }
            } else {
              //Allerte mdp pas les mêmes
              Allerte().error(context,"Vous devez entrer un mot de passe de confirmation !");
            }
          } else {
            //Alerte pas de pseudo
            Allerte().error(context,"Vous devez entrer un pseudo valide et non pris !");
          }
        }
      } else {
        //Alerte pas de mdp
        Allerte().error(context,"Vous devez entrer un mot de passe !");
      }
    } else {
      //Alerte pas de mail
      Allerte().error(context,"Vous devez entrer une adresse mail valide !");
    }
  }

  cacherClavier(){
    FocusScope.of(context).requestFocus(FocusNode());
  }
}