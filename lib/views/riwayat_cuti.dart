import 'package:employee_attendance_app/controllers/riwayat_cuti_controller.dart';
import 'package:employee_attendance_app/widgets/custom_loading_widget.dart';
import 'package:employee_attendance_app/widgets/grey_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatCuti extends StatefulWidget {
  const RiwayatCuti({Key? key}) : super(key: key);

  @override
  State<RiwayatCuti> createState() => _RiwayatCutiState();
}

class _RiwayatCutiState extends State<RiwayatCuti> {
  RiwayatCutiController riwayatCutiController =
      Get.put(RiwayatCutiController());

  List<DataRow> _riwayatCutiDataRows() => riwayatCutiController.listRiwayatCuti
      .map((element) => DataRow(
            cells: [
              DataCell(
                Text(
                  '${element.bulan!} ${element.tahun!}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              DataCell(
                Text(
                  element.jumlahCuti!.toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ))
      .toList();

  Widget _dataTableRiwayatCuti() => DataTable(
        columns: [
          DataColumn(
            label: Text(
              'Bulan',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          DataColumn(
            label: Text(
              'Jumlah Cuti',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ],
        rows: _riwayatCutiDataRows(),
      );

  @override
  void initState() {
    riwayatCutiController.getListRiwayatCutiFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF3ABBA2)),
        title: Text(
          'Riwayat Cuti',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () {
            if (riwayatCutiController.isLoading.isTrue) {
              return const Center(
                  child: CustomLoadingWidget(pesanLoading: 'Loading..'));
            } else {
              if (riwayatCutiController.listRiwayatCuti.isEmpty) {
                return const Center(
                  child: Text('Data Kosong'),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      GreyContainer(containerChild: _dataTableRiwayatCuti()),
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
