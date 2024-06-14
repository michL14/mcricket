import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcricket/appbar.dart';

class Game01 extends StatefulWidget {
  final List<List<String>> teamsList;

  const Game01({super.key, required this.teamsList});

  @override
  _Game01State createState() => _Game01State();
}

class _Game01State extends State<Game01> {
  int indexTeamToPlay = 0;
  int indexPlayerToPlay = 0;
  List<List<List<String>>> _teamsPoint = [];
  List<List<int>> teamsScore = [];

  @override
  void initState() {
    super.initState();
    // Initialiser la liste des scores avec des scores nuls pour chaque joueur
    teamsScore = List<List<int>>.from(
      List.generate(
        widget.teamsList.length,
        (_) => List.filled(
          widget.teamsList[indexTeamToPlay].length,
          0,
        ),
      ),
    );
  }

  void nextPlayer() {
    setState(() {
      // Incrémenter le score du joueur actuel
      teamsScore[indexTeamToPlay][indexPlayerToPlay]++;

      // Passer au joueur suivant
      if (indexPlayerToPlay < widget.teamsList[indexTeamToPlay].length - 1) {
        indexPlayerToPlay++;
      } else {
        indexPlayerToPlay = 0;
        if (indexTeamToPlay < widget.teamsList.length - 1) {
          indexTeamToPlay++;
        } else {
          indexTeamToPlay = 0;
        }
      }
    });
  }

  void addPoints(int points) {
    setState(() {
      // Ajouter les points au joueur actif
      teamsScore[indexTeamToPlay][indexPlayerToPlay] += points;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const MyAppBar(),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary, // Couleur de fond du conteneur
                borderRadius: BorderRadius.circular(10), // Bordures arrondies
              ),
              padding: const EdgeInsets.all(8), // Ajouter un espace intérieur
              child: Text(
                widget.teamsList[indexTeamToPlay][indexPlayerToPlay],
                style: GoogleFonts.orbitron(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onPrimary)),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              '${teamsScore[indexTeamToPlay][indexPlayerToPlay]}',
              style: const TextStyle(fontSize: 20),
            ),
            //SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                  children: List.generate(22, (index) {
                    final points = index + 1;
                    return ElevatedButton(
                      onPressed: () => addPoints(points),
                      child: Text('$points'),
                    );
                  }),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: nextPlayer,
              child: const Text("Joueur suivant"),
            ),
          ],
        ),
      ),
    );
  }
}
