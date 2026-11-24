import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

/// Hasil permintaan izin yang disederhanakan.
enum PermResult { granted, denied, permanentlyDenied }

/// Pembungkus permission_handler untuk izin yang dipakai aplikasi.
class AppPermissions {
  AppPermissions._();

  static Future<PermResult> camera() async =>
      _map(await Permission.camera.request());

  static Future<PermResult> location() async =>
      _map(await Permission.locationWhenInUse.request());

  static PermResult _map(PermissionStatus s) {
    if (s.isGranted || s.isLimited) return PermResult.granted;
    if (s.isPermanentlyDenied) return PermResult.permanentlyDenied;
    return PermResult.denied;
  }
}

/// Hasil deteksi lokasi.
class LocationResult {
  const LocationResult.success(this.latitude, this.longitude, {this.accuracy})
      : error = null,
        permanentlyDenied = false;

  const LocationResult.failure(this.error, {this.permanentlyDenied = false})
      : latitude = null,
        longitude = null,
        accuracy = null;

  final double? latitude;
  final double? longitude;
  final double? accuracy; // meter
  final String? error;
  final bool permanentlyDenied;

  bool get ok => error == null;

  /// Teks untuk ditampilkan di dialog.
  String get label => ok
      ? 'Lat ${latitude!.toStringAsFixed(6)}, Lng ${longitude!.toStringAsFixed(6)}'
      : error!;
}

/// Deteksi lokasi: izin (permission_handler) + GPS (location).
class LocationService {
  final loc.Location _location = loc.Location();

  Future<LocationResult> current() async {
    // 1. Izin lokasi
    final perm = await AppPermissions.location();
    if (perm == PermResult.permanentlyDenied) {
      return const LocationResult.failure(
        'Izin lokasi ditolak permanen. Aktifkan lewat Pengaturan aplikasi.',
        permanentlyDenied: true,
      );
    }
    if (perm != PermResult.granted) {
      return const LocationResult.failure('Izin lokasi ditolak.');
    }

    // 2. Layanan GPS
    var enabled = await _location.serviceEnabled();
    if (!enabled) {
      enabled = await _location.requestService();
      if (!enabled) {
        return const LocationResult.failure('GPS belum aktif. Nyalakan lokasi perangkat.');
      }
    }

    // 3. Ambil posisi
    try {
      final data = await _location.getLocation();
      final double? lat = data.latitude;
      final double? lng = data.longitude;
      if (lat == null || lng == null) {
        return const LocationResult.failure('Lokasi tidak ditemukan. Coba lagi.');
      }
      if (data.isMock == true) {
        return const LocationResult.failure('Lokasi palsu (mock) terdeteksi.');
      }
      return LocationResult.success(lat, lng, accuracy: data.accuracy);
    } catch (_) {
      return const LocationResult.failure('Gagal mengambil lokasi. Coba lagi.');
    }
  }
}