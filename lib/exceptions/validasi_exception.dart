/// Exception untuk kesalahan validasi input pengguna.
class ValidasiException implements Exception {
  final String pesan;

  ValidasiException(this.pesan);

  @override
  String toString() => 'ValidasiException: $pesan';
}
