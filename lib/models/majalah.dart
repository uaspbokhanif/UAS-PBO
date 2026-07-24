import 'item.dart';

class Majalah extends Item {
  final String edisi;
  final String penerbit;

  Majalah({
    required super.nama,
    required super.harga,
    required super.stok,
    required this.edisi,
    required this.penerbit,
  });

  @override
  String get jenis => 'Majalah';

  @override
  String tampilkanInfo() =>
      '[$jenis] $nama | Edisi: $edisi | Penerbit: $penerbit | '
      'Harga: Rp${harga.toStringAsFixed(0)} | Stok: $stok';
}
