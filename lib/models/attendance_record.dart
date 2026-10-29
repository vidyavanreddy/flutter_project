import 'student.dart';

/// Represents a historical attendance record for a specific date and course session
class AttendanceRecord {
  final String id;
  final DateTime date;
  final String course;
  final String subject;
  final Map<String, AttendanceStatus> studentStatus; // studentId -> status
  final String remarks;

  const AttendanceRecord({
    required this.id,
    required this.date,
    required this.course,
    required this.subject,
    required this.studentStatus,
    this.remarks = 'Regular Lecture',
  });

  int get presentCount =>
      studentStatus.values.where((s) => s == AttendanceStatus.present).length;

  int get absentCount =>
      studentStatus.values.where((s) => s == AttendanceStatus.absent).length;

  int get lateCount =>
      studentStatus.values.where((s) => s == AttendanceStatus.late).length;

  int get totalCount => studentStatus.length;

  double get attendanceRate {
    if (totalCount == 0) return 0.0;
    return ((presentCount + lateCount) / totalCount) * 100.0;
  }
}
