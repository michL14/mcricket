import 'package:flutter/material.dart';
import 'package:mcricket/appbar.dart';
import 'package:mcricket/splash.dart';

class Game01 extends StatelessWidget {
  final List<List<String>> teamsList;
  const Game01(
      {super.key,
      required this.teamsList}); // Ajouter un initialiseur pour teamsList

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const MyAppBar(),
        body: ListView.builder(
          itemCount: teamsList.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Liste ${index + 1}:'),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: teamsList[index].length,
                  itemBuilder: (context, subIndex) {
                    return ListTile(
                      title: Text(teamsList[index][subIndex]),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
