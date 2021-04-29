import 'package:flutter/material.dart';
import 'package:fashion_network/view/material_perso.dart';

class ButtonsAuth extends StatelessWidget {
  final String button1;
  final String button2;
  final PageController pageController;

  ButtonsAuth({@required String this.button1, @required String this.button2, @required PageController this.pageController});

  @override
  Widget build(BuildContext context){
    //TODO
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(color: bleuFonce, borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: CustomPaint(
        painter: PointDefiner(pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            itemButton(button1), itemButton(button2)
          ],
        )
      ),
    );
  }

  Expanded itemButton(String name){
    return Expanded(child: TextButton(
      onPressed: () {
        int page = (pageController.page== 0.0) ? 1 : 0;
        pageController.animateToPage(
          page,
          duration: Duration(milliseconds: 500),
          curve: Curves.decelerate
        );
      },
      child: Text(name))
    );
  }
}