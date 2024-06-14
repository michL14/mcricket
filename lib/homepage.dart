import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcricket/appbar.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: GameList(),
    );
  }
}

class GameList extends StatelessWidget {
  const GameList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleGameButton = ElevatedButton.styleFrom(
      elevation: 4,
      backgroundColor: Theme.of(context).primaryColor,
    );
    final TextStyle styleTextGameButton = TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            width: 200,
            child: ElevatedButton(
              style: styleGameButton,
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: Text("301",
                  style:
                      GoogleFonts.montserrat(textStyle: styleTextGameButton)),
            ),
          ),
          const SizedBox(height: 100),
          SizedBox(
            height: 60,
            width: 200,
            child: ElevatedButton(
              style: styleGameButton,
              onPressed: () {
                Navigator.pushNamed(context, '/splash');
              },
              child: Text("501",
                  style:
                      GoogleFonts.montserrat(textStyle: styleTextGameButton)),
            ),
          ),
          const SizedBox(height: 100),
          SizedBox(
            height: 60,
            width: 200,
            child: ElevatedButton(
              style: styleGameButton,
              onPressed: () {
                Navigator.pushNamed(context, '/splash');
              },
              child: Text("CRICKET",
                  style:
                      GoogleFonts.montserrat(textStyle: styleTextGameButton)),
            ),
          ),
        ],
      ),
    );
  }
}
