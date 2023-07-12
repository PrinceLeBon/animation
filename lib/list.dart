import 'package:animation/exemple2.dart';
import 'package:animation/implicit_animation/easy/easy_five.dart';
import 'package:animation/implicit_animation/easy/easy_four.dart';
import 'package:animation/implicit_animation/easy/easy_one.dart';
import 'package:animation/implicit_animation/easy/easy_three.dart';
import 'package:animation/implicit_animation/easy/easy_two.dart';
import 'package:animation/implicit_animation/medium/medium_three.dart';
import 'package:animation/implicit_animation/medium/medium_two.dart';
import 'package:animation/square_bounce.dart';
import 'package:animation/visualizer.dart';
import 'package:flutter/material.dart';
import 'custom_painter.dart';
import 'exemple1.dart';
import 'implicit_animation/difficult/difficult_one.dart';

class ListOfAnimation extends StatelessWidget {
  const ListOfAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const ExampleParallax();
                      }));
                    },
                    child: const Text("Example Of Parallax")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const MediumThree();
                      }));
                    },
                    child: const Text("Bounced")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const MediumTwo();
                      }));
                    },
                    child: const Text("List Opacity")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const EasyFive();
                      }));
                    },
                    child: const Text("Rotation")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const EasyFour();
                      }));
                    },
                    child: const Text("Change Color")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const EasyThree();
                      }));
                    },
                    child: const Text("Change Font size")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const EasyTwo();
                      }));
                    },
                    child: const Text("Move")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const EasyOne();
                      }));
                    },
                    child: const Text("Hide Button")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const Visualizer();
                      }));
                    },
                    child: const Text("Visualizer")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const MyPainter();
                      }));
                    },
                    child: const Text("MyPainter")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const Exemple2();
                      }));
                    },
                    child: const Text("Exemple2")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const MyHomePage();
                      }));
                    },
                    child: const Text("Exemple1")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const SquareBounced();
                      }));
                    },
                    child: const Text("SquareBounced")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
