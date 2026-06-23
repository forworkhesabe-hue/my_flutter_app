import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zeroscroll/core/session/session_engine.dart';

class FocusModeScreen extends StatefulWidget {
  final DateTime endTime;

  const FocusModeScreen({
    super.key,
    required this.endTime,
  });

  @override
  State<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen> {
  late Timer timer;
  Duration remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateRemaining();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemaining();
    });
  }

  void _calculateRemaining() {
    final now = DateTime.now();
    setState(() {
      remaining = widget.endTime.difference(now);

      if (remaining.isNegative) {
        SessionEngine.instance.endSession();
        Navigator.pop(context);
      }
    });
  }

  String format(Duration d) {
    return "${d.inHours.toString().padLeft(2, '0')}:"
        "${(d.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const Text(
              "FOCUS MODE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              format(remaining),
              style: const TextStyle(
                color: Colors.green,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Stay locked. Stay consistent.",
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}