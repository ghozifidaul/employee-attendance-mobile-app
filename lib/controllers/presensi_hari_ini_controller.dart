import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PresensiHariIniController extends GetxController {
  var masuk = "-".obs;
  var keluar = "-".obs;
  var isLoading = false.obs;

  setLoading(bool loadStatus) {
    isLoading(loadStatus);
  }

  clearState() {
    masuk("-");
    keluar("-");
  }

  loadDataHariIni() async {
    setLoading(true);

    Timer(const Duration(seconds: 1), () {
      DateTime rightNow = DateTime.now();
      if (masuk.value == "-") {
        String hours = DateFormat('HH:mm', 'id_ID').format(rightNow);
        masuk(hours);
      } else {
        String hours = DateFormat('HH:mm', 'id_ID').format(rightNow);
        keluar(hours);
      }
      setLoading(false);
    });
  }
}
