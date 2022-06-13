class KelasModel {
  int? idKelas, jadwal;
  String? idMK, namaKelas, namaMK, nip, parentUnit;

  KelasModel({
    required this.idKelas,
    required this.jadwal,
    required this.idMK,
    required this.namaKelas,
    required this.namaMK,
    required this.nip,
    required this.parentUnit,
  });

  factory KelasModel.fromJson(Map<String, dynamic> jsonData) {
    return KelasModel(
      idKelas: jsonData['idkelas'],
      jadwal: jsonData['jadwal'],
      idMK: jsonData['idmmk'],
      namaKelas: jsonData['namakelas'],
      namaMK: jsonData['namamk'],
      nip: jsonData['nip'],
      parentUnit: jsonData['parentunit'],
    );
  }
}
