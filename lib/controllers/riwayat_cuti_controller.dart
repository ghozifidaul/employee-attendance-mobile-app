import 'dart:async';

import 'package:employee_attendance_app/controllers/preferensi_controller.dart';
import 'package:employee_attendance_app/models/riwayat_cuti.dart';
import 'package:get/get.dart';

class RiwayatCutiController extends GetxController {
  var isLoading = false.obs;
  var listRiwayatCuti = <RiwayatCutiModel>[].obs;
  PreferensiController preferensiController = Get.put(PreferensiController());

  getListRiwayatCutiFromAPI() async {
    isLoading(true);
    Timer(const Duration(seconds: 1), () {
      List<RiwayatCutiModel> listJsonCuti = [
        RiwayatCutiModel(
          tahun: '2020',
          bulan: 'Desember',
          jumlahCuti: 2,
        ),
        RiwayatCutiModel(
          tahun: '2021',
          bulan: 'Januari',
          jumlahCuti: 1,
        ),
      ];
      listRiwayatCuti(listJsonCuti);
      isLoading(false);
    });
  }
}
