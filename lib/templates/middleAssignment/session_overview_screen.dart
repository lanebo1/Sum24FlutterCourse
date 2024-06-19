import 'active_session_screen.dart';
import 'package:flutter/material.dart';
import 'package:gradient_coloured_buttons/gradient_coloured_buttons.dart';
import 'main.dart';
import 'package:provider/provider.dart' as provider;
import 'theme.dart';
import 'app_bar.dart';
class SessionOverviewScreen extends StatelessWidget {
  final ShowerSession session;

  const SessionOverviewScreen({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Session "${session.name}" Overview'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: session.temperaturePhases.length,
              itemBuilder: (context, index) {
                return Text(
                    'Phase: ${session.temperaturePhases[index].temperature}, Duration: ${session.temperaturePhases[index].duration} seconds');
              },
            ),
            GradientButton(
              text: 'Begin Session',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionScreen(
                      session: session,
                    ),
                  ),
                );
              },
              gradientColors: [Colors.green, Colors.green.shade300],
            ),
          ],
        ),
      ),
    );
  }
}
