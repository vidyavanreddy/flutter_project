import 'package:flutter/material.dart';

/// Demonstrates Experiment 3 (Responsive UI using MediaQuery and Breakpoints)
class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Check if device is mobile (< 600px width as defined in syllabus)
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  /// Check if device is tablet (600px - 1024px width)
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;

  /// Check if device is desktop / wide screen (>= 1024px width)
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (width >= 1024 && desktop != null) {
      return desktop!;
    }

    if (width >= 600 && tablet != null) {
      return tablet!;
    }

    return mobile;
  }
}
