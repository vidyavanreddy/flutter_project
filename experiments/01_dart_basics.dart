// Experiment 1: Simple Dart program to understand language basics and attendance calculations.
// Covers variables, primitive data types, arithmetic, string interpolation,
// and conditional eligibility decisions for student attendance.

void main() {
  // Student Information Variables
  String studentName = 'Vidyavan Reddy';
  String rollNumber = '21CS001';
  String course = 'Computer Science & Engineering';
  int semester = 6;
  bool isEnrolled = true;

  print('=== Student Attendance Record ===');
  print('Name: $studentName');
  print('Roll Number: $rollNumber');
  print('Course: $course');
  print('Semester: $semester');
  print('Active Enrollment: $isEnrolled');

  // Attendance Metrics & Arithmetic Operations
  int totalConductedClasses = 45;
  int classesAttended = 40;
  int classesMissed = totalConductedClasses - classesAttended;

  // Calculate Attendance Percentage
  double attendancePercentage = (classesAttended / totalConductedClasses) * 100.0;

  print('--- Attendance Statistics ---');
  print('Total Classes Conducted: $totalConductedClasses');
  print('Classes Attended: $classesAttended');
  print('Classes Missed: $classesMissed');
  print('Attendance Percentage: ${attendancePercentage.toStringAsFixed(1)}%');

  // University Eligibility Conditional Statement (75% Minimum Criterion)
  const double minimumRequiredPercentage = 75.0;

  if (attendancePercentage >= minimumRequiredPercentage) {
    print('Result: Eligible for Semester Exams (Good Standing)');
  } else {
    int requiredMoreClasses = ((minimumRequiredPercentage * totalConductedClasses - 100 * classesAttended) / (100 - minimumRequiredPercentage)).ceil();
    print('Result: Shortage Alert! Must attend $requiredMoreClasses consecutive classes to qualify.');
  }
}
