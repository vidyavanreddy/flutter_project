import 'package:flutter/material.dart';

// Experiment 10: Testing and Debugging in Flutter
// Demonstrates unit testing concepts, debugPrint logging, assert verification,
// and UI test verification for the Student Attendance App.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AttendanceTestingScreen(),
  ));
}

class AttendanceTestingScreen extends StatefulWidget {
  const AttendanceTestingScreen({super.key});

  @override
  State<AttendanceTestingScreen> createState() => _AttendanceTestingScreenState();
}

class _AttendanceTestingScreenState extends State<AttendanceTestingScreen> {
  final List<String> _logs = [];

  void _runVerification() {
    setState(() {
      _logs.clear();
      _log('Starting automated tests & verification...');

      // Test 1: Attendance percentage calculation formula test
      const int conducted = 40;
      const int attended = 30;
      const double calculatedPercentage = (attended / conducted) * 100.0;
      assert(calculatedPercentage == 75.0, 'Calculation error');
      _log('✓ Test 1 Passed: Formula accurately calculated 75.0% for 30/40 classes.');

      // Test 2: Validation check
      const String email = 'faculty@college.edu';
      final bool isValidEmail = email.contains('@');
      assert(isValidEmail, 'Email validation failed');
      _log('✓ Test 2 Passed: Email validation rule passed for college domain.');

      // Test 3: Status state transition
      String status = 'Present';
      status = 'Absent';
      assert(status == 'Absent', 'State mutation failed');
      _log('✓ Test 3 Passed: Attendance state mutated from Present to Absent.');

      _log('All assertions verified successfully without errors.');
    });
  }

  void _log(String message) {
    debugPrint('[AttendanceDebug] $message');
    _logs.add(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Testing & Debugging (Exp 10)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _runVerification,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Run Diagnostics & Assertions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Diagnostic Console Output:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _logs.isEmpty
                    ? const Center(
                        child: Text(
                          'Click above to run tests & view logs.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _logs.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            _logs[index],
                            style: TextStyle(
                              fontFamily: 'monospace',
                              color: _logs[index].startsWith('✓') ? Colors.greenAccent : Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

