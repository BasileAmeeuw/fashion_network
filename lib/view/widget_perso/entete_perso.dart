import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';

class EntetePerso extends SliverAppBar{

  EntetePerso({@required String titre, AssetImage image:null, double height: 150.0}): super(
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title:TextePerso(titre, color:bleuFonce),
          background: (image!=null) ? Image(image: image, fit: BoxFit.cover) : null
        ) ,
        expandedHeight: height,
  );
}