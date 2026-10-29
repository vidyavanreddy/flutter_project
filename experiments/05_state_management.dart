import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'attendance_provider.dart';

// Experiment 5(b): Global State Management using Provider
// Demonstrates ChangeNotifier, ChangeNotifierProvider, and Provider.of / Consumer.

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AttendanceSessionModel(),
      child: const StateManagementAttendanceApp(),
    ),
  );
}

class StateManagementAttendanceApp extends StatelessWidget {
  const StateManagementAttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const ProviderAttendanceScreen(),
    );
  }
}

class ProviderAttendanceScreen extends StatelessWidget {
  const ProviderAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AttendanceSessionModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance State with Provider')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Session Attendance Percentage', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text(
                '${model.rate.toStringAsFixed(1)}%',
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _metric('Present', '${model.present}', Colors.green),
                  _metric('Absent', '${model.absent}', Colors.red),
                  _metric('Total Enrolled', '${model.total}', Colors.blueGrey),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => model.incrementPresent(),
                    icon: const Icon(Icons.check),
                    label: const Text('Mark Present'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => model.incrementAbsent(),
                    icon: const Icon(Icons.close),
                    label: const Text('Mark Absent'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => model.reset(),
                child: const Text('Reset Session State'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metric(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }
}

