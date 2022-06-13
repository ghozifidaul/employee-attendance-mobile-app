// import 'dart:convert';

import 'package:employee_attendance_app/controllers/preferensi_controller.dart';
import 'package:employee_attendance_app/models/kalender_presensi.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class KalenderPresensiController extends GetxController {
  var isLoading = false.obs;
  var listKalenderPresensi = <KalenderPresensiModel>[].obs;
  var focusedDay = DateTime.now().obs;
  PreferensiController preferensiController = Get.find<PreferensiController>();

  setFocusedDay(DateTime day) {
    focusedDay(day);
  }

  KalenderPresensiModel getKalenderPresensiFromDay(DateTime day) {
    return listKalenderPresensi.firstWhere(
      (element) => isSameDay(element.tgl, day),
      orElse: () => KalenderPresensiModel(
        tgl: day,
        jamDatang: '-',
        jamPulang: '-',
        statusAbsen: '-',
      ),
    );
  }

  getDataPresensiFromAPI() async {
    List<KalenderPresensiModel> listKalenderPresensiModel = List.generate(
      13,
      (index) => KalenderPresensiModel(
        tgl: DateTime.now().subtract(Duration(days: index)),
        statusAbsen: 'Hadir',
        jamDatang: '09.00',
        jamPulang: '17.00',
      ),
    );

    listKalenderPresensi(listKalenderPresensiModel);
  }
}
