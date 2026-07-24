import '../models/item.dart';

/// Mengelola koleksi dan menunjukkan penggunaan Collection serta HOF Dart.
class PerpustakaanManager {
  final List<Item> _koleksi = [];

  List<Item> get koleksi => List.unmodifiable(_koleksi);

  void tambah(Item item) => _koleksi.add(item);

  bool hapus(String nama) {
    final sebelum = _koleksi.length;
    _koleksi.removeWhere((item) => item.nama.toLowerCase() == nama.toLowerCase());
    return _koleksi.length < sebelum;
  }

  List<Item> cari(String kataKunci) => _koleksi
      .where((item) => item.nama.toLowerCase().contains(kataKunci.toLowerCase()))
      .toList();

  List<Item> urutkanBerdasarkanHarga() {
    final hasil = [..._koleksi];
    hasil.sort((a, b) => a.harga.compareTo(b.harga));
    return hasil;
  }

  int totalStok() => _koleksi.fold(0, (total, item) => total + item.stok);

  /// Simulasi proses simpan ke database/file secara asynchronous.
  Future<void> simpanData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}
