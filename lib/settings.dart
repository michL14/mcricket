import 'package:flutter/material.dart';
import 'package:mcricket/appbar.dart';

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
  const PlayersForm({Key? key}) : super(key: key);

  @override
  PlayersFormState createState() => PlayersFormState();
}

class PlayersFormState extends State<PlayersForm> {
  final _nbPlayersController = TextEditingController();
  final _nbTeamsController = TextEditingController();
  List<TextEditingController> _namePlayersController = [];
  int _currentStep = 0;
  String errorText = '';
  int nb_teams = 0;
  List<List<int>> _teams = [];
  bool _isYesSelected =
      false; // Déclaration de _isYesSelected avec une valeur initiale de false
  bool _isNoSelected = false;
  List<TextEditingController> controller = [];

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
                          if (int.parse(_nbPlayersController.text) < 1 &&
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
                          (_nbPlayersController.text == '1' ||
                              _nbPlayersController.text == '2')) {
                        errorText = 'You are not enough 😏';
                      }
                      if (_isNoSelected) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Lancement de la partie..'),
                              content: const Text('Yes'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                )
                              ],
                            );
                          },
                        );
                      }
                      break;
                    case 2:
                      if (_nbTeamsController.text.isEmpty) {
                        errorText =
                            'Please enter a number of players per teams';
                      } else {
                        if (int.tryParse(_nbTeamsController.text) == null) {
                          errorText = 'Please enter a valid number';
                        } else {
                          if (int.parse(_nbTeamsController.text) < 1 &&
                              int.parse(_nbTeamsController.text) > 10) {
                            errorText =
                                'Please enter a number between 1 and 10';
                          }
                          nb_teams = int.parse(_nbTeamsController.text);
                        }
                      }
                      break;
                    case 3:
                      for (var controller in _namePlayersController) {
                        if (controller.text.isEmpty) {
                          errorText = 'Please enter a name for every players';
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
                            title: const Text('Lancement de la partie..'),
                            content: const Text('Yes'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      if (_currentStep == 2) {
                        makeTeams(int.parse(_nbPlayersController.text),
                            int.parse(_nbTeamsController.text));
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

  void makeTeams(int nbPlayers, int nbTeams) {
    _teams.clear();
    _teams = List.generate(nbTeams, (_) => <int>[]);
    while (nbPlayers > 0) {
      for (int team = 0; team < nbTeams; team++) {
        if (nbPlayers != 0) {
          _teams[team].add(1);
        }
        nbPlayers--;
      }
    }
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
            TextFormField(
              controller: _nbTeamsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of Teams',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
      Step(
        isActive: _currentStep == 3,
        title: const Text(''),
        content: Column(
          children: List.generate(
            _teams.length, // Utilisez le nombre d'équipes
            (teamIndex) {
              return Column(
                children: [
                  Text(
                      'Team ${teamIndex + 1}:'), // Affichez le numéro de l'équipe
                  ...List.generate(
                    _teams[teamIndex]
                        .length, // Utilisez le nombre de joueurs dans l'équipe
                    (playerIndex) {
                      final TextEditingController controller =
                          TextEditingController();
                      _namePlayersController.add(controller);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: 'Player ${playerIndex + 1} Name',
                            border: OutlineInputBorder(),
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
