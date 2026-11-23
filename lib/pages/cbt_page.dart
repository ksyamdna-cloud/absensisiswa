import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class CbtPage extends StatelessWidget {
  const CbtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          color: AppColors.pink,
          alignment: Alignment.center,
          child: const SafeArea(
            bottom: false,
            child: Text('CBT', style: TextStyle(fontSize: 52, fontWeight: FontWeight.w800)),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.desktop_mac_rounded, size: 200, color: AppColors.mauve),
                SizedBox(height: 40),
                Text('CBT Segera Hadir!', style: TextStyle(fontSize: 30)),
                SizedBox(height: 10),
                Text('Fitur CBT sedang kami siapkan,Tunggu sebentar,ya!',
                    style: TextStyle(fontSize: 17)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}