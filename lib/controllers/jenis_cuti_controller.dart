import 'dart:async';

import 'package:employee_attendance_app/models/jenis_cuti.dart';
import 'package:get/get.dart';

class JenisCutiController extends GetxController {
  var isLoading = false.obs;
  var listJenisCuti = <JenisCutiModel>[].obs;

  // int convertIdJenisToInt(String idjenis) {
  //   switch (idjenis) {
  //     case 'B':
  //       return 0;
  //     case 'H':
  //       return 1;
  //     case 'I':
  //       return 2;
  //     case 'TT':
  //       return 3;
  //     case 'M':
  //       return 4;
  //     case 'ME':
  //       return 5;
  //     case 'PA':
  //       return 6;
  //     case 'S':
  //       return 7;
  //     case 'T':
  //       return 8;
  //     case 'U':
  //       return 9;
  //     default:
  //       return 10;
  //   }
  // }

  // String convertIntToIdJenis(int idjenis) {
  //   switch (idjenis) {
  //     case 0:
  //       return 'B';
  //     case 1:
  //       return 'H';
  //     case 2:
  //       return 'I';
  //     case 3:
  //       return 'TT';
  //     case 4:
  //       return 'M';
  //     case 5:
  //       return 'ME';
  //     case 6:
  //       return 'PA';
  //     case 7:
  //       return 'S';
  //     case 8:
  //       return 'T';
  //     case 9:
  //       return 'U';
  //     default:
  //       return 'Other';
  //   }
  // }

  getDataJenisCutiFromAPI() async {
    isLoading(true);

    Timer(const Duration(seconds: 1), () {
      List<JenisCutiModel> listJsonJenisCuti = [
        JenisCutiModel(
          idJenisCuti: '0',
          jenisCuti: 'Besar',
        ),
        JenisCutiModel(
          idJenisCuti: '1',
          jenisCuti: 'Kecil',
        ),
        JenisCutiModel(
          idJenisCuti: '2',
          jenisCuti: 'Tahunan',
        ),
      ];

      listJenisCuti(listJsonJenisCuti);
      isLoading(false);
    });
  }
}
