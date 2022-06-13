import 'dart:async';

import 'package:employee_attendance_app/controllers/preferensi_controller.dart';
import 'package:employee_attendance_app/models/laporan_kehadiran.dart';
import 'package:get/get.dart';

class LaporanKehadiranController extends GetxController {
  var isLoading = false.obs;
  var listLaporanKehadiran = <LaporanKehadiranModel>[].obs;
  PreferensiController preferensiController = Get.put(PreferensiController());

  getListLaporanKehadiran() async {
    isLoading(true);
    Timer(const Duration(seconds: 1), () {
      List<LaporanKehadiranModel> listLapHadirFromAPI = List.generate(
        1,
        (index) => LaporanKehadiranModel(
          bulan: 'January',
          tahun: '2022',
          jumlahAlpa: '0',
          jumlahCuti: '0',
          jumlahDinas: '0',
          jumlahHadir: '30',
          jumlahIzin: '0',
          jumlahPulangDuluan: '0',
          jumlahSakit: '0',
          jumlahTerlambat: '0',
        ),
      );
      listLaporanKehadiran(listLapHadirFromAPI);
      isLoading(false);
    });
  }
}
