import 'package:flutter/material.dart';

// Experiment 2: Explore fundamental Flutter widgets and layout using Row, Column and Stack.
// Demonstrates building a Student Attendance card interface with stacked avatar status
// badges and aligned metric rows.

void main() {
  runApp(const AttendanceWidgetsApp());
}

class AttendanceWidgetsApp extends StatelessWidget {
  const AttendanceWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Widgets & Layouts (Exp 2)'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          // Column arranges attendance widgets vertically.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stack places the online/present status badge over the profile header.
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple.shade600, Colors.deepPurple.shade900],
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.school, size: 70, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Text(
                        'Present Today',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Vidyavan Reddy',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Roll: 21CS001 • Computer Science • Semester 6',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Row displays student attendance metrics horizontally.
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _StatBadge(icon: Icons.check_circle, label: '40 Attended', color: Colors.green),
                  _StatBadge(icon: Icons.cancel, label: '5 Missed', color: Colors.red),
                  _StatBadge(icon: Icons.analytics, label: '88.9% Rate', color: Colors.deepPurple),
                ],
              ),
              const SizedBox(height: 24),

              // Attendance Action Buttons Row
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.done),
                      label: const Text('Mark Present'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.close),
                      label: const Text('Mark Absent'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatBadge({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}

