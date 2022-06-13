class PresensiHariIiniModel {
  String? masuk, keluar, ket;

  PresensiHariIiniModel({this.masuk, this.keluar, this.ket});

  factory PresensiHariIiniModel.fromJson(Map<String, dynamic> json) {
    return PresensiHariIiniModel(
      masuk: json['masuk'],
      keluar: json['pulang'],
      ket: json['ket'],
    );
  }
}
