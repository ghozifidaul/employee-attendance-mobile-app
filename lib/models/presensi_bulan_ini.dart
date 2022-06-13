class PresensiBulanIni {
  int? alpha;
  int? cuti;
  int? hadir;
  int? izinTidakMasuk;
  int? lembur;
  int? libur;
  int? pulangAwal;
  int? sakit;
  int? terlambat;
  int? tidakAbsenDatang;
  int? tidakAbsenPulang;

  PresensiBulanIni({
    this.alpha,
    this.cuti,
    this.hadir,
    this.izinTidakMasuk,
    this.lembur,
    this.libur,
    this.pulangAwal,
    this.sakit,
    this.terlambat,
    this.tidakAbsenDatang,
    this.tidakAbsenPulang,
  });

  factory PresensiBulanIni.formJson(Map<String, dynamic> parsedJson) {
    return PresensiBulanIni(
      alpha: parsedJson['Alpha'],
      cuti: parsedJson['Cuti'],
      hadir: parsedJson['Hadir'],
      izinTidakMasuk: parsedJson['Izin Tidak Masuk'],
      lembur: parsedJson['Lembur'],
      libur: parsedJson['Libur'],
      pulangAwal: parsedJson['Pulang Awal'],
      sakit: parsedJson['Sakit'],
      terlambat: parsedJson['Terlambat'],
      tidakAbsenDatang: parsedJson['Tidak Absen Datang'],
      tidakAbsenPulang: parsedJson['Tidak Absen Pulang'],
    );
  }
}
