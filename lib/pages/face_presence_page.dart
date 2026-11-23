import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../widgets/app_dialogs.dart';

/// Halaman Presensi Wajah.
///
/// Preview kamera & lokasi masih placeholder. Untuk versi asli:
///  - kamera: paket `camera` (CameraPreview + takePicture)
///  - lokasi: paket `geolocator` + `geocoding`
class FacePresencePage extends StatefulWidget {
  const FacePresencePage({super.key});

  @override
  State<FacePresencePage> createState() => _FacePresencePageState();
}

class _FacePresencePageState extends State<FacePresencePage> {
  final String _name = 'KEISYA MEIDINA Q';
  final String _location =
      'No. 77 Jalan Purbalingga - Banjarnegara, Majasari, Kecamatan Bukateja, Jawa Tengah, 53382, Indonesia';

  Future<void> _capture() async {
    // TODO: ambil foto dari kamera, kirim ke API pengenalan wajah,
    // lalu isi _name & _location dari hasilnya.
    final usePhoto = await showFaceDetectedDialog(
      context,
      name: _name,
      location: _location,
    );
    if (usePhoto != true || !mounted) return;

    await showPresensiSuccessDialog(context);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.cameraBar,
        foregroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 64,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 34),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Presensi Wajah', style: TextStyle(fontSize: 22)),
      ),
      body: Stack(
        children: [
          // Placeholder preview kamera (gradasi senja)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF4C9A6), Color(0xFFE59A6E), Color(0xFF8A6A58), Color(0xFF5A4636)],
                ),
              ),
              child: const Center(
                child: Icon(Icons.face, size: 140, color: Colors.white38),
              ),
            ),
          ),
          Positioned(
            left: 28,
            right: 28,
            bottom: 160,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
              decoration: BoxDecoration(
                color: AppColors.hintBox,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Text(
                'Pastikan wajah terlihat jelas dan\ntidak menggunakan masker/topeng',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 32,
            child: Center(
              child: GestureDetector(
                onTap: _capture,
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.pink,
                  child: Icon(Icons.photo_camera_outlined, size: 60, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}