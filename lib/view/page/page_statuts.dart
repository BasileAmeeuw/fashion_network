import 'dart:io';

import 'package:fashion_network/outils/firebase_utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:image_picker/image_picker.dart'
;
class NouveauStatut extends StatefulWidget {
  _EtatNvxStatut createState() => _EtatNvxStatut();
}

class _EtatNvxStatut extends State<NouveauStatut> {
  TextEditingController _controller;
  File photoPrise;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration:
            GradientPerso(startCouleur: roseTresClair, endCouleur: rosePale),
        height: MediaQuery.of(context).size.height * 0.65,
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [bleuFonce, bleuCiel],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 1.0),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100.0),
                topRight: Radius.circular(100.0),
                bottomLeft: Radius.circular(100.0),
                bottomRight: Radius.circular(100.0),
              ),
            ),
            child: InkWell(
                onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      PaddingPerso(
                        widget: TextePerso("Ecrivez ici votre publication",
                            color: blanc, fontSize: 25.0),
                        haut: 15.0,
                      ),
                      PaddingPerso(
                        widget: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1.0,
                            color: blanc),
                      ),
                      PaddingPerso(
                          widget: TexteChamps(
                              controller: _controller,
                              hint: "Ecrivez ici...",
                              icon: writeIcon),
                          haut: 25.0,
                          droite: 25.0,
                          gauche: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: [
                              IconButton(
                                  icon: cameraIcon,
                                  onPressed: (() =>
                                      prendrePhoto(ImageSource.camera))),
                              IconButton(
                                  icon: galleryIcon,
                                  onPressed: (() =>
                                      prendrePhoto(ImageSource.gallery)))
                            ],
                          ),
                          Container(
                              width: 75.0,
                              height: 75.0,
                              child: (photoPrise == null)
                                  ? TextePerso("No image", fontSize: 12.0)
                                  : Image.file(photoPrise))
                        ],
                      ),
                      Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Container(
                            width: 250.0,
                            height: 50.0,
                            decoration: GradientPerso(
                                startCouleur: bleuFonce,
                                endCouleur: bleuCiel,
                                rayon: 20.0,
                                horizontal: false),
                            child: TextButton(
                                onPressed: () {
                                  envoyerAuStorage();
                                },
                                child: TextePerso("Publier")),
                          ))
                    ]))));
  }

  Future<void> prendrePhoto(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source, maxWidth:500.0, maxHeight: 500.0);
    setState((){
      photoPrise = File(image.path);
    });
  }

  envoyerAuStorage() {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.pop(context);
    if (photoPrise != null || (_controller.text != null && _controller.text != "")) {
      FirebaseUtilisateur().addPublication(moi.id,_controller.text, photoPrise);
    }
  }
}
