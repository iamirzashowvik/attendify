import 'package:flutter/material.dart';

class DistanceGauge extends StatelessWidget {
  const DistanceGauge({
    required this.distanceMeters,
    required this.isInRange,
    super.key,
  });

  final double? distanceMeters;
  final bool isInRange;

  @override
  Widget build(BuildContext context) {
    final value = distanceMeters?.round();
    return Column(
      children: [
        Container(
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isInRange ? Colors.green : Colors.redAccent,
              width: 6,
            ),
          ),
          child: Center(
            child: Text(
              value == null ? '--' : '${value}m',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Chip(
          label: Text(isInRange ? 'IN RANGE' : 'OUT OF RANGE'),
          backgroundColor:
              isInRange ? Colors.green.withValues(alpha: .15) : Colors.red.withValues(alpha: .15),
        ),
        const SizedBox(height: 6),
        const Text(
          'Move within 50 meters of the designated office location to enable check-in.',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
