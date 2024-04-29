import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const BigCard();
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card();
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(children: <Widget>[
      Row(),
      Row(),
      Row(),
    ]));
  }
}
