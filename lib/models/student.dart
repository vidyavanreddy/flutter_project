import 'package:flutter/material.dart';

/// Enum representing the attendance status for a student session
enum AttendanceStatus {
  present,
  absent,
  late,
  notMarked,
}

/// Student data model storing demographic and attendance metrics
class Student {
  final String id;
  final String rollNumber;
  final String name;
  final String email;
  final String course;
  final String semester;
  final String avatarUrl;
  final int totalClasses;
  final int attendedClasses;
  final AttendanceStatus todayStatus;

  const Student({
    required this.id,
    required this.rollNumber,
    required this.name,
    required this.email,
    required this.course,
    required this.semester,
    required this.avatarUrl,
    this.totalClasses = 30,
    this.attendedClasses = 25,
    this.todayStatus = AttendanceStatus.notMarked,
  });

  /// Calculate attendance percentage
  double get attendancePercentage {
    if (totalClasses == 0) return 0.0;
    return (attendedClasses / totalClasses) * 100.0;
  }

  /// Formatted string of percentage (e.g. "83.3%")
  String get formattedPercentage {
    return '${attendancePercentage.toStringAsFixed(1)}%';
  }

  /// Get status color for UI indicators
  Color get statusColor {
    switch (todayStatus) {
      case AttendanceStatus.present:
        return Colors.green;
      case AttendanceStatus.absent:
        return Colors.red;
      case AttendanceStatus.late:
        return Colors.orange;
      case AttendanceStatus.notMarked:
        return Colors.grey;
    }
  }

  /// Status display label
  String get statusLabel {
    switch (todayStatus) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.absent:
        return 'Absent';
      case AttendanceStatus.late:
        return 'Late';
      case AttendanceStatus.notMarked:
        return 'Not Marked';
    }
  }

  /// Create a copy with modified fields
  Student copyWith({
    String? id,
    String? rollNumber,
    String? name,
    String? email,
    String? course,
    String? semester,
    String? avatarUrl,
    int? totalClasses,
    int? attendedClasses,
    AttendanceStatus? todayStatus,
  }) {
    return Student(
      id: id ?? this.id,
      rollNumber: rollNumber ?? this.rollNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      course: course ?? this.course,
      semester: semester ?? this.semester,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      totalClasses: totalClasses ?? this.totalClasses,
      attendedClasses: attendedClasses ?? this.attendedClasses,
      todayStatus: todayStatus ?? this.todayStatus,
    );
  }
}
