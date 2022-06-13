class GedungKuliahModel {
  int? id;
  String? kodeUnit, namaUnit;

  GedungKuliahModel({
    required this.id,
    required this.kodeUnit,
    required this.namaUnit,
  });

  factory GedungKuliahModel.fromJson(Map<String, dynamic> json) {
    return GedungKuliahModel(
      id: json['id'],
      kodeUnit: json['kodeunit'],
      namaUnit: json['namaunit'],
    );
  }
}
