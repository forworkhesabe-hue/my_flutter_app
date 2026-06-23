import 'dart:async';
import 'dart:convert';
import 'session_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SessionEngine {
  static final SessionEngine instance = SessionEngine._internal();

  SessionEngine._internal();

  SessionModel? _currentSession;
  Timer? _timer;

  SessionModel? get currentSession => _currentSession;

  void createSession(SessionModel session) {
    _currentSession = session;
  }

  void startSession() {
    if (_currentSession == null) return;

    _currentSession = _currentSession!.copyWith(
      status: SessionStatus.active,
    );

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _checkSession();
    });
  }

  void _checkSession() {
    if (_currentSession == null) return;

    final now = DateTime.now();

    if (now.isAfter(_currentSession!.endTime)) {
      endSession();
    }
  }

  void endSession() {
    _timer?.cancel();

    if (_currentSession == null) return;

    _currentSession = _currentSession!.copyWith(
      status: SessionStatus.finished,
    );
  }

  Future<void> activateSession(List<String> blockedApps) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("session_active", true);
  await prefs.setString("blocked_apps", jsonEncode(blockedApps));
}

Future<void> deactivateSession() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("session_active", false);
  await prefs.remove("blocked_apps");
}
}