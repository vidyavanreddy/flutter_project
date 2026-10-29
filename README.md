# Student Attendance App (Flutter & Dart)

A cross-platform Student Attendance Management application developed using **Flutter** and **Dart**, based on the academic lab syllabus experiments.

---

## 📌 Project Overview
The Student Attendance App enables faculty and educators to mark, manage, and monitor student attendance across classes and departments. The application leverages Flutter's reactive widget system and Dart's object-oriented architecture to deliver an interactive, responsive experience across mobile, tablet, and web platforms.

### Syllabus Experiments Implemented:
| Experiment | Topic Covered | Implementation in App |
| :--- | :--- | :--- |
| **Experiment 1** | Introduction to Flutter & Dart SDK | Application entry point (`main()`, `runApp()`), `MaterialApp`, `Student` & `AttendanceRecord` Dart data models. |
| **Experiment 2** | Fundamental Widgets & Layouts | `Row`, `Column`, `Stack`, `Container`, `Card`, `Icon`, `Text`, `ElevatedButton`. |
| **Experiment 3** | Responsive UI & Media Queries | `MediaQuery` breakpoint (`< 600px` for Mobile `ListView.builder` vs `GridView.builder` for Tablet/Desktop). |
| **Experiment 4** | Navigation & Screen Transitions | `Navigator.push()`, `Navigator.pop()`, `MaterialPageRoute`, and Named Routes (`/`, `/login`, `/dashboard`, `/mark-attendance`, etc.). |
| **Experiment 5** | Stateful / Stateless & State Management | Local state with `setState()`, global state management using `Provider` (`ChangeNotifier`, `ChangeNotifierProvider`). |
| **Login Module** | Form Validation & Text Controllers | `Form`, `GlobalKey<FormState>`, `TextEditingController`, email regex/at-sign check, password length validation, visibility toggle. |

---

## 🏗️ Project Architecture & File Hierarchy

```text
flutter_project/
├── pubspec.yaml                       # Dependencies (flutter, provider, intl, flutter_lints)
├── analysis_options.yaml              # Linting and static analysis rules
├── web/                               # Web support files (Chrome/Web runner)
│   ├── index.html
│   └── manifest.json
├── test/
│   └── widget_test.dart               # Unit and widget tests
└── lib/
    ├── main.dart                      # Root entry, Named routes, MultiProvider setup
    ├── models/
    │   ├── student.dart               # Student entity with percentage calculation & status enums
    │   └── attendance_record.dart     # Historical session log model
    ├── providers/
    │   └── attendance_provider.dart   # ChangeNotifier handling students list, metrics, and actions
    ├── screens/
    │   ├── splash_screen.dart         # Intro screen with Stack decorative circles and auto-route
    │   ├── login_screen.dart          # Form validation login screen (Experiment 8 syllabus)
    │   ├── dashboard_screen.dart      # Responsive dashboard with stats, Stack header & Drawer
    │   ├── mark_attendance_screen.dart# Real-time attendance marking with bulk actions & counters
    │   ├── students_list_screen.dart  # Responsive student directory with search & filter
    │   ├── student_detail_screen.dart # Student profile with Stack avatar, gauge, and history
    │   ├── attendance_history_screen.dart # Past date logs and attendance rate breakdown
    │   └── add_student_screen.dart    # New student registration form with validators
    ├── widgets/
    │   ├── student_card.dart          # Card widget with Row, Column, Stack status badge & buttons
    │   ├── stat_card.dart             # Metric card (Container, Row, Column, Icon, Text)
    │   └── responsive_builder.dart    # Responsive helper with MediaQuery breakpoints
    └── utils/
        └── mock_data.dart             # Pre-populated student and session datasets
```

---

## 🚀 Key Features

1. **Faculty & Admin Login with Validations**:
   - `GlobalKey<FormState>` input validation.
   - Email format checking (must contain `@`).
   - Password security validator (minimum 6 characters).
   - Password obscure toggle (`visibility` / `visibility_off`).
   - Quick one-click "Autofill Demo Credentials" button for lab assessment.

2. **Interactive Attendance Marking**:
   - Mark students as **Present**, **Absent**, or **Late**.
   - Bulk actions: **Mark All Present**, **Mark All Absent**, and **Reset**.
   - Live counter tracking present, absent, late, and turnout rate.
   - Date picker to record attendance for any calendar date.
   - Filter by course/branch and real-time student search.

3. **Responsive UI for All Screen Sizes**:
   - Adapts dynamically between mobile screens (< 600px) and tablet/desktop screens (≥ 600px).
   - Seamlessly switches between `ListView.builder` and `GridView.builder`.

4. **Multi-Screen Navigation**:
   - Uses both Flutter **Named Routes** and direct **MaterialPageRoute** with parameter passing.
   - Back navigation handled via `Navigator.pop()`.

5. **State Management with Provider & setState**:
   - `AttendanceProvider extends ChangeNotifier` notifies all listening widgets when attendance changes.
   - Local state handled with `setState` for UI toggles, date pickers, and controllers.

---

## 💻 How to Run the Application

### Prerequisites:
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Google Chrome (for web) or Android Studio / VS Code with an emulator or connected device

### Steps to Run:
```bash
# 1. Clone the repository
git clone https://github.com/vidyavanreddy/flutter_project.git
cd flutter_project

# 2. Get dependencies
flutter pub get

# 3. Run on Chrome (Web)
flutter run -d chrome

# 4. Or run on an Android Device / Emulator
flutter run
```

---

## 👨‍💻 Author & Repository
- **GitHub Repository**: [https://github.com/vidyavanreddy/flutter_project.git](https://github.com/vidyavanreddy/flutter_project.git)
- **Lab Course**: Mobile Application Development with Flutter & Dart
