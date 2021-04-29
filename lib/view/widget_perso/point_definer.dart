import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';
import 'dart:math';

class PointDefiner extends CustomPainter{

  Paint painter;
  final PageController pageController;

  PointDefiner(this.pageController): super(repaint: pageController) {
    painter=Paint()
        ..color=blanc
        ..style=PaintingStyle.fill;
  }
  @override
  void paint(Canvas canvas, Size size){
    if (pageController != null && pageController.position != null){
      final rayon = 20.0;
      final dy = 25.0;
      final dxEnCours = 25.0;
      final cibleDx = 125.0;
      final position = pageController.position;
      final extension = (position.maxScrollExtent - position.minScrollExtent + position.viewportDimension);
      final decalage = position.extentBefore / extension;
      bool aDroite = dxEnCours < cibleDx;
      Offset entree = Offset(aDroite ? dxEnCours : cibleDx, dy);
      Offset cible = Offset(aDroite ? cibleDx : dxEnCours, dy);
      Path chemin = Path();
      chemin.addArc(Rect.fromCircle(center: entree, radius: rayon) , 0.5 * pi, 1 * pi);
      chemin.addRect(Rect.fromLTRB(entree.dy, dy-rayon, cible.dx, dy+rayon));
      chemin.addArc(Rect.fromCircle(center: cible, radius: rayon), 1.5 * pi, 1 * pi);
      canvas.translate(size.width * decalage, 0.0);
      canvas.drawShadow(chemin, rosePale, 2.5, true);
      canvas.drawPath(chemin, painter);
    }
  }

  @override
  bool shouldRepaint(PointDefiner ancienDelegue) => true;
}