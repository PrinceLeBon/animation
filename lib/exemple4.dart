import 'dart:math' show pi;
import 'package:flutter/material.dart';

class Exemple4 extends StatefulWidget {
  const Exemple4({super.key});

  @override
  State<Exemple4> createState() => _Exemple4State();
}

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

const people = [
  Person(name: 'John', age: 20, emoji: '🙋🏻‍♂️'),
  Person(name: 'Jane', age: 21, emoji: '👸🏽'),
  Person(name: 'Jack', age: 22, emoji: '🧔🏿‍♂️'),
];

class _Exemple4State extends State<Exemple4> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    person: person,
                  ),
                ),
              );
            },
            leading: Hero(
              tag: person.name,
              child: Text(
                person.emoji,
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            title: Text(person.name),
            subtitle: Text(
              '${person.age} years old',
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
          );
        },
      ),
    )
        /*SafeArea(
          child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            tapped = !tapped;
          });
        },
        child: AnimatedContainer(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(12),
            height: tapped ? 250 : 125,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white38),
            duration: const Duration(milliseconds: 500),
            child: ListView(
              physics: tapped ? null : const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                ),
                Column(
                  children: [
                    Container(
                      height: 10,
                    ),
                    const Text(
                        "datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata"),
                  ],
                )
              ],
            )),
      ))*/
        ;
  }
}

class DetailsPage extends StatelessWidget {
  final Person person;

  const DetailsPage({
    super.key,
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder: (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).chain(
                        CurveTween(
                          curve: Curves.fastOutSlowIn,
                        ),
                      ),
                    ),
                    child: toHeroContext.widget,
                  ),
                );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  child: fromHeroContext.widget,
                );
            }
          },
          tag: person.name,
          child: Text(
            person.emoji,
            style: const TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              person.name,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              '${person.age} years old',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
