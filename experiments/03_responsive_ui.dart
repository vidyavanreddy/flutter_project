import 'package:flutter/material.dart';

// Experiment 3: Responsive UI that adapts to different screen sizes.
// Implements media queries and breakpoints (< 600px: ListView vs >= 600px: GridView).

void main() {
  runApp(const ResponsiveAttendanceApp());
}

class ResponsiveAttendanceApp extends StatelessWidget {
  const ResponsiveAttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const ResponsiveAttendanceHome(),
    );
  }
}

class ResponsiveAttendanceHome extends StatelessWidget {
  const ResponsiveAttendanceHome({super.key});

  final List<Map<String, String>> students = const [
    {"name": "Vidyavan Reddy", "roll": "21CS001", "course": "Computer Science", "rate": "93.3%", "status": "Present"},
    {"name": "Ananya Sharma", "roll": "21CS002", "course": "Computer Science", "rate": "97.8%", "status": "Present"},
    {"name": "Vikram Patel", "roll": "21CS003", "course": "Computer Science", "rate": "77.8%", "status": "Late"},
    {"name": "Sneha Rao", "roll": "21CS004", "course": "Information Tech", "rate": "62.2%", "status": "Absent"},
    {"name": "Aditya Nair", "roll": "21CS005", "course": "Computer Science", "rate": "88.9%", "status": "Present"},
    {"name": "Pooja Singh", "roll": "21CS006", "course": "Information Tech", "rate": "84.4%", "status": "Present"},
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Attendance (${isMobile ? "Mobile" : "Tablet/Web"})'),
      ),
      body: isMobile
          // Mobile Screen Layout: ListView.builder
          ? ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: students.length,
              itemBuilder: (context, index) => _buildCard(students[index]),
            )
          // Tablet & Desktop Layout: GridView.builder with 2 columns
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.5,
              ),
              itemCount: students.length,
              itemBuilder: (context, index) => _buildCard(students[index]),
            ),
    );
  }

  Widget _buildCard(Map<String, String> student) {
    final isPresent = student["status"] == "Present";
    final isAbsent = student["status"] == "Absent";

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isPresent ? Colors.green.shade100 : (isAbsent ? Colors.red.shade100 : Colors.orange.shade100),
              child: Icon(
                isPresent ? Icons.check : (isAbsent ? Icons.close : Icons.access_time),
                color: isPresent ? Colors.green : (isAbsent ? Colors.red : Colors.orange),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(student["name"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('${student["roll"]} • ${student["course"]}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isPresent ? Colors.green.shade50 : (isAbsent ? Colors.red.shade50 : Colors.orange.shade50),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(student["rate"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

