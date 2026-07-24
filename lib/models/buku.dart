import 'item.dart';

class Buku extends Item {
  final String penulis;
  final String isbn;

  Buku({
    required super.nama,
    required super.harga,
    required super.stok,
    required this.penulis,
    required this.isbn,
  });

  @override
  String get jenis => 'Buku';

  @override
  String tampilkanInfo() =>
      '[$jenis] $nama | Penulis: $penulis | ISBN: $isbn | '
      'Harga: Rp${harga.toStringAsFixed(0)} | Stok: $stok';
}
