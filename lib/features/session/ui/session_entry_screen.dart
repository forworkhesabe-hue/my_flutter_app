import 'package:flutter/material.dart';
import 'countdown_start_screen.dart';
import '../../../core/session/session_model.dart';

class SessionEntryScreen extends StatelessWidget {
  const SessionEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CountdownStartScreen(
                  name: "Focus Session",
                  durationMinutes: 25,
                  blockedApps: ["com.instagram.android"],
                  mode: SessionMode.hard,
                  ownerId: "local",
                ),
              ),
            );
          },
          child: const Text("Start Session"),
        ),
      ),
    );
  }
}