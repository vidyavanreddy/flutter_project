import 'package:flutter/material.dart';

// Experiment 4: Navigation between screens using Navigator and Named Routes.
// Demonstrates screen transitions for Student Attendance flow.

void main() {
  runApp(const AttendanceNavApp());
}

class AttendanceNavApp extends StatelessWidget {
  const AttendanceNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/mark': (context) => const MarkScreen(),
        '/details': (context) => const DetailsScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Dashboard (Screen 1)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 16),
            const Text('Student Attendance Management', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate using Named Route
                Navigator.pushNamed(context, '/mark');
              },
              child: const Text('Go to Mark Attendance Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class MarkScreen extends StatelessWidget {
  const MarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mark Attendance (Screen 2)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Mark Attendance for CS-A', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to details screen
                Navigator.pushNamed(context, '/details');
              },
              child: const Text('View Student Details'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                // Go back to previous screen using Navigator.pop
                Navigator.pop(context);
              },
              child: const Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Attendance Profile (Screen 3)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 12),
            const Text('Vidyavan Reddy (21CS001)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Attendance: 42 / 45 (93.3%)', style: TextStyle(fontSize: 16, color: Colors.green)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
