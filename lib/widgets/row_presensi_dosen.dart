import 'package:employee_attendance_app/controllers/presensi_hari_ini_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RowPresensiDosen extends StatefulWidget {
  const RowPresensiDosen({Key? key}) : super(key: key);

  @override
  State<RowPresensiDosen> createState() => _RowPresensiDosenState();
}

class _RowPresensiDosenState extends State<RowPresensiDosen> {
  PresensiHariIniController presensiHariIniController =
      Get.put(PresensiHariIniController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Waktu Presensi Hari Ini : ',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              presensiHariIniController.isLoading.value
                  ? 'Loading'
                  : presensiHariIniController.masuk.value,
              style: Theme.of(context).textTheme.headline1,
            )
          ],
        ));
  }
}
