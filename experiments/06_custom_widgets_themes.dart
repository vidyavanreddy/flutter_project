import 'package:flutter/material.dart';

// Experiment 6: Custom Widgets and Themes
// Demonstrates building reusable student attendance widgets and applying global ThemeData.

void main() {
  runApp(const CustomThemeAttendanceApp());
}

class CustomThemeAttendanceApp extends StatelessWidget {
  const CustomThemeAttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      home: const CustomWidgetsScreen(),
    );
  }
}

class CustomWidgetsScreen extends StatelessWidget {
  const CustomWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Widgets & Theme (Exp 6)')),
      body: const Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Custom Reusable Student Attendance Cards:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            AttendanceCardWidget(
              studentName: 'Vidyavan Reddy',
              rollNo: '21CS001',
              course: 'Computer Science',
              percentage: 93.3,
              status: 'Present',
              statusColor: Colors.green,
            ),
            SizedBox(height: 12),
            AttendanceCardWidget(
              studentName: 'Sneha Rao',
              rollNo: '21CS004',
              course: 'Information Technology',
              percentage: 62.2,
              status: 'Absent',
              statusColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceCardWidget extends StatelessWidget {
  final String studentName;
  final String rollNo;
  final String course;
  final double percentage;
  final String status;
  final Color statusColor;

  const AttendanceCardWidget({
    super.key,
    required this.studentName,
    required this.rollNo,
    required this.course,
    required this.percentage,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: statusColor.withValues(alpha: 0.15),
              child: Text(studentName[0], style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(studentName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('$rollNo • $course', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: statusColor.withValues(alpha: 0.3)),
              ),
              child: Text(
                '${percentage.toStringAsFixed(1)}%',
                style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

