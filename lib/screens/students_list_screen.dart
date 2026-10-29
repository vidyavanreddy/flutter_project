import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';
import '../widgets/student_card.dart';
import 'student_detail_screen.dart';

/// Students Directory Screen demonstrating:
/// 1. Experiment 3: Responsive ListView (< 600px) vs GridView (>= 600px)
/// 2. Experiment 4: Navigation with Navigator.push() and MaterialPageRoute
/// 3. Passing student parameters between screens
class StudentsListScreen extends StatelessWidget {
  const StudentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Directory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Student',
            onPressed: () => Navigator.pushNamed(context, '/add-student'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter & Search Controls
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search students...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onChanged: (val) => provider.setSearchQuery(val),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: provider.selectedCourse,
                        isExpanded: true,
                        items: provider.availableCourses
                            .map((c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(
                                    c,
                                    style: const TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) provider.setSelectedCourse(val);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Total Count Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${provider.filteredStudents.length} of ${provider.totalCount} students',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Filter: ${provider.selectedCourse}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),

          // Responsive List / Grid (Experiment 3 syllabus)
          Expanded(
            child: provider.filteredStudents.isEmpty
                ? const Center(
                    child: Text('No students found'),
                  )
                : isWide
                    ? GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 8,
                          childAspectRatio: 2.8,
                        ),
                        itemCount: provider.filteredStudents.length,
                        itemBuilder: (context, index) {
                          final student = provider.filteredStudents[index];
                          return StudentCard(
                            student: student,
                            showActions: false,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentDetailScreen(
                                      studentId: student.id),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 8, bottom: 20),
                        itemCount: provider.filteredStudents.length,
                        itemBuilder: (context, index) {
                          final student = provider.filteredStudents[index];
                          return StudentCard(
                            student: student,
                            showActions: false,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentDetailScreen(
                                      studentId: student.id),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-student'),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
