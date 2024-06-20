import 'session_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:gradient_coloured_buttons/gradient_coloured_buttons.dart';
import 'main.dart';
import 'app_bar.dart';

class SessionPreferencesScreen extends StatefulWidget {
  const SessionPreferencesScreen({super.key});

  @override
  _SessionPreferencesScreenState createState() =>
      _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState extends State<SessionPreferencesScreen> {
  String name = '';
  List<TemperaturePhase> phaseDurations = [];
  bool isHotPhase = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Session Configuration'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Session name',
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: phaseDurations.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            phaseDurations[index].duration =
                                int.tryParse(value) ?? 0;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText:
                              'Phase ${phaseDurations[index].temperature} Duration (seconds)',
                        ),
                      ),
                    ),
                    GradientButton(
                      text: 'Change temperature',
                      onPressed: () {
                        setState(() {
                          phaseDurations[index].temperature =
                              phaseDurations[index].temperature == 'Hot'
                                  ? 'Cold'
                                  : 'Hot';
                        });
                      },
                      gradientColors: phaseDurations[index].temperature == 'Hot'
                          ? [Colors.red, Colors.red.shade300]
                          : [Colors.blue, Colors.blue.shade300],
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          phaseDurations.removeAt(index);
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(2.0)),
                  ],
                );
              },
            ),
            const Padding(padding: EdgeInsets.all(2.0)),
            GradientButton(
              text: 'Add Phase',
              onPressed: () {
                setState(() {
                  phaseDurations.add(TemperaturePhase(
                    temperature: isHotPhase ? 'Hot' : 'Cold',
                    duration: 0,
                  ));
                  isHotPhase = !isHotPhase;
                });
              },
              gradientColors: isHotPhase
                  ? [Colors.red, Colors.red.shade300]
                  : [Colors.blue, Colors.blue.shade300],
            ),
            const Padding(padding: EdgeInsets.all(2.0)),
            GradientButton(
              text: 'Next',
              onPressed: () {
                if (!(phaseDurations.every((phase) => phase.duration > 0))) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Please enter a duration for each phase (number, greater than 0)')),
                  );
                } else if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter a name for the session')),
                  );
                } else if (phaseDurations.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Please add at least one phase (number, greater than 0)')),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionOverviewScreen(
                        session: ShowerSession(
                          name: name,
                          comments: '',
                          temperaturePhases: phaseDurations,
                          rating: 0.0,
                          overallDuration: phaseDurations.fold(
                              0, (prev, phase) => prev + phase.duration),
                        ),
                      ),
                    ),
                  );
                }
              },
              gradientColors: [Colors.green, Colors.green.shade300],
            ),
          ],
        ),
      ),
    );
  }
}