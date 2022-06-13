import 'dart:async';

import 'package:employee_attendance_app/controllers/preferensi_controller.dart';
import 'package:employee_attendance_app/models/presensi_bulan_ini.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;

class PresentasePresensiController extends GetxController {
  var isLoading = false.obs;
  var isFailed = false.obs;
  var listPieChartSectionData = <PieChartSectionData>[].obs;
  var presenstasePresensiBulanIni = PresensiBulanIni().obs;
  PreferensiController preferensiController = Get.put(PreferensiController());

  String titleChart(double jumlah, double total) {
    return '${((jumlah / total) * 100).ceil().toInt()}%';
  }

  PieChartSectionData pieChartSectionDataPresensi(
    double val,
    double total,
    Color colorIndicator,
  ) =>
      PieChartSectionData(
        color: colorIndicator,
        value: val,
        title: titleChart(val, total),
        titleStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        radius: 50,
      );

  getDataPresentaseFromAPI() async {
    isLoading(true);

    Timer(const Duration(seconds: 1), () {
      PresensiBulanIni presensiBulanIni = PresensiBulanIni(
        cuti: 2,
        hadir: 10,
        izinTidakMasuk: 0,
        lembur: 1,
        libur: 0,
        pulangAwal: 0,
        sakit: 0,
        terlambat: 0,
        tidakAbsenDatang: 0,
        tidakAbsenPulang: 0,
        alpha: 0,
      );

      presenstasePresensiBulanIni(presensiBulanIni);

      double totalJumlahPresensi = presensiBulanIni.alpha!.toDouble() +
          presensiBulanIni.cuti!.toDouble() +
          presensiBulanIni.hadir!.toDouble() +
          presensiBulanIni.izinTidakMasuk!.toDouble() +
          presensiBulanIni.lembur!.toDouble() +
          presensiBulanIni.libur!.toDouble() +
          presensiBulanIni.pulangAwal!.toDouble() +
          presensiBulanIni.sakit!.toDouble() +
          presensiBulanIni.terlambat!.toDouble() +
          presensiBulanIni.tidakAbsenDatang!.toDouble() +
          presensiBulanIni.tidakAbsenPulang!.toDouble();

      // if (jsonData['status'] == 200) {
      List<PieChartSectionData> listData = [
        pieChartSectionDataPresensi(
          presensiBulanIni.alpha!.toDouble(),
          totalJumlahPresensi,
          const Color(0xffBB3A3A),
        ),
        pieChartSectionDataPresensi(
          presensiBulanIni.cuti!.toDouble(),
          totalJumlahPresensi,
          const Color(0xff3A75BB),
        ),
        pieChartSectionDataPresensi(
          presensiBulanIni.hadir!.toDouble(),
          totalJumlahPresensi,
          Colors.green,
        ),
        pieChartSectionDataPresensi(
          presensiBulanIni.izinTidakMasuk!.toDouble(),
          totalJumlahPresensi,
          Colors.redAccent,
        ),
        pieChartSectionDataPresensi(
          presensiBulanIni.lembur!.toDouble(),
          totalJumlahPresensi,
          Colors.blueAccent,
        ),
        pieChartSectionDataPresensi(
          presensiBulanIni.libur!.toDouble(),
          totalJumlahPresensi,
          Colors.blueGrey,
        ),
        pieChartSectionDataPresensi(
          presensiBulanIni.pulangAwal!.toDouble(),
          totalJumlahPresensi,
          Colors.greenAccent,
        ),
        pieChartSectionDataPresensi(
          presensiBulanIni.sakit!.toDouble(),
          totalJumlahPresensi,
          Colors.lightGreen,
        ),
        pieChartSectionDataPresensi(
          presensiBulanIni.terlambat!.toDouble(),
          totalJumlahPresensi,
          const Color(0xffCFD23A),
        ),
        pieChartSectionDataPresensi(
          presensiBulanIni.tidakAbsenDatang!.toDouble(),
          totalJumlahPresensi,
          Colors.pink,
        ),
        pieChartSectionDataPresensi(
          presensiBulanIni.tidakAbsenPulang!.toDouble(),
          totalJumlahPresensi,
          Colors.purple,
        ),
      ];
      listPieChartSectionData(listData);
      isLoading(false);
    });
  }
}
