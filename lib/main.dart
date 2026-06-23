import 'package:flutter/material.dart';
import 'package:zeroscroll/core/session/session_model.dart';
import 'core/session/session_engine.dart';
import 'features/session/ui/focus_mode_screen.dart';
import 'features/session/ui/session_entry_screen.dart';

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
      home: const RootRouter(),
    );
  }
}

class RootRouter extends StatefulWidget {
  const RootRouter({super.key});

  @override
  State<RootRouter> createState() => _RootRouterState();
}

class _RootRouterState extends State<RootRouter> {
  bool? isActive;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() {
    final session = SessionEngine.instance.currentSession;

    setState(() {
      isActive = session != null && session.status == SessionStatus.active;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isActive == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (isActive == true) {
      return FocusModeScreen(
        endTime: SessionEngine.instance.currentSession!.endTime,
      );
    }

    return const SessionEntryScreen();
  }
}