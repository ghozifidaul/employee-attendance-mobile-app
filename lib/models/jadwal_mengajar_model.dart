class JadwalMengajarModel {
  int? idKelas, idJadwal;
  String? namaKelas,
      namaMK,
      waktuMulai,
      waktuSelesai,
      tglJadwal,
      idRuang,
      jenisJadwal,
      namaRuang,
      statusPerkuliahan,
      idUnit,
      parentUnit;

  JadwalMengajarModel({
    required this.idKelas,
    required this.idJadwal,
    required this.namaKelas,
    required this.namaMK,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.tglJadwal,
    required this.idRuang,
    required this.jenisJadwal,
    required this.namaRuang,
    required this.statusPerkuliahan,
    required this.idUnit,
    required this.parentUnit,
  });

  factory JadwalMengajarModel.fromJson(Map<String, dynamic> json) {
    return JadwalMengajarModel(
      idKelas: json['idkelas'],
      idJadwal: json['idjadwal'],
      namaKelas: json['namakelas'],
      namaMK: json['namamk'],
      waktuMulai: json['waktumulai'],
      waktuSelesai: json['waktuselesai'],
      tglJadwal: json['tgljadwal'],
      idRuang: json['idruang'],
      jenisJadwal: json['jenisjadwal'],
      namaRuang: json['namaruang'],
      statusPerkuliahan: json['statusperkuliahan'],
      idUnit: json['idunit'],
      parentUnit: json['parentunit'],
    );
  }
}
