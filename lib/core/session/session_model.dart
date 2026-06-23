enum SessionStatus {
  created,
  ready,
  active,
  locked,
  running,
  warning,
  ending,
  finished,
}

enum SessionMode {
  soft,
  medium,
  hard,
}

class SessionModel {
  final String id;
  final String name;

  final DateTime startTime;
  final DateTime endTime;

  final SessionStatus status;
  final SessionMode mode;

  final List<String> blockedApps;

  final int emergencyUsedCount;

  final bool partnerApprovalRequired;

  final String ownerId;

  final bool isSynced;

  SessionModel({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.mode,
    required this.blockedApps,
    required this.emergencyUsedCount,
    required this.partnerApprovalRequired,
    required this.ownerId,
    required this.isSynced,
  });

  SessionModel copyWith({
    SessionStatus? status,
    int? emergencyUsedCount,
    bool? isSynced,
  }) {
    return SessionModel(
      id: id,
      name: name,
      startTime: startTime,
      endTime: endTime,
      status: status ?? this.status,
      mode: mode,
      blockedApps: blockedApps,
      emergencyUsedCount: emergencyUsedCount ?? this.emergencyUsedCount,
      partnerApprovalRequired: partnerApprovalRequired,
      ownerId: ownerId,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}