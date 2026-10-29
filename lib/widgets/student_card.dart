import 'package:flutter/material.dart';
import '../models/student.dart';

/// Student card widget demonstrating:
/// 1. Card & Container styling (Experiment 2)
/// 2. Row and Column layouts (Experiments 2 & 3)
/// 3. Stack widget with Positioned status badge overlay (Experiment 2 / Stack)
/// 4. Action buttons for attendance toggling (Experiment 5)
class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback? onTap;
  final Function(AttendanceStatus)? onStatusChanged;
  final bool showActions;

  const StudentCard({
    super.key,
    required this.student,
    this.onTap,
    this.onStatusChanged,
    this.showActions = true,
  });

  Color _getPercentageColor(double percentage) {
    if (percentage >= 75) return Colors.green.shade700;
    if (percentage >= 60) return Colors.orange.shade800;
    return Colors.red.shade700;
  }

  @override
  Widget build(BuildContext context) {
    final percentColor = _getPercentageColor(student.attendancePercentage);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: student.todayStatus == AttendanceStatus.notMarked
              ? Colors.grey.shade200
              : student.statusColor.withValues(alpha: 0.3),
          width: 1.2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Header Row: Avatar (with Stack) + Student Info + Percentage
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Stack Widget: Avatar image with Positioned status indicator badge
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepPurple.shade50,
                          border: Border.all(
                            color: Colors.deepPurple.shade100,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            student.avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                              child: Text(
                                student.name.isNotEmpty
                                    ? student.name[0]
                                    : 'S',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Positioned status badge (Stack demonstration)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: student.statusColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),

                  // Student Details in Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                student.rollNumber,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepPurple.shade800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                student.course,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${student.attendedClasses} / ${student.totalClasses} classes',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Attendance Percentage Badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: percentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: percentColor.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          student.formattedPercentage,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: percentColor,
                          ),
                        ),
                        Text(
                          student.statusLabel,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: student.statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Action Buttons Row (Present / Absent / Late)
              if (showActions && onStatusChanged != null) ...[
                const SizedBox(height: 10),
                const Divider(height: 1),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      label: 'Present',
                      icon: Icons.check_circle_outline,
                      status: AttendanceStatus.present,
                      activeColor: Colors.green,
                      isSelected:
                          student.todayStatus == AttendanceStatus.present,
                    ),
                    const SizedBox(width: 8),
                    _buildActionButton(
                      label: 'Absent',
                      icon: Icons.cancel_outlined,
                      status: AttendanceStatus.absent,
                      activeColor: Colors.red,
                      isSelected:
                          student.todayStatus == AttendanceStatus.absent,
                    ),
                    const SizedBox(width: 8),
                    _buildActionButton(
                      label: 'Late',
                      icon: Icons.access_time,
                      status: AttendanceStatus.late,
                      activeColor: Colors.orange,
                      isSelected: student.todayStatus == AttendanceStatus.late,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required AttendanceStatus status,
    required Color activeColor,
    required bool isSelected,
  }) {
    return Expanded(
      child: isSelected
          ? ElevatedButton.icon(
              onPressed: () => onStatusChanged?.call(status),
              icon: Icon(icon, size: 16),
              label: Text(label, style: const TextStyle(fontSize: 12)),
              style: ElevatedButton.styleFrom(
                backgroundColor: activeColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
          : OutlinedButton.icon(
              onPressed: () => onStatusChanged?.call(status),
              icon: Icon(icon, size: 16, color: activeColor),
              label: Text(
                label,
                style: TextStyle(fontSize: 12, color: activeColor),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: activeColor.withValues(alpha: 0.5)),
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
    );
  }
}
