class DaftarHadirKelas {
  String? nim, nama, waktuAbsen, statusHadir;

  DaftarHadirKelas({
    required this.nama,
    required this.nim,
    required this.waktuAbsen,
    required this.statusHadir,
  });

  factory DaftarHadirKelas.fromJson(Map<String, dynamic> jsonData) {
    return DaftarHadirKelas(
      nama: jsonData['nama'],
      nim: jsonData['nim'],
      waktuAbsen: jsonData['waktuabsen'],
      statusHadir: jsonData['statushadir'],
    );
  }
}
