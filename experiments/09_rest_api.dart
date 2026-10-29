import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Experiment 9: REST API Integration
// Fetches online student attendance/user records from a REST API using HTTP GET,
// parses JSON and renders with FutureBuilder, loading state, and retry action.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AttendanceRestApiScreen(),
  ));
}

class AttendanceUser {
  final int id;
  final String name;
  final String email;
  final String company;

  AttendanceUser({
    required this.id,
    required this.name,
    required this.email,
    required this.company,
  });

  factory AttendanceUser.fromJson(Map<String, dynamic> json) {
    return AttendanceUser(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      company: json['company'] != null ? json['company']['name'] as String : 'Engineering Dept',
    );
  }
}

class AttendanceRestApiScreen extends StatefulWidget {
  const AttendanceRestApiScreen({super.key});

  @override
  State<AttendanceRestApiScreen> createState() => _AttendanceRestApiScreenState();
}

class _AttendanceRestApiScreenState extends State<AttendanceRestApiScreen> {
  late Future<List<AttendanceUser>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = _fetchUsers();
  }

  Future<List<AttendanceUser>> _fetchUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => AttendanceUser.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load remote attendance directory');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Attendance Directory (Exp 9)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() => _futureUsers = _fetchUsers()),
          ),
        ],
      ),
      body: FutureBuilder<List<AttendanceUser>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => setState(() => _futureUsers = _fetchUsers()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No student records found.'));
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(child: Text('${user.id}')),
                  title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${user.email} • ${user.company}'),
                  trailing: const Icon(Icons.verified_user, color: Colors.green),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

