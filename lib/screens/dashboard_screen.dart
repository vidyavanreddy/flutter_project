import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';
import '../models/student.dart';
import '../widgets/stat_card.dart';
import '../widgets/student_card.dart';
import 'student_detail_screen.dart';

/// Dashboard Screen demonstrating:
/// 1. Experiment 2: Row, Column, Stack, Container, Icon, Text layouts
/// 2. Experiment 3: Responsive layout using MediaQuery (< 600px breakpoint)
/// 3. Experiment 4: Navigation with Named Routes & MaterialPageRoute
/// 4. Experiment 5: Provider state consumption
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attendance = Provider.of<AttendanceProvider>(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Dashboard'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.pushNamed(context, '/students'),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header Card built with STACK widget (Experiment 2 syllabus)
            _buildHeaderCard(context, attendance),
            const SizedBox(height: 20),

            // Statistics Section Title
            const Text(
              'Session Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Responsive Metrics Grid or Column (Experiment 3 syllabus)
            isWideScreen
                ? GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.8,
                    children: _buildMetricCards(attendance),
                  )
                : GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: _buildMetricCards(attendance),
                  ),

            const SizedBox(height: 24),

            // Quick Actions Section Title
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Action Buttons in responsive Row / Grid
            _buildActionButtons(context),

            const SizedBox(height: 24),

            // Section Header with View All Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Today's Students Status",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/mark-attendance'),
                  child: const Text('Mark All'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Students List showing responsive card view
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: attendance.allStudents.take(5).length,
              itemBuilder: (context, index) {
                final student = attendance.allStudents[index];
                return StudentCard(
                  student: student,
                  onTap: () {
                    // Experiment 4: Navigation with Navigator.push & MaterialPageRoute
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentDetailScreen(studentId: student.id),
                      ),
                    );
                  },
                  onStatusChanged: (status) {
                    attendance.markAttendance(student.id, status);
                  },
                );
              },
            ),
            const SizedBox(height: 12),

            // Bottom View More Button
            Center(
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/students'),
                icon: const Icon(Icons.people),
                label: const Text('View All Registered Students'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/mark-attendance'),
        icon: const Icon(Icons.check),
        label: const Text('Take Attendance'),
      ),
    );
  }

  /// Stack Widget Demonstration: Header with decorative background & positioned badges
  Widget _buildHeaderCard(BuildContext context, AttendanceProvider attendance) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade600,
            Colors.deepPurple.shade900,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative Stack circles in background (Experiment 2 Stack demo)
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            right: 40,
            bottom: -30,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          // Main Card Content (Column & Row layouts)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 13, color: Colors.white),
                          SizedBox(width: 6),
                          Text(
                            'Active Session',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${attendance.todayAttendancePercentage.toStringAsFixed(1)}% Turnout',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'Welcome, Prof. Reddy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  attendance.selectedSubject,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: attendance.totalCount > 0
                        ? (attendance.presentCount + attendance.lateCount) /
                            attendance.totalCount
                        : 0.0,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.greenAccent,
                    ),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMetricCards(AttendanceProvider attendance) {
    return [
      StatCard(
        title: 'Total Students',
        value: '${attendance.totalCount}',
        icon: Icons.groups,
        primaryColor: Colors.blue.shade700,
      ),
      StatCard(
        title: 'Present Today',
        value: '${attendance.presentCount}',
        icon: Icons.check_circle,
        primaryColor: Colors.green.shade700,
      ),
      StatCard(
        title: 'Absent Today',
        value: '${attendance.absentCount}',
        icon: Icons.cancel,
        primaryColor: Colors.red.shade700,
      ),
      StatCard(
        title: 'Avg. Attendance',
        value: '${attendance.overallAveragePercentage.toStringAsFixed(1)}%',
        icon: Icons.analytics,
        primaryColor: Colors.deepPurple.shade700,
      ),
    ];
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButtonItem(
            context,
            icon: Icons.edit_calendar,
            label: 'Mark\nAttendance',
            color: Colors.deepPurple,
            onTap: () => Navigator.pushNamed(context, '/mark-attendance'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildActionButtonItem(
            context,
            icon: Icons.people_outline,
            label: 'Student\nDirectory',
            color: Colors.teal,
            onTap: () => Navigator.pushNamed(context, '/students'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildActionButtonItem(
            context,
            icon: Icons.history,
            label: 'Past\nRecords',
            color: Colors.indigo,
            onTap: () => Navigator.pushNamed(context, '/history'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildActionButtonItem(
            context,
            icon: Icons.person_add_alt,
            label: 'Add\nStudent',
            color: Colors.orange.shade800,
            onTap: () => Navigator.pushNamed(context, '/add-student'),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtonItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 26, color: color),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade900],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.school, size: 36, color: Colors.deepPurple),
                ),
                SizedBox(height: 10),
                Text(
                  'Department of CSE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Faculty Attendance Portal',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.check_circle_outline),
            title: const Text('Mark Attendance'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/mark-attendance');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Student Directory'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/students');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Attendance Records'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/history');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Add New Student'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/add-student');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
