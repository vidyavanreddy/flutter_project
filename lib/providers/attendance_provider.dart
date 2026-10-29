import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/attendance_record.dart';
import '../utils/mock_data.dart';

/// Provider class demonstrating Experiment 5: Global State Management with ChangeNotifier
class AttendanceProvider extends ChangeNotifier {
  List<Student> _students = [];
  List<AttendanceRecord> _history = [];

  String _searchQuery = '';
  String _selectedCourse = 'All';
  DateTime _selectedDate = DateTime.now();
  String _selectedSubject = 'Mobile App Development (Flutter)';

  AttendanceProvider() {
    _students = MockData.getInitialStudents();
    _history = MockData.getInitialHistory();
  }

  // Getters
  List<Student> get allStudents => List.unmodifiable(_students);
  List<AttendanceRecord> get history => List.unmodifiable(_history);
  String get searchQuery => _searchQuery;
  String get selectedCourse => _selectedCourse;
  DateTime get selectedDate => _selectedDate;
  String get selectedSubject => _selectedSubject;

  /// Filtered students based on search query and selected course
  List<Student> get filteredStudents {
    return _students.where((student) {
      final matchesSearch = student.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          student.rollNumber
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

      final matchesCourse = _selectedCourse == 'All' ||
          student.course.toLowerCase() == _selectedCourse.toLowerCase();

      return matchesSearch && matchesCourse;
    }).toList();
  }

  /// All unique courses available in current dataset
  List<String> get availableCourses {
    final courses = _students.map((s) => s.course).toSet().toList();
    courses.sort();
    return ['All', ...courses];
  }

  // Summary Metrics
  int get totalCount => _students.length;

  int get presentCount =>
      _students.where((s) => s.todayStatus == AttendanceStatus.present).length;

  int get absentCount =>
      _students.where((s) => s.todayStatus == AttendanceStatus.absent).length;

  int get lateCount =>
      _students.where((s) => s.todayStatus == AttendanceStatus.late).length;

  int get notMarkedCount =>
      _students.where((s) => s.todayStatus == AttendanceStatus.notMarked).length;

  double get todayAttendancePercentage {
    if (totalCount == 0) return 0.0;
    return ((presentCount + lateCount) / totalCount) * 100.0;
  }

  double get overallAveragePercentage {
    if (_students.isEmpty) return 0.0;
    final total =
        _students.fold<double>(0.0, (sum, s) => sum + s.attendancePercentage);
    return total / _students.length;
  }

  // State mutation methods (all invoke notifyListeners())

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCourse(String course) {
    _selectedCourse = course;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedSubject(String subject) {
    _selectedSubject = subject;
    notifyListeners();
  }

  /// Mark attendance for an individual student
  void markAttendance(String studentId, AttendanceStatus status) {
    final index = _students.indexWhere((s) => s.id == studentId);
    if (index != -1) {
      final current = _students[index];

      int newAttended = current.attendedClasses;
      if (current.todayStatus != AttendanceStatus.present &&
          (status == AttendanceStatus.present || status == AttendanceStatus.late)) {
        newAttended++;
      } else if ((current.todayStatus == AttendanceStatus.present ||
              current.todayStatus == AttendanceStatus.late) &&
          status == AttendanceStatus.absent) {
        if (newAttended > 0) newAttended--;
      }

      _students[index] = current.copyWith(
        todayStatus: status,
        attendedClasses: newAttended,
      );
      notifyListeners();
    }
  }

  /// Mark all students as present
  void markAllPresent() {
    _students = _students.map((student) {
      int newAttended = student.attendedClasses;
      if (student.todayStatus != AttendanceStatus.present &&
          student.todayStatus != AttendanceStatus.late) {
        newAttended++;
      }
      return student.copyWith(
        todayStatus: AttendanceStatus.present,
        attendedClasses: newAttended,
      );
    }).toList();
    notifyListeners();
  }

  /// Mark all students as absent
  void markAllAbsent() {
    _students = _students.map((student) {
      int newAttended = student.attendedClasses;
      if (student.todayStatus == AttendanceStatus.present ||
          student.todayStatus == AttendanceStatus.late) {
        if (newAttended > 0) newAttended--;
      }
      return student.copyWith(
        todayStatus: AttendanceStatus.absent,
        attendedClasses: newAttended,
      );
    }).toList();
    notifyListeners();
  }

  /// Reset today's attendance status to not marked
  void resetTodayAttendance() {
    _students = _students
        .map((s) => s.copyWith(todayStatus: AttendanceStatus.notMarked))
        .toList();
    notifyListeners();
  }

  /// Save current attendance session to history
  void submitCurrentSession(String subject, String remarks) {
    final Map<String, AttendanceStatus> recordMap = {};
    for (var student in _students) {
      recordMap[student.id] = student.todayStatus;
    }

    final newRecord = AttendanceRecord(
      id: 'rec-${DateTime.now().millisecondsSinceEpoch}',
      date: _selectedDate,
      course: _selectedCourse == 'All' ? 'Combined Classes' : _selectedCourse,
      subject: subject.isEmpty ? _selectedSubject : subject,
      studentStatus: recordMap,
      remarks: remarks.isEmpty ? 'Regular Session' : remarks,
    );

    _history.insert(0, newRecord);
    notifyListeners();
  }

  /// Add new student
  void addStudent(Student student) {
    _students.add(student);
    notifyListeners();
  }

  /// Delete student by id
  void deleteStudent(String id) {
    _students.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  /// Get student by ID
  Student? getStudentById(String id) {
    try {
      return _students.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }
}
