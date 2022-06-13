import 'package:employee_attendance_app/controllers/laporan_kehadiran_controller.dart';
import 'package:employee_attendance_app/widgets/custom_loading_widget.dart';
import 'package:employee_attendance_app/widgets/laporan_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

class Laporan extends StatefulWidget {
  const Laporan({Key? key}) : super(key: key);

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  LaporanKehadiranController laporanKehadiranController =
      Get.put(LaporanKehadiranController());

  Widget presensiHeadline() => Text(
        'Laporan Kehadiran',
        style: Theme.of(context).textTheme.headline1,
      );

  Widget listviewPresensi(BuildContext context) {
    if (laporanKehadiranController.isLoading.isTrue) {
      return const CustomLoadingWidget(pesanLoading: 'Loading...');
    } else {
      if (laporanKehadiranController.listLaporanKehadiran.isEmpty) {
        return const Center(
          child: Text('Data Kosong'),
        );
      } else {
        return MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
            itemCount: laporanKehadiranController.listLaporanKehadiran.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, idx) => LaporanListItem(
              laporanPresensi:
                  laporanKehadiranController.listLaporanKehadiran[idx],
            ),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    laporanKehadiranController.getListLaporanKehadiran();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            presensiHeadline(),
            const Divider(
              color: Color(0xFF1AAC7A),
            ),
            Obx(() => listviewPresensi(context)),
          ],
        ),
      ),
    );
  }
}
