import 'package:flutter/material.dart';
import 'package:mcricket/appbar.dart';
import 'package:mcricket/splash.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        appBar: MyAppBar(),
        body: PlayersForm(),
      ),
    );
  }
}

class PlayersForm extends StatefulWidget {
  const PlayersForm({super.key});

  @override
  PlayersFormState createState() => PlayersFormState();
}

class PlayersFormState extends State<PlayersForm> {
  final _nbPlayersController = TextEditingController();
  int _currentStep = 0;
  String errorText = '';
  int nbTeams = 0;
  List<List<String>> _teams = [];
  bool _isYesSelected =
      false; // Déclaration de _isYesSelected avec une valeur initiale de false
  bool _isNoSelected = false;
  List<TextEditingController> controller = [];
  int _selectedButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stepper(
                steps: getSteps(),
                currentStep: _currentStep,
                type: StepperType.horizontal,
                onStepContinue: () {
                  //Validate Form per Step
                  errorText = '';
                  switch (_currentStep) {
                    case 0:
                      if (_nbPlayersController.text.isEmpty) {
                        errorText = 'Please enter a number of players';
                      } else {
                        if (int.tryParse(_nbPlayersController.text) == null) {
                          errorText = 'Please enter a valid number';
                        } else {
                          if (int.parse(_nbPlayersController.text) < 1 ||
                              int.parse(_nbPlayersController.text) > 10) {
                            errorText =
                                'Please enter a number between 1 and 10';
                          }
                        }
                      }
                      break;
                    case 1:
                      if (_isNoSelected == false && _isYesSelected == false) {
                        errorText = 'You need to make a choice';
                      }
                      if (_isYesSelected &&
                          (int.parse(_nbPlayersController.text) < 4)) {
                        errorText = 'You are not enough 😏';
                      }
                      if (_isNoSelected) {
                        nbTeams = int.parse(_nbPlayersController.text);
                        _currentStep++;
                      }
                      break;
                    case 2:
                      if (_selectedButtonIndex == -1) {
                        errorText =
                            'Please choose a number of players per teams';
                      }
                      break;
                    case 3:
                      for (var listeTeams in _teams) {
                        for (var team in listeTeams) {
                          if (team == '1' || team.isEmpty) {
                            errorText = 'Please enter a name for every players';
                          }
                        }
                      }
                      break;
                  }
                  if (errorText.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        content: Text(errorText,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onError)),
                      ),
                    );
                  } else {
                    if (_currentStep == getSteps().length - 1) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('M\'CRICKET - 301'),
                            content: const Text('Are you ready ??'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text(
                                  "No, wait 😨",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SplashScreen(teams: _teams),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Yes, let\'s go ! 🔥",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      if (_currentStep == 2) {
                        prepareToMakeTeams(
                            int.parse(_nbPlayersController.text), nbTeams);
                      }
                      setState(() {
                        _currentStep++;
                      });
                    }
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() {
                      _currentStep--;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void prepareToMakeTeams(int nbPlayers, int nbPlayerPerTeam) {
    _teams.clear();
    int nbTeamsTot;
    nbTeamsTot = (nbPlayers ~/ nbPlayerPerTeam);
    _teams = List.generate(nbTeamsTot, (_) => <String>[]);
    while (nbPlayers > 0) {
      for (int team = 0; team < nbTeamsTot; team++) {
        if (nbPlayers != 0) {
          _teams[team].add('1');
          nbPlayers--;
        }
      }
    }
  }

  List<Widget> _buildTeamSizeButtons(int numberOfPlayers) {
    List<Widget> buttons = [];

    int endRange =
        numberOfPlayers.isEven ? numberOfPlayers ~/ 2 : (numberOfPlayers ~/ 2);
    for (int i = 2; i <= endRange; i++) {
      if (numberOfPlayers.isEven) {
        if (i == 2 || i == numberOfPlayers / 2) {
          buttons.add(_buildTeamSizeButton(i));
        }
      } else {
        buttons.add(_buildTeamSizeButton(i));
      }
    }
    return buttons;
  }

  Widget _buildTeamSizeButton(int teamSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0), // Ajouter du padding horizontal
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (_selectedButtonIndex == teamSize) {
              _selectedButtonIndex = -1;
              nbTeams = 0;
            } else {
              // Sinon, sélectionnez-le et mettez à jour nbTeams
              _selectedButtonIndex = teamSize;
              nbTeams = teamSize;
            }
          });
          nbTeams = teamSize;
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              // Définir la couleur du fond en fonction de l'état de sélection
              return _selectedButtonIndex == teamSize
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context)
                      .colorScheme
                      .background; // Couleur par défaut
            },
          ),
        ),
        child: Text(
          '$teamSize',
          style: TextStyle(
              color: _selectedButtonIndex == teamSize
                  ? Theme.of(context)
                      .colorScheme
                      .onPrimary // Couleur du texte lorsque sélectionné
                  : Theme.of(context)
                      .colorScheme
                      .onBackground // Couleur du texte par défaut
              ),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        isActive: _currentStep == 0,
        title: const Text(''),
        content: Center(
          child: Column(
            children: [
              TextFormField(
                controller: _nbPlayersController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Number of Players',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      Step(
        isActive: _currentStep == 1,
        title: const Text(''),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Do you want to make teams ?"),
            const SizedBox(height: 20), // Espace horizontal de 20 pixels
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isYesSelected = !_isYesSelected;
                      _isNoSelected = false;
                      // Autres logiques à effectuer lorsque "Yes" est sélectionné ou désélectionné...
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor: _isYesSelected
                          ? MaterialStateProperty.all<Color>(Theme.of(context)
                              .colorScheme
                              .primary) // Couleur de fond lorsque sélectionné
                          : MaterialStateProperty.all<Color>(Theme.of(context)
                              .colorScheme
                              .background) // Couleur de fond par défaut
                      ),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: _isYesSelected
                          ? Theme.of(context).colorScheme.background
                          : Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isNoSelected = !_isNoSelected;
                      _isYesSelected = false;
                      // Autres logiques à effectuer lorsque "Yes" est sélectionné ou désélectionné...
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor: _isNoSelected
                          ? MaterialStateProperty.all<Color>(Theme.of(context)
                              .colorScheme
                              .primary) // Couleur de fond lorsque sélectionné
                          : MaterialStateProperty.all<Color>(Theme.of(context)
                              .colorScheme
                              .background) // Couleur de fond par défaut
                      ),
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: _isNoSelected
                          ? Theme.of(context).colorScheme.background
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Step(
        isActive: _currentStep == 2,
        title: const Text(''),
        content: Column(
          children: [
            const Text('Nombre de joueurs par équipe :'),
            const SizedBox(
                height:
                    20), // Espacement entre le champ de texte et les boutons
            if (_nbPlayersController.text.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Centrer les boutons horizontalement
                mainAxisSize: MainAxisSize.min,
                children:
                    _buildTeamSizeButtons(int.parse(_nbPlayersController.text)),
              ),
          ],
        ),
      ),
      Step(
        isActive: _currentStep == 3,
        title: const Text(''),
        content: Column(
          children: List.generate(
            _teams.length,
            (teamIndex) {
              return Column(
                children: [
                  if (_isYesSelected) Text('Team ${teamIndex + 1}:'),
                  ...List.generate(
                    _teams[teamIndex].length,
                    (playerIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            _teams[teamIndex][playerIndex] = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Player ${playerIndex + 1} Name',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ];
  }
}
