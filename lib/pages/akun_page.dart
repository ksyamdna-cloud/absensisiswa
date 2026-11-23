import 'package:flutter/material.dart';

import '../auth/login_page.dart';
import '../core/app_colors.dart';
import '../widgets/app_dialogs.dart';
import '../widgets/common.dart';
import 'data_personal_page.dart';

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  Widget _stat(String n, String label) => Column(
        children: [
          Text(n, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          Text(label, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        ],
      );

  Widget _menu(IconData icon, String label, VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Icon(icon, size: 34),
              const SizedBox(width: 18),
              Expanded(
                child: Text(label,
                    style: const TextStyle(fontSize: 22, color: Colors.black54)),
              ),
              const Icon(Icons.chevron_right, size: 34),
            ],
          ),
        ),
      );

  Future<void> _logout(BuildContext context) async {
    final yes = await showLogoutDialog(context);
    if (yes == true && context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // ---------- Header + statistik ----------
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: 330,
              color: AppColors.pink,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: const [
                    SizedBox(height: 24),
                    CircleAvatar(
                      radius: 62,
                      backgroundColor: AppColors.avatarGrey,
                      child: Icon(Icons.person, size: 96, color: Colors.white),
                    ),
                    SizedBox(height: 28),
                    Text('KEISYA MEIDINA Q',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                    SizedBox(height: 6),
                    Text('XI RPL 1 | SMK Negeri 1 Bukateja',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: -50,
              child: ShadowCard(
                padding: const EdgeInsets.symmetric(vertical: 22),
                radius: 22,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _stat('0', 'Hadir'),
                    _stat('0', 'Sakit'),
                    _stat('0', 'Izin'),
                    _stat('0', 'Alpha'),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 74),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // ---------- Poin pelanggaran ----------
              ShadowCard(
                radius: 22,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: const [
                          Text('Poin pelanggaran',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                          SizedBox(height: 10),
                          Text('Tahun Ajaran 2026/2027',
                              style: TextStyle(fontSize: 20, color: AppColors.subtitle)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, size: 38),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              // ---------- Profil ----------
              ShadowCard(
                radius: 22,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    const Text('Profil',
                        style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    _menu(
                      Icons.person_outline,
                      'Data Diri',
                      () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const DataPersonalPage())),
                    ),
                    _menu(
                      Icons.center_focus_weak,
                      'Registrasi Wajah',
                      () => showStatusDialog(
                        context,
                        success: false,
                        title: 'Wajah sudah terdaftar',
                        message:
                            'Wajah sudah terdaftar. Silahkan reset wajah terlebih dahulu untuk registrasi ulang.',
                        buttonColor: AppColors.darkRed,
                      ),
                    ),
                    _menu(
                      Icons.refresh,
                      'Reset Wajah',
                      () => showStatusDialog(
                        context,
                        success: true,
                        title: 'Berhasil mereset wajah',
                        message:
                            'registrasi ulang wajah di menu profilWajah berhasil direset! Silahkan registrasi wajah anda di menu profil',
                        buttonColor: const Color(0xFFD00000),
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              // ---------- Logout ----------
              ShadowCard(
                radius: 22,
                padding: EdgeInsets.zero,
                child: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: () => _logout(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 34),
                        SizedBox(width: 18),
                        Text('Logout',
                            style: TextStyle(fontSize: 22, color: Colors.black54)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}