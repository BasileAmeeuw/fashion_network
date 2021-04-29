import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_network/view/material_perso.dart';

class PhotoProfil extends InkWell {
  PhotoProfil({
    double size: 20.0,
    @required String urlString,
    @required VoidCallback onPressed}): super(
    onTap: onPressed,
    child: CircleAvatar(
      radius: size,
      backgroundImage: (urlString != null && urlString != "") ? CachedNetworkImageProvider(urlString) : logoImage,
      backgroundColor: blanc,
    )
  );
}