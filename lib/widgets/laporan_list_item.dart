import 'package:employee_attendance_app/models/laporan_kehadiran.dart';
import 'package:employee_attendance_app/widgets/grey_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaporanListItem extends StatelessWidget {
  const LaporanListItem({
    Key? key,
    required this.laporanPresensi,
  }) : super(key: key);

  final LaporanKehadiranModel laporanPresensi;

  Widget headerItem() => Text(
        '${laporanPresensi.bulan!} ${laporanPresensi.tahun!}',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );

  Widget containerItem() => GreyContainer(
        containerChild: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          childAspectRatio: 3,
          padding: const EdgeInsets.all(10.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            rowDataItem("Hadir", laporanPresensi.jumlahHadir!),
            rowDataItem("Sakit", laporanPresensi.jumlahSakit!),
            rowDataItem("Izin", laporanPresensi.jumlahIzin!),
            rowDataItem("Alpa", laporanPresensi.jumlahAlpa!),
            rowDataItem("Dinas", laporanPresensi.jumlahDinas!),
            rowDataItem("Terlambat", laporanPresensi.jumlahTerlambat!),
            rowDataItem("Pulang Duluan", laporanPresensi.jumlahPulangDuluan!),
          ],
        ),
      );

  Widget rowDataItem(String dataName, String dataNumber) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dataName,
            style: GoogleFonts.poppins(
              color: const Color(0xFF999999),
              fontSize: 14,
            ),
          ),
          Text(
            dataNumber,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        headerItem(),
        containerItem(),
      ],
    );
  }
}
