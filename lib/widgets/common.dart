import 'package:flutter/material.dart';

import '../core/app_colors.dart';

/// Kartu putih dengan bayangan (dipakai di Home, Akun, LMS).
class ShadowCard extends StatelessWidget {
  const ShadowCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.height,
    this.radius = 16,
  });

  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double? height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(color: Color(0x33000000), blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }
}

/// Judul section + "Lihat Semua".
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.showAll = true, this.onTap});

  final String title;
  final bool showAll;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 18, 4, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
          if (showAll)
            GestureDetector(
              onTap: onTap,
              child: const Text('Lihat Semua',
                  style: TextStyle(fontSize: 18, color: AppColors.linkRed)),
            ),
        ],
      ),
    );
  }
}