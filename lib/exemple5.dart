import 'dart:math';
import 'package:flutter/material.dart';

class Exemple5 extends StatefulWidget {
  const Exemple5({super.key});

  @override
  State<Exemple5> createState() => _Exemple5State();
}

class _Exemple5State extends State<Exemple5>
    with SingleTickerProviderStateMixin {
  var _color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
            tween: ColorTween(begin: getRandomColor(), end: _color),
            duration: const Duration(seconds: 1),
            onEnd: () {
              setState(() {
                _color = getRandomColor();
              });
            },
            builder: (context, color, child) {
              return Container(
                width: 200,
                height: 200,
                color: color,
              );
            }),
      ),
    );
  }
}

Color getRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256), // Vert (0-255)
    random.nextInt(256), // Bleu (0-255)
    1.0, // Opacité (1.0 signifie complètement opaque)
  );
}
