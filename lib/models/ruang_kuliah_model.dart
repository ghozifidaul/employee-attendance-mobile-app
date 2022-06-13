class RuangKuliahModel {
  String? idRuang, namaRuang, lokasi, dayaTampung, isAktif;

  RuangKuliahModel({
    required this.idRuang,
    required this.namaRuang,
    required this.lokasi,
    required this.dayaTampung,
    required this.isAktif,
  });

  factory RuangKuliahModel.fromJson(Map<String, dynamic> jsonData) {
    return RuangKuliahModel(
      idRuang: jsonData['idruang'],
      namaRuang: jsonData['namaruang'],
      lokasi: jsonData['lokasi'],
      dayaTampung: jsonData['dayatampung'],
      isAktif: jsonData['isaktif'],
    );
  }
}
