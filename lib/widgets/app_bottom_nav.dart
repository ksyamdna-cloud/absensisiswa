import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onPresensi,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onPresensi;

  Widget _item(IconData icon, String label, int index) {
    final active = currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Opacity(
          opacity: active ? 1 : 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.mauve, size: 34),
              Text(label, style: const TextStyle(color: AppColors.mauve, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 8)],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _item(Icons.home_rounded, 'Home', 0),
            _item(Icons.school_rounded, 'LMS', 1),
            Expanded(
              child: InkWell(
                onTap: onPresensi,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.mauve,
                      child: Icon(Icons.face_retouching_natural, color: Colors.white, size: 34),
                    ),
                    SizedBox(height: 2),
                    Text('Presensi', style: TextStyle(color: AppColors.mauve, fontSize: 12)),
                  ],
                ),
              ),
            ),
            _item(Icons.assignment_rounded, 'CBT', 3),
            _item(Icons.person_rounded, 'Akun', 4),
          ],
        ),
      ),
    );
  }
}