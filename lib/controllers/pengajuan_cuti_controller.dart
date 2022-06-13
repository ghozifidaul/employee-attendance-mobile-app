import 'dart:async';
import 'dart:io';

import 'package:employee_attendance_app/controllers/preferensi_controller.dart';
import 'package:get/get.dart';

class PengajuanCutiController extends GetxController {
  var isLoading = false.obs;
  var nomorInduk = ''.obs;
  PreferensiController preferensiController = Get.put(PreferensiController());

  simpanCuti(
    String jenisCuti,
    String alasanCuti,
    String tglMulai,
    String tglSelesai,
    File fileDokumen,
  ) async {
    isLoading(true);
    Timer(const Duration(seconds: 1), () {
      Get.snackbar(
        'Pengajuan Cuti Berhasil!',
        'Selamat! Pengajuan Cuti Anda Berhasil!',
      );
      isLoading(false);
    });
  }
}
