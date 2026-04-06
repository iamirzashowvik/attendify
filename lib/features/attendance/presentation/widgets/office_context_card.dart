import 'package:attendify/features/attendance/domain/entities/office_location.dart';
import 'package:flutter/material.dart';

class OfficeContextCard extends StatelessWidget {
  const OfficeContextCard({
    required this.officeLocation,
    required this.onSetOfficePressed,
    super.key,
  });

  final OfficeLocation? officeLocation;
  final VoidCallback onSetOfficePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'STEP 1: OFFICE CONTEXT',
              style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF68758D)),
            ),
            const SizedBox(height: 12),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFE8EEF8),
              ),
              child: Center(
                child: Text(
                  officeLocation == null
                      ? 'No office location set'
                      : 'Lat: ${officeLocation!.lat.toStringAsFixed(4)}, Lon: ${officeLocation!.lon.toStringAsFixed(4)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'To mark your attendance, ensure your current office location is correctly identified.',
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onSetOfficePressed,
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Set Office Location'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
