import 'dart:io';

import 'package:fashion_network/classes/publication.dart';
import 'package:fashion_network/controller/log_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_network/view/widget_perso/constantes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'package:fashion_network/classes/utilisateur.dart';

class FirebaseUtilisateur {

  //Auth
  final auth = FirebaseAuth.instance;
  Future<FirebaseUser> signIn(String mail, String mdp) async {
    final AuthResult result = await auth.signInWithEmailAndPassword(email: mail, password: mdp);
    final FirebaseUser utilisateur = result.user;
    return utilisateur;
  }

  Future<FirebaseUser> createAccount(String mail, String mdp, String pseudo) async {
    final AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: mail, password: mdp);
    final FirebaseUser utilisateur = result.user;
    //Créer le compte dans la BDD
    String id=utilisateur.uid;
    String email=utilisateur.email;
    List<dynamic> abonnes = [];
    List<dynamic> abonnements = [];
    Map<String, dynamic> map = {
      pseudoKey: pseudo,
      imageKey:"",
      abonnesKey:abonnes,
      abonnementsKey:abonnements,
      idKey:id,
      emailKey:email,
    };
    addUtilisateur(id, map);
    return utilisateur;
  }


  deconnexion() {
    FirebaseAuth.instance.signOut();
  }

  //Firestore
  final data = Firestore.instance;
  final userFirestore = Firestore.instance.collection("Users");
  final notifFirestore = Firestore.instance.collection("Notifier");

  Stream<QuerySnapshot> publisDe(String id) => userFirestore.document(id).collection(dossierPublications).snapshots();

  addNotification(String deQui, String aQui, String texte, DocumentReference reference, String type) {
    Map<String, dynamic> map = {
      idKey: deQui,
      texteKey: texte,
      typeKey: type,
      refKey: reference,
      vuKey: false,
      dateKey: DateTime.now().millisecondsSinceEpoch.toInt()
    };
    notifFirestore.document(aQui).collection("simpleNotif").add(map);
  }
  addUtilisateur(String id, Map<String, dynamic> map){
    userFirestore.document(id).setData(map);
  }


  modifierUtilisateur(Map<String, dynamic> data) {
    userFirestore.document(moi.id).updateData(data);
  }

  addPublication(String id, String texte, File file) {
    int date = DateTime.now().millisecondsSinceEpoch.toInt();
    List<dynamic>poucesBleus= [];
    List<dynamic>poucesRouges= [];
    List<dynamic>commentaires=[];

    Map<String, dynamic> map= {
      idKey:id,
      pbKey:poucesBleus,
      prKey:poucesRouges,
      commentaireKey: commentaires,
      dateKey: date,
    };
    if (texte != 0 && texte != ""){
      map[texteKey] = texte;
    }
    if (file != null) {
      print(file);
      StorageReference ref = publications.child(id).child(date.toString());
      addImage(file, ref).then((finalised) {
        String urlImage = finalised;
        map[imageKey] = urlImage;
        userFirestore.document(id).collection(dossierPublications).document().setData(map);
      });
    } else {
      userFirestore.document(id).collection(dossierPublications).document().setData(map);
    }
  }

  addAbonnement(Utilisateur pasMoi) {
    if (moi.abonnements.contains(pasMoi.id)) {
      moi.reference.updateData({abonnementsKey:FieldValue.arrayRemove([pasMoi.id])});
      pasMoi.reference.updateData({abonnesKey:FieldValue.arrayRemove([moi.id])});
      addNotification(moi.id, pasMoi.id, "${moi.pseudo} ne vous suit plus ", moi.reference, abonnesKey);
    } else {
      moi.reference.updateData({abonnementsKey:FieldValue.arrayUnion([pasMoi.id])});
      pasMoi.reference.updateData({abonnesKey:FieldValue.arrayUnion([moi.id])});
      addNotification(moi.id, pasMoi.id, "${moi.pseudo} a commencé a vous suivre ", moi.reference, abonnesKey);
      }
  }

  addPouceBleu (Publication publication) {
    if (publication.pouceBleus.contains(moi.id)) {
      publication.ref.updateData({pbKey: FieldValue.arrayRemove([moi.id])});
      addNotification(moi.id, publication.idUtilisateur, "${moi.pseudo} n'aime plus votre publication", publication.ref, pbKey);
    } else {
      publication.ref.updateData({pbKey: FieldValue.arrayUnion([moi.id])});
      addNotification(moi.id, publication.idUtilisateur, "${moi.pseudo} a aimé votre publication", publication.ref, pbKey);
      }
  }

  addPouceRouge (Publication publication) {
    if (publication.pouceRouges.contains(moi.id)) {
      publication.ref.updateData({prKey: FieldValue.arrayRemove([moi.id])});
      addNotification(moi.id, publication.idUtilisateur, "${moi.pseudo} ne déteste plus votre publication", publication.ref, prKey);
    } else {
      publication.ref.updateData({prKey: FieldValue.arrayUnion([moi.id])});
      addNotification(moi.id, publication.idUtilisateur, "${moi.pseudo} a détesté votre publication", publication.ref, prKey);
    }
  }

  addCommentaire(DocumentReference reference, String texte, String publicationAQui){
    Map<dynamic, dynamic> map = {
      idKey: moi.id,
      texteKey:texte,
      dateKey:DateTime.now().millisecondsSinceEpoch.toInt()
    };
    reference.updateData({commentaireKey: FieldValue.arrayUnion([map])});
    addNotification(moi.id, publicationAQui, "${moi.pseudo} a commenté votre publication", reference, commentaireKey);
  }

  modifierPhoto(File file) {
    StorageReference reference = utilisateurs.child(moi.id);
    addImage(file, reference).then((fini) {
      Map<String, dynamic> data = {imageKey: fini};
      modifierUtilisateur(data);
    });
  }
  //Storage
  static final storage = FirebaseStorage.instance.ref();
  final utilisateurs = storage.child(dossierUtilisateurs);
  final publications = storage.child(dossierPublications);

  Future<String> addImage(File file, StorageReference ref) async {
    StorageUploadTask tache = ref.putFile(file);
    StorageTaskSnapshot snapshot = await tache.onComplete;
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }


}