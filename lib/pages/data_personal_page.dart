import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class DataPersonalPage extends StatelessWidget {
  const DataPersonalPage({super.key});

  // Isi nilai dari API / model siswa. Kosong = tampil "-".
  static const _personal = <String, String>{
    'Nama': '',
    'Tempat Lahir': '',
    'Tanggal Lahir': '',
    'Jenis Kelamin': '',
    'Telepon': '',
    'NIS': '',
    'NISN': '',
    'NIK': '',
    'Agama': '',
    'Alamat': '',
    'Anak Ke-': '',
    'Asal Sekolah': '',
    'Nomor Surat Tanda Lulus': '',
    'Tanggal Surat Tanda Lulus': '',
  };

  static const _parents = <String, String>{
    'Nama Ayah': '',
    'Nama Ibu': '',
    'Pekerjaan Ayah': '',
    'Pekerjaan Ibu': '',
    'Telepon Orang Tua': '',
  };

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Text(label,
                  style: const TextStyle(fontSize: 22, color: AppColors.subtitle)),
            ),
            Expanded(
              flex: 5,
              child: Text(value.isEmpty ? '-' : value,
                  style: const TextStyle(fontSize: 20, color: Colors.black87)),
            ),
          ],
        ),
      );

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Text(t, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w800)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.pink,
        elevation: 0,
        toolbarHeight: 90,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 34),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
        children: [
          _title('Data Personal'),
          for (final e in _personal.entries) _row(e.key, e.value),
          const Divider(color: Colors.black, thickness: 1.5, height: 48),
          _title('Data Orang Tua'),
          for (final e in _parents.entries) _row(e.key, e.value),
        ],
      ),
    );
  }
}