import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'controller/main_app_controller.dart';
import 'controller/log_controller.dart';
import 'view/material_perso.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch:Colors.blue,
        canvasColor: Colors.transparent,
        primaryColor:bleuCiel,
        accentColor:Colors.blue,
      ),
      home: _handleAuth(),
    );
  }

  Widget _handleAuth() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        //return LogController();
        return (!snapshot.hasData) ? LogController() : MainAppController(snapshot.data.uid);
      },
    );
  }
}

