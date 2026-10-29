import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/attendance_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/mark_attendance_screen.dart';
import 'screens/students_list_screen.dart';
import 'screens/attendance_history_screen.dart';
import 'screens/add_student_screen.dart';

/// Entry point of the Student Attendance Flutter application
/// Demonstrates:
/// - Experiment 1: main(), runApp(), MaterialApp root widget
/// - Experiment 4: Navigation with Named Routes in routes map
/// - Experiment 5: Global state management with ChangeNotifierProvider
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendanceProvider(),
      child: MaterialApp(
        title: 'Student Attendance App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            elevation: 0,
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        // Initial route shown when the app launches (Experiment 4 syllabus)
        initialRoute: '/',
        // Named routes table (Experiment 4 syllabus: 'Navigation with Named Routes')
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/mark-attendance': (context) => const MarkAttendanceScreen(),
          '/students': (context) => const StudentsListScreen(),
          '/history': (context) => const AttendanceHistoryScreen(),
          '/add-student': (context) => const AddStudentScreen(),
        },
      ),
    );
  }
}
