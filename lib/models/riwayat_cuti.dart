class RiwayatCutiModel {
  String? tahun;
  String? bulan;
  int? jumlahCuti;

  RiwayatCutiModel({this.tahun, this.bulan, this.jumlahCuti});

  factory RiwayatCutiModel.fromJson(Map<String, dynamic> json) =>
      RiwayatCutiModel(
        tahun: json['tahun'],
        bulan: json['bulan'],
        jumlahCuti: json['jumlah_cuti'],
      );
}
