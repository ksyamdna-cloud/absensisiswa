import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../widgets/common.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _timeItem(IconData icon, String value, String label) => Row(
        children: [
          Icon(icon, color: AppColors.amber, size: 40),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontSize: 22)),
              Text(label, style: const TextStyle(color: AppColors.subtitle)),
            ],
          ),
        ],
      );

  Widget _presensiRow(String title, String sub, Widget badge) => Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.avatarGrey,
            child: Icon(Icons.person_outline, size: 36, color: Colors.black87),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16)),
                Text(sub, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          badge,
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pink,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ---------- Header ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.avatarGrey,
                    child: Icon(Icons.person_outline, size: 70, color: Colors.black),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Hi\nKEISYA MEIDINA Q\n9231 | XI RPL 1 | SMK N 1 Bukateja',
                      style: TextStyle(fontSize: 19, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // ---------- Tanggal / masuk / pulang ----------
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _timeItem(Icons.calendar_month, '06/11', 'Tanggal'),
                  _timeItem(Icons.schedule, '06:00', 'Masuk'),
                  _timeItem(Icons.schedule, '14:00', 'Pulang'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // ---------- Konten putih ----------
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(44)),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(28, 16, 28, 24),
                  children: [
                    const SectionHeader('Presensi'),
                    ShadowCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _presensiRow(
                            'Presensi Masuk',
                            '05.0  |  06/11/1026',
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.softGreen,
                                  borderRadius: BorderRadius.circular(24)),
                              child: const Text('Tepat Waktu',
                                  style: TextStyle(color: AppColors.textGreen, fontSize: 16)),
                            ),
                          ),
                          const SizedBox(height: 22),
                          _presensiRow(
                            'Presensi Pulang',
                            '--:  |  --:',
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.linkRed),
                                  borderRadius: BorderRadius.circular(24)),
                              child: const Text('Belum Presensi',
                                  style: TextStyle(color: AppColors.linkRed, fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SectionHeader('Jurnal PKL'),
                    ShadowCard(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.calendar_month, color: AppColors.amber, size: 52),
                          SizedBox(height: 8),
                          Text('Periode PKL belum dimulai', style: TextStyle(fontSize: 19)),
                          SizedBox(height: 6),
                          Text(
                            'Jurnal PKL kamu belum bisa diisi. Fitur ini\naktif otomatis saat periode PKL dimulai.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.subtitle, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SectionHeader('Jadwal Pelajaran', showAll: false),
                    ShadowCard(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('KONSENTRASI REKAYASA PERANGKAT LUNAK',
                              style: TextStyle(fontSize: 15)),
                          SizedBox(height: 14),
                          Padding(
                            padding: EdgeInsets.only(left: 36),
                            child: Text('08.00-', style: TextStyle(fontSize: 15)),
                          ),
                          SizedBox(height: 4),
                          Row(children: [
                            Icon(Icons.person_outline, size: 26),
                            SizedBox(width: 10),
                            Text('PARAS TAUFANI, S.KOM', style: TextStyle(fontSize: 15)),
                          ]),
                        ],
                      ),
                    ),
                    const SectionHeader('Perizinan'),
                    Container(
                      height: 210,
                      decoration: BoxDecoration(
                        color: AppColors.panelGrey,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Container(
                          width: 340,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: const [
                              BoxShadow(color: Color(0x33000000), blurRadius: 6, offset: Offset(0, 3))
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.menu_book_outlined, size: 36),
                              SizedBox(height: 4),
                              Text('Ajukan izin', style: TextStyle(fontSize: 20)),
                              Text('Ajukan izin jika kamu berhalangan hadir',
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}