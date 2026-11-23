import 'package:flutter/material.dart';

import '../core/app_colors.dart';

RoundedRectangleBorder get _round => RoundedRectangleBorder(borderRadius: BorderRadius.circular(28));

/// Dialog ikon + judul + pesan + tombol Tutup (Wajah sudah terdaftar / Berhasil reset).
Future<void> showStatusDialog(
  BuildContext context, {
  required bool success,
  required String title,
  required String message,
  Color? buttonColor,
}) {
  return showDialog(
    context: context,
    builder: (ctx) => Dialog(
      shape: _round,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 54,
              backgroundColor: success ? Colors.transparent : const Color(0xFFE03030),
              child: success
                  ? const CircleAvatar(
                      radius: 36,
                      backgroundColor: AppColors.green,
                      child: Icon(Icons.check, color: Colors.white, size: 48),
                    )
                  : const Icon(Icons.close, color: Colors.white, size: 72),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: success ? 15 : 20, color: Colors.black87)),
            const SizedBox(height: 18),
            SizedBox(
              width: 260,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor ?? (success ? AppColors.red : AppColors.darkRed),
                  shape: const StadiumBorder(),
                ),
                onPressed: () => Navigator.pop(ctx),
                child: Text('Tutup',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: success ? Colors.black87 : Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Dialog konfirmasi keluar akun. Mengembalikan true bila memilih "Keluar".
Future<bool?> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => Dialog(
      shape: _round,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Icon(Icons.logout, size: 72),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text('Keluar dari akun?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12, right: 8),
              child: Text('Kamu perlu masuk kembali untuk menggunakan aplikasi. Yakin ingin keluar?',
                  style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 140,
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.black, width: 1.5),
                    ),
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Batal',
                        style: TextStyle(
                            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  width: 140,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red, shape: const StadiumBorder()),
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('Keluar',
                        style: TextStyle(
                            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

/// Dialog "Wajah Terdeteksi" + lokasi. true = Gunakan Foto, false = Ambil Ulang.
Future<bool?> showFaceDetectedDialog(
  BuildContext context, {
  required String name,
  required String location,
}) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => Dialog(
      shape: _round,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Wajah Terdeteksi', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.chipGrey, borderRadius: BorderRadius.circular(16)),
              child: Row(children: [
                const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.avatarGrey,
                    child: Icon(Icons.pets, color: Colors.grey)),
                const SizedBox(width: 14),
                Expanded(child: Text(name, style: const TextStyle(fontSize: 20))),
              ]),
            ),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
              Text('Lokasi', style: TextStyle(fontSize: 22)),
              Icon(Icons.refresh, size: 30),
            ]),
            const SizedBox(height: 8),
            Text(location, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Center(
                child: Text('Apakah Anda yakin melakukan presensi?',
                    style: TextStyle(fontSize: 17))),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: AppColors.textGreen),
                    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                  ),
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('Ambil Ulang',
                      style: TextStyle(
                          color: AppColors.textGreen, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCCF5C8),
                    elevation: 0,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                  ),
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text('Gunakan Foto',
                      style: TextStyle(
                          color: AppColors.textGreen, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

/// Dialog "Presensi anda berhasil" (centang hijau dalam lingkaran pink).
Future<void> showPresensiSuccessDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) => Dialog(
      shape: _round,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 58,
              backgroundColor: AppColors.pink,
              child: CircleAvatar(
                radius: 34,
                backgroundColor: AppColors.green,
                child: Icon(Icons.check, color: Colors.white, size: 48),
              ),
            ),
            const SizedBox(height: 28),
            const Text('Presensi anda berhasil',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
            const SizedBox(height: 44),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pink, elevation: 0, shape: const StadiumBorder()),
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Tutup',
                    style: TextStyle(
                        color: AppColors.olive, fontSize: 26, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}