import 'package:flutter/material.dart';

import '../widgets/app_bottom_nav.dart';
import 'akun_page.dart';
import 'cbt_page.dart';
import 'face_presence_page.dart';
import 'home_page.dart';
import 'lms_page.dart';

/// Kerangka utama: 5 tab bawah (Home, LMS, Presensi, CBT, Akun).
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  // Index 2 (Presensi) tidak punya tab; membuka halaman terpisah.
  final _pages = const [
    HomePage(),
    LmsPage(),
    SizedBox.shrink(),
    CbtPage(),
    AkunPage(),
  ];

  void _openPresensi() => Navigator.push(
      context, MaterialPageRoute(builder: (_) => const FacePresencePage()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        onPresensi: _openPresensi,
      ),
    );
  }
}