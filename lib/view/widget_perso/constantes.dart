import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fashion_network/classes/utilisateur.dart';

//Global
Utilisateur moi;


//Colors
const Color blanc = const Color(0xFFFFFFFF);
const Color roseTresClair = const Color(0xFFFFE1D5);
const Color rosePale = const Color(0xFFFFAB91);
const Color rouge = const Color(0xFFE64A19);
const Color bleuFonce = const Color(0xFF004E89);
const Color bleuCiel = const Color(0xFFB3DEFD);

//Images
AssetImage logoImage = AssetImage("assets/logo.png");
AssetImage nulImage = AssetImage("assets/Gouden-Nul.jpg");

//Firestore
String pseudoKey = "pseudo";
String imageKey = "imageUrl";
String abonnesKey = "abonnes";
String abonnementsKey = "abonnements";
String idKey = "id";
String publicationIdKey="publicationID";
String texteKey="texte";
String dateKey = "date";
String pbKey="pouceBleu";
String prKey="pouceRouge";
String commentaireKey="commentaire";
String aProposKey="aPropos";
String emailKey="email";
String typeKey = "type";
String refKey="reference";
String vuKey = "vu";


//Storage (dossier)
String dossierUtilisateurs="Utilisateurs";
String dossierPublications="Publications";

//Icones
Icon profileIcon=Icon(Icons.face);
Icon logoutIcon=Icon(Icons.logout);
Icon homeIcon = Icon(Icons.home_work_sharp);
Icon notifIcon = Icon(Icons.notification_important_outlined);
Icon writeIcon = Icon(Icons.border_color);
Icon friendsIcon = Icon(Icons.group_sharp);
Icon parameterIcon = Icon(Icons.settings_applications_rounded);
Icon envoieIcon = Icon(Icons.send_sharp);
Icon cameraIcon = Icon(Icons.camera_alt_outlined);
Icon galleryIcon = Icon(Icons.photo_library_outlined);
Icon pbIcon = Icon(Icons.thumb_up_alt_outlined,color:Colors.blueAccent);
Icon pbFullIcon = Icon(Icons.thumb_up_alt_sharp ,color:Colors.blueAccent);
Icon prIcon = Icon(Icons.thumb_down_alt_outlined,color:Colors.redAccent);
Icon prFullIcon = Icon(Icons.thumb_down_alt_sharp,color:Colors.redAccent);
Icon commentaireIcon = Icon(Icons.comment_bank_sharp);
Icon supprimerIcon = Icon(Icons.delete_forever_sharp, color:Colors.redAccent);
Icon retourIcon = Icon(Icons.arrow_back_sharp);

