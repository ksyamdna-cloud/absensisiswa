import 'package:flutter/material.dart';

// ===================== app_colors.dart =====================
/// Semua warna diambil dari desain Figma Sister Skansika.
class AppColors {
  AppColors._();

  static const pink = Color(0xFFF8D0D0); // background header/login
  static const mauve = Color(0xFF9A6B86); // ikon & label bottom nav
  static const red = Color(0xFFE00000); // tombol Login / Keluar / Tutup (reset)
  static const darkRed = Color(0xFF960A0A); // tombol Tutup (gagal)
  static const linkRed = Color(0xFFA31515); // "Lihat Semua"
  static const green = Color(0xFF009F00); // ikon centang
  static const softGreen = Color(0xFFB8F0B8); // badge Tepat Waktu
  static const textGreen = Color(0xFF2E7D32);
  static const olive = Color(0xFF9A8A00); // teks tombol dialog pink
  static const magenta = Color(0xFFC0189C); // border Ambil Ulang (pink)
  static const fieldGrey = Color(0xFFCCCCCC); // field login
  static const avatarGrey = Color(0xFFE0E0E0);
  static const panelGrey = Color(0xFFC4C2C4); // panel Perizinan
  static const chipGrey = Color(0xFFE8E8EE);
  static const cameraBar = Color(0xFF4A4642); // app bar presensi wajah
  static const hintBox = Color(0xCC1E1E1E); // kotak petunjuk kamera
  static const amber = Color(0xFFF5C518); // ikon kalender/jam
  static const subtitle = Color(0xFF757575);
  static const pageBg = Color(0xFFE6E6EA);
}

// ===================== common.dart =====================
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

/// Gambar dari assets; bila belum ada, tampil ikon pengganti.
class AssetOrIcon extends StatelessWidget {
  const AssetOrIcon({
    super.key,
    required this.asset,
    required this.fallback,
    this.size = 120,
    this.color = AppColors.mauve,
  });

  final String asset;
  final IconData fallback;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(fallback, size: size * 0.7, color: color),
    );
  }
}

// ===================== app_bottom_nav.dart =====================
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

// ===================== app_dialogs.dart =====================
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

// ===================== login_page.dart =====================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _hide = true;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint, {Widget? suffix}) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 22, color: Colors.black87),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.fieldGrey,
        contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
      );

  void _login() {
    // TODO: panggil API login dengan _userCtrl.text & _passCtrl.text
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const MainShell()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pink,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.vertical,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 60),
                const Text('SISTER SKANSIKA',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900)),
                const SizedBox(height: 30),
                const Icon(Icons.school_rounded, size: 160, color: AppColors.mauve),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.fromLTRB(36, 48, 36, 48),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(56),
                  ),
                  child: Column(
                    children: [
                      TextField(
                          controller: _userCtrl,
                          decoration: _decoration('Masukan NIS  atau Username')),
                      const SizedBox(height: 36),
                      TextField(
                        controller: _passCtrl,
                        obscureText: _hide,
                        decoration: _decoration(
                          'Masukan Password',
                          suffix: IconButton(
                            icon: Icon(_hide ? Icons.visibility : Icons.visibility_off,
                                color: Colors.black, size: 34),
                            onPressed: () => setState(() => _hide = !_hide),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.red,
                              shape: const StadiumBorder()),
                          onPressed: _login,
                          child: const Text('LOGIN',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===================== home_page.dart =====================
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

// ===================== lms_page.dart =====================
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

// ===================== cbt_page.dart =====================
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

// ===================== data_personal_page.dart =====================
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

// ===================== face_presence_page.dart =====================
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
  String _name = 'KEISYA MEIDINA Q';
  String _location =
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

// ===================== akun_page.dart =====================
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

// ===================== main_shell.dart =====================
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

// ===================== main.dart =====================
void main() => runApp(const SisterApp());

class SisterApp extends StatelessWidget {
  const SisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sister Skansika',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.pink),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginPage(),
    );
  }
}
