import 'package:flutter_test/flutter_test.dart';
import 'package:student_attendance_app/main.dart';
import 'package:student_attendance_app/models/student.dart';

void main() {
  test('Student model calculates attendance percentage accurately', () {
    const student = Student(
      id: 'test-1',
      rollNumber: '21CS001',
      name: 'Test Student',
      email: 'test@college.edu',
      course: 'Computer Science',
      semester: 'Semester 6',
      avatarUrl: '',
      totalClasses: 40,
      attendedClasses: 30,
    );

    expect(student.attendancePercentage, 75.0);
    expect(student.formattedPercentage, '75.0%');
  });

  testWidgets('App smoke test loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const AttendanceApp());
    expect(find.byType(AttendanceApp), findsOneWidget);
    // Drain pending timers from SplashScreen auto-navigation
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
