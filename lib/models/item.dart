import '../exceptions/validasi_exception.dart';

/// Kelas induk semua koleksi perpustakaan.
abstract class Item {
  String _nama;
  double _harga;
  int _stok;

  Item({required String nama, required double harga, required int stok})
      : _nama = '',
        _harga = 0,
        _stok = 0 {
    this.nama = nama;
    this.harga = harga;
    this.stok = stok;
  }

  String get nama => _nama;
  double get harga => _harga;
  int get stok => _stok;

  set nama(String nilai) {
    if (nilai.trim().isEmpty) {
      throw ValidasiException('Nama item tidak boleh kosong.');
    }
    _nama = nilai.trim();
  }

  set harga(double nilai) {
    if (nilai < 0) {
      throw ValidasiException('Harga tidak boleh negatif.');
    }
    _harga = nilai;
  }

  set stok(int nilai) {
    if (nilai < 0) {
      throw ValidasiException('Stok tidak boleh negatif.');
    }
    _stok = nilai;
  }

  void ubahStok(int jumlah) => stok = jumlah;

  String get jenis;

  /// Di-override oleh setiap kelas turunan (polymorphism).
  String tampilkanInfo();
}
