import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_attendance_app/models/student.dart';
import 'package:student_attendance_app/providers/attendance_provider.dart';
import 'package:student_attendance_app/widgets/student_card.dart';

void main() {
  group('Experiment 10: Attendance App Widget & Model Tests', () {
    test('Attendance percentage calculation test', () {
      const student = Student(
        id: 's1',
        rollNumber: '21CS001',
        name: 'Vidyavan Reddy',
        email: 'vidyavan@college.edu',
        course: 'Computer Science',
        semester: 'Semester 6',
        avatarUrl: '',
        totalClasses: 50,
        attendedClasses: 45,
      );

      expect(student.attendancePercentage, 90.0);
      expect(student.formattedPercentage, '90.0%');
    });

    test('AttendanceProvider state mutations test', () {
      final provider = AttendanceProvider();
      final initialCount = provider.totalCount;

      expect(initialCount, greaterThan(0));

      provider.markAllPresent();
      expect(provider.presentCount, initialCount);
      expect(provider.absentCount, 0);

      provider.markAllAbsent();
      expect(provider.absentCount, initialCount);
      expect(provider.presentCount, 0);
    });

    testWidgets('StudentCard renders student name and roll number',
        (WidgetTester tester) async {
      const student = Student(
        id: 's1',
        rollNumber: '21CS001',
        name: 'Vidyavan Reddy',
        email: 'vidyavan@college.edu',
        course: 'Computer Science',
        semester: 'Semester 6',
        avatarUrl: '',
        totalClasses: 40,
        attendedClasses: 35,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StudentCard(student: student),
          ),
        ),
      );

      expect(find.text('Vidyavan Reddy'), findsOneWidget);
      expect(find.text('21CS001'), findsOneWidget);
    });
  });
}
