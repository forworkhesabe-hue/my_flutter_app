import 'session_model.dart';

class SessionFactory {
  static SessionModel create({
    required String name,
    required int durationMinutes,
    required List<String> blockedApps,
    required SessionMode mode,
    required String ownerId,
  }) {
    final start = DateTime.now();
    final end = start.add(Duration(minutes: durationMinutes));

    return SessionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      startTime: start,
      endTime: end,
      status: SessionStatus.created,
      mode: mode,
      blockedApps: blockedApps,
      emergencyUsedCount: 0,
      partnerApprovalRequired: false,
      ownerId: ownerId,
      isSynced: false,
    );
  }
}