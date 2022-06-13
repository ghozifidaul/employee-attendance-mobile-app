class KalenderPresensiModel {
  DateTime? tgl;
  String? statusAbsen;
  String? jamDatang;
  String? jamPulang;

  KalenderPresensiModel({
    this.tgl,
    this.statusAbsen,
    this.jamDatang,
    this.jamPulang,
  });

  factory KalenderPresensiModel.fromJson(Map<String, dynamic> json) {
    String tgl = json['tanggal'];
    return KalenderPresensiModel(
        tgl: DateTime.parse(tgl),
        statusAbsen: json['status_absen'],
        jamDatang: json['jamdatang'],
        jamPulang: json['jampulang']);
  }
}
