import 'package:employee_attendance_app/controllers/presensi_hari_ini_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RowPresensiPeg extends StatefulWidget {
  const RowPresensiPeg({Key? key}) : super(key: key);

  @override
  State<RowPresensiPeg> createState() => _RowPresensiPegState();
}

class _RowPresensiPegState extends State<RowPresensiPeg> {
  PresensiHariIniController presensiHariIniController =
      Get.put(PresensiHariIniController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Column(
                children: [
                  Text(
                    'Masuk',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    presensiHariIniController.isLoading.value
                        ? 'Loading'
                        : presensiHariIniController.masuk.value,
                    style: Theme.of(context).textTheme.headline1,
                  )
                ],
              )),
          const SizedBox(width: 10),
          const Icon(
            Icons.alarm,
            size: 50,
            color: Color(0xFFBDBDBD),
          ),
          const SizedBox(width: 10),
          Obx(() => Column(
                children: [
                  Text(
                    'Pulang',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    presensiHariIniController.isLoading.value
                        ? 'Loading'
                        : presensiHariIniController.keluar.value,
                    style: Theme.of(context).textTheme.headline1,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
