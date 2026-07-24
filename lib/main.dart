import 'dart:io';

import 'exceptions/validasi_exception.dart';
import 'models/buku.dart';
import 'models/item.dart';
import 'models/majalah.dart';
import 'services/perpustakaan_manager.dart';

final manager = PerpustakaanManager();

void main() async {
  _isiDataAwal();
  stdout.writeln('=== SISTEM PERPUSTAKAAN | PROJECT PBO KHANIF ===');

  while (true) {
    _tampilkanMenu();
    final pilihan = _input('Pilih menu: ');
    try {
      switch (pilihan) {
        case '1':
          _tambahBuku();
          break;
        case '2':
          _tambahMajalah();
          break;
        case '3':
          _tampilkanKoleksi(manager.koleksi);
          break;
        case '4':
          _cariItem();
          break;
        case '5':
          _ubahStok();
          break;
        case '6':
          _hapusItem();
          break;
        case '7':
          _tampilkanKoleksi(manager.urutkanBerdasarkanHarga());
          break;
        case '8':
          await manager.simpanData();
          stdout.writeln('Data berhasil disimpan (simulasi async).');
          break;
        case '0':
          stdout.writeln('Terima kasih.');
          return;
        default:
          stdout.writeln('Menu tidak tersedia.');
      }
    } on ValidasiException catch (e) {
      stdout.writeln('Input ditolak: ${e.pesan}');
    } on FormatException {
      stdout.writeln('Format angka tidak valid.');
    }
  }
}

void _tampilkanMenu() {
  stdout.writeln('''

1. Tambah buku
2. Tambah majalah
3. Tampilkan semua koleksi
4. Cari koleksi
5. Ubah stok
6. Hapus koleksi
7. Urutkan berdasarkan harga
8. Simpan data (async)
0. Keluar''');
}

void _tambahBuku() {
  manager.tambah(Buku(
    nama: _input('Judul buku: '),
    penulis: _input('Penulis: '),
    isbn: _input('ISBN: '),
    harga: _inputDouble('Harga: '),
    stok: _inputInt('Stok: '),
  ));
  stdout.writeln('Buku berhasil ditambahkan.');
}

void _tambahMajalah() {
  manager.tambah(Majalah(
    nama: _input('Nama majalah: '),
    edisi: _input('Edisi: '),
    penerbit: _input('Penerbit: '),
    harga: _inputDouble('Harga: '),
    stok: _inputInt('Stok: '),
  ));
  stdout.writeln('Majalah berhasil ditambahkan.');
}

void _tampilkanKoleksi(List<Item> koleksi) {
  if (koleksi.isEmpty) {
    stdout.writeln('Koleksi masih kosong.');
    return;
  }
  for (final item in koleksi) {
    stdout.writeln(item.tampilkanInfo());
  }
  stdout.writeln('Total stok: ${koleksi.fold(0, (total, item) => total + item.stok)}');
}

void _cariItem() {
  final hasil = manager.cari(_input('Kata kunci: '));
  _tampilkanKoleksi(hasil);
}

void _ubahStok() {
  final nama = _input('Nama item: ').toLowerCase();
  Item? item;
  for (final koleksiItem in manager.koleksi) {
    if (koleksiItem.nama.toLowerCase() == nama) {
      item = koleksiItem;
      break;
    }
  }
  if (item == null) {
    stdout.writeln('Item tidak ditemukan.');
    return;
  }
  item.ubahStok(_inputInt('Stok baru: '));
  stdout.writeln('Stok ${item.nama} diperbarui.');
}

void _hapusItem() {
  final berhasil = manager.hapus(_input('Nama item yang dihapus: '));
  stdout.writeln(berhasil ? 'Item berhasil dihapus.' : 'Item tidak ditemukan.');
}

String _input(String label) {
  stdout.write(label);
  return stdin.readLineSync()?.trim() ?? '';
}

int _inputInt(String label) => int.parse(_input(label));
double _inputDouble(String label) => double.parse(_input(label));

void _isiDataAwal() {
  manager.tambah(Buku(nama: 'Dart Dasar', penulis: 'Khanif', isbn: '978-001', harga: 75000, stok: 4));
  manager.tambah(Majalah(nama: 'Teknologi', edisi: 'Juli 2026', penerbit: 'Informatika', harga: 30000, stok: 6));
}
