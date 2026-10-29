import 'package:flutter/material.dart';

// Experiment 5(a): Local State Management using setState()
// Implements an interactive Student Attendance Counter tracking Present, Absent, and Turnout.

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AttendanceCounterScreen(),
    ));

class AttendanceCounterScreen extends StatefulWidget {
  const AttendanceCounterScreen({super.key});

  @override
  State<AttendanceCounterScreen> createState() => _AttendanceCounterScreenState();
}

class _AttendanceCounterScreenState extends State<AttendanceCounterScreen> {
  int _presentCount = 0;
  int _absentCount = 0;

  int get _totalCount => _presentCount + _absentCount;

  double get _percentage =>
      _totalCount == 0 ? 0.0 : (_presentCount / _totalCount) * 100.0;

  void _markPresent() {
    setState(() {
      _presentCount++;
    });
  }

  void _markAbsent() {
    setState(() {
      _absentCount++;
    });
  }

  void _reset() {
    setState(() {
      _presentCount = 0;
      _absentCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Counter (setState)')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Today Turnout Rate', style: TextStyle(fontSize: 18, color: Colors.grey)),
              Text(
                '${_percentage.toStringAsFixed(1)}%',
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _counterDisplay('Present', '$_presentCount', Colors.green),
                  _counterDisplay('Absent', '$_absentCount', Colors.red),
                  _counterDisplay('Total Marked', '$_totalCount', Colors.blueGrey),
                ],
              ),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _markPresent,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Present'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _markAbsent,
                    icon: const Icon(Icons.remove),
                    label: const Text('Add Absent'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: _reset,
                child: const Text('Reset Session Counter'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _counterDisplay(String title, String count, Color color) {
    return Column(
      children: [
        Text(count, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
        Text(title, style: TextStyle(fontSize: 14, color: color)),
      ],
    );
  }
}
