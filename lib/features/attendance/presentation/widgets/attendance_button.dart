import 'package:flutter/material.dart';

class AttendanceButton extends StatelessWidget {
  const AttendanceButton({
    required this.enabled,
    required this.onPressed,
    super.key,
  });

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD0DBEB), style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(enabled ? Icons.lock_open : Icons.lock_outline, size: 40),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: enabled ? onPressed : null,
              child: const Text('Mark Attendance'),
            ),
          ),
          const SizedBox(height: 8),
          const Text('AVAILABLE 09:00 AM - 10:30 AM'),
        ],
      ),
    );
  }
}
