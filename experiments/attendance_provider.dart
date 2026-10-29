import 'package:flutter/material.dart';

/// Provider model for Experiment 5: Global State Management
class AttendanceSessionModel extends ChangeNotifier {
  int _present = 40;
  int _absent = 5;

  int get present => _present;
  int get absent => _absent;
  int get total => _present + _absent;

  double get rate => total == 0 ? 0.0 : (_present / total) * 100.0;

  void incrementPresent() {
    _present++;
    notifyListeners();
  }

  void incrementAbsent() {
    _absent++;
    notifyListeners();
  }

  void reset() {
    _present = 0;
    _absent = 0;
    notifyListeners();
  }
}

