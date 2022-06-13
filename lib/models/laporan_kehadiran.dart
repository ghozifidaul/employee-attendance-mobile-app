class LaporanKehadiranModel {
  String? bulan;
  String? tahun;
  String? jumlahHadir;
  String? jumlahSakit;
  String? jumlahIzin;
  String? jumlahAlpa;
  String? jumlahCuti;
  String? jumlahDinas;
  String? jumlahTerlambat;
  String? jumlahPulangDuluan;

  LaporanKehadiranModel({
    this.bulan,
    this.tahun,
    this.jumlahHadir,
    this.jumlahSakit,
    this.jumlahIzin,
    this.jumlahAlpa,
    this.jumlahCuti,
    this.jumlahDinas,
    this.jumlahTerlambat,
    this.jumlahPulangDuluan,
  });

  factory LaporanKehadiranModel.fromJson(Map<String, dynamic> json) =>
      LaporanKehadiranModel(
        bulan: json['bulan'],
        tahun: json['tahun'],
        jumlahHadir: json['jumlah_hadir'],
        jumlahSakit: json['jumlah_sakit'],
        jumlahIzin: json['jumlah_izin'],
        jumlahAlpa: json['jumlah_alpa'],
        jumlahCuti: json['jumlah_cuti'],
        jumlahDinas: json['jumlah_dinas'],
        jumlahTerlambat: json['jumlah_terlambat'],
        jumlahPulangDuluan: json['jumlah_pulangduluan'],
      );
}
