import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../core/session/session_engine.dart';
import '../../../core/session/session_factory.dart';
import '../../../core/session/session_model.dart';
import 'focus_mode_screen.dart';

class CountdownStartScreen extends StatefulWidget {
  final String name;
  final int durationMinutes;
  final List<String> blockedApps;
  final SessionMode mode;
  final String ownerId;

  const CountdownStartScreen({
    super.key,
    required this.name,
    required this.durationMinutes,
    required this.blockedApps,
    required this.mode,
    required this.ownerId,
  });

  @override
  State<CountdownStartScreen> createState() => _CountdownStartScreenState();
}

class _CountdownStartScreenState extends State<CountdownStartScreen>
    with SingleTickerProviderStateMixin {
  int countdown = 10;
  Timer? timer;
  final player = AudioPlayer();

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _startCountdown();
  }

  void _startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) async {
      if (countdown > 0) {
        setState(() => countdown--);

        // 🔊 tick sound
        await player.play(AssetSource('tick.mp3'));
      } else {
        t.cancel();
        _startSession();
      }
    });
  }

  Future<void> _startSession() async {
    final session = SessionFactory.create(
      name: widget.name,
      durationMinutes: widget.durationMinutes,
      blockedApps: widget.blockedApps,
      mode: widget.mode,
      ownerId: widget.ownerId,
    );

    await SessionEngine.instance.activateSession(widget.blockedApps);
    SessionEngine.instance.createSession(session);
    SessionEngine.instance.startSession();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => FocusModeScreen(endTime: session.endTime),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Transform.scale(
                scale: 1 + (controller.value * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "GET READY",
                      style: TextStyle(
                        color: Colors.white54,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "$countdown",
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 90,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Focus session is starting...",
                      style: TextStyle(color: Colors.white30),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}