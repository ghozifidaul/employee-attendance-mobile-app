import 'dart:convert';

import 'package:employee_attendance_app/models/gedung_kuliah_model.dart';
import 'package:employee_attendance_app/models/ruang_kuliah_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GedungKuliahController extends GetxController {
  final isLoadingGedung = false.obs;
  final isLoadingRuangKuliah = false.obs;
  final listGedung = <GedungKuliahModel>[].obs;
  final listRuang = <RuangKuliahModel>[].obs;

  Future<List<GedungKuliahModel>?> getDataGedungKuliah() async {
    isLoadingGedung(true);

    var url = Uri.parse('http://parkir.unissula.ac.id/api/sim/allfakultas');
    var res = await http.get(url);

    if (res.statusCode == 200) {
      var jsonData = json.decode(res.body);
      var listJsonGedung = jsonData as List;
      List<GedungKuliahModel> listJsonGedungKuliah =
          listJsonGedung.map((e) => GedungKuliahModel.fromJson(e)).toList();
      listGedung(listJsonGedungKuliah);
      isLoadingGedung(false);
      return listJsonGedungKuliah;
    } else {
      isLoadingGedung(false);
      return null;
    }
  }

  Future<List<RuangKuliahModel>?> getDataRuang(String kodeUnit) async {
    isLoadingRuangKuliah(true);

    var url = Uri.parse('http://parkir.unissula.ac.id/api/sim/ruang/$kodeUnit');
    var res = await http.get(url);

    if (res.statusCode == 200) {
      var jsonData = json.decode(res.body);
      var listJsonRuang = jsonData as List;
      List<RuangKuliahModel> list =
          listJsonRuang.map((e) => RuangKuliahModel.fromJson(e)).toList();
      listRuang(list);
      isLoadingRuangKuliah(false);
      return list;
    } else {
      isLoadingRuangKuliah(false);
      return null;
    }
  }
}
