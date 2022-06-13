class JenisCutiModel {
  String? idJenisCuti;
  String? jenisCuti;

  JenisCutiModel({this.idJenisCuti, this.jenisCuti});

  factory JenisCutiModel.fromJson(Map<String, dynamic> json) {
    return JenisCutiModel(
      idJenisCuti: json['idjeniscuti'],
      jenisCuti: json['jeniscuti'],
    );
  }
}
