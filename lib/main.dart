import 'package:flutter/material.dart';
import 'features/session/ui/countdown_start_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ZeroScrollApp());
}

class ZeroScrollApp extends StatelessWidget {
  const ZeroScrollApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZeroScroll',
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(
          child: Text(
            "ZeroScroll Loaded",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}