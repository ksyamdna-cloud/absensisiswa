import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../widgets/common.dart';

class _Mapel {
  const _Mapel(this.code, this.name, this.guru, this.color);
  final String code;
  final String name;
  final String guru;
  final Color color;
}

class LmsPage extends StatelessWidget {
  const LmsPage({super.key});

  // Tambah mapel lain (total 14) di list ini / ambil dari API.
  static const _mapel = [
    _Mapel('BIND', 'BAHASA INDONESIA', 'NUR YULIANDRIANINGTYAS, S.Pd.', Color(0xFF1E9E0A)),
    _Mapel('MK-RPL', 'MAPEL KONSENTRASI REKAYASA PERANGKAT LUNAK', 'PARAS TAUFANI,S.Kom.',
        Color(0xFF0B4FA0)),
    _Mapel('B.JEPANG', 'B.JEPANG', 'IMAM MAULANA, S.Pd.', Color(0xFF8B3A0A)),
  ];

  Widget _stat(String n, String label, Color color) => Column(
        children: [
          Text(n, style: TextStyle(fontSize: 38, color: color)),
          Text(label, style: const TextStyle(fontSize: 18)),
        ],
      );

  Widget _pill(IconData icon, String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
            color: AppColors.chipGrey, borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 22),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 18)),
        ]),
      );

  Widget _mapelItem(_Mapel m) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              color: m.color,
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0x55FFFFFF),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(m.code,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(m.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  Text(m.guru, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Wrap(spacing: 14, runSpacing: 4, children: [
                    _pill(Icons.menu_book_outlined, '0 Materi'),
                    _pill(Icons.description_outlined, '0 Tugas'),
                  ]),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.pink,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 40, 20, 40),
              child: Row(
                children: [
                  Container(
                    width: 74,
                    height: 74,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF3A2A2A), width: 3)),
                    child: const Icon(Icons.school, size: 44, color: Colors.black),
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pembelajaran',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
                        Text('SMK N 1 Bukateja  XI RPL 1 Gasal 2026/2027',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            children: [
              const SizedBox(height: 28),
              Row(children: const [
                Icon(Icons.search, size: 38),
                SizedBox(width: 24),
                Text('Cari mata pelajaran..', style: TextStyle(fontSize: 20)),
              ]),
              const SizedBox(height: 20),
              ShadowCard(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _stat('14', 'Mata Pelajaran', const Color(0xFFC01010)),
                    _stat('0', 'Materi', const Color(0xFF1E88E5)),
                    _stat('0', 'Tugas Aktif', const Color(0xFF14C06A)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Mata Pelajaran',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              for (final m in _mapel) _mapelItem(m),
            ],
          ),
        ),
      ],
    );
  }
}