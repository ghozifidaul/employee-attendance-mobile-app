// import 'package:employee_attendance_app/controllers/jadwal_mengajar_controller.dart';
// import 'package:employee_attendance_app/controllers/preferensi_controller.dart';
// import 'package:employee_attendance_app/models/jadwal_mengajar_model.dart';
// import 'package:employee_attendance_app/views/buat_jadwal.dart';
// import 'package:employee_attendance_app/views/daftar_hadir.dart';
// import 'package:employee_attendance_app/views/edit_kelas.dart';
// import 'package:employee_attendance_app/widgets/custom_jadwal_card.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// class JadwalMengajar extends StatefulWidget {
//   const JadwalMengajar({Key? key}) : super(key: key);

//   @override
//   State<JadwalMengajar> createState() => _JadwalMengajarState();
// }

// class _JadwalMengajarState extends State<JadwalMengajar> {
//   // String? nik;
//   JadwalMengajarController jadwalMengajarC =
//       Get.put(JadwalMengajarController());
//   PreferensiController prefC = Get.put(PreferensiController());

//   // getNIK() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   setState(() {
//   //     nik = prefs.getString('nomor_induk');
//   //   });
//   // }

//   @override
//   void initState() {
//     // jadwalMengajarC.getDataJadwalMengajar();
//     // getNIK();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String formattedDateTime =
//         DateFormat('kk:mm').format(DateTime.now()).toString();
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(height: 10),
//           Text(
//             'Jadwal Mengajar Hari Ini',
//             style: GoogleFonts.poppins(
//               fontWeight: FontWeight.bold,
//               // fontSize: 18,
//             ),
//           ),
//           const SizedBox(height: 10),
//           TextButton.icon(
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.blue,
//               primary: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const BuatJadwal()),
//               );
//             },
//             icon: const Icon(Icons.add),
//             label: Text(
//               'Buat Jadwal Baru',
//               style: GoogleFonts.poppins(),
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               bool isLoading = jadwalMengajarC.isLoading.value;
//               List<JadwalMengajarModel> listJadwal =
//                   jadwalMengajarC.listJadwalMengajar;
//               return isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : listJadwal.isEmpty
//                       ? const Center(
//                           child: Text('Tidak ada jadwal mengajar hari ini'),
//                         )
//                       : MediaQuery.removePadding(
//                           removeTop: true,
//                           context: context,
//                           child: ListView.builder(
//                               itemCount: listJadwal.length,
//                               itemBuilder: (context, idx) {
//                                 return Card(
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 8.0),
//                                     child: CustomJadwalKuliahCard(
//                                       waktuSekarang: formattedDateTime,
//                                       hapusJadwalFunc: () {
//                                         AwesomeDialog(
//                                           context: context,
//                                           dialogType: DialogType.QUESTION,
//                                           headerAnimationLoop: false,
//                                           animType: AnimType.BOTTOMSLIDE,
//                                           title:
//                                               'Apakah Anda yakin akan menghapus jadwal ini?',
//                                           // desc: 'Apakah Anda yakin akan menghapus jadwal ini?',
//                                           buttonsTextStyle: const TextStyle(
//                                               color: Colors.black),
//                                           showCloseIcon: true,
//                                           btnCancelOnPress: () {},
//                                           btnOkOnPress: () {
//                                             jadwalMengajarC.hapusJadwal(
//                                                 listJadwal[idx]
//                                                     .idJadwal
//                                                     .toString());
//                                           },
//                                         ).show();
//                                       },
//                                       daftarHadirFunc: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => DaftarHadir(
//                                               idjadwal: listJadwal[idx]
//                                                   .idJadwal
//                                                   .toString(),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       bukaKelasFunc: () {
//                                         AwesomeDialog(
//                                           context: context,
//                                           dialogType: DialogType.QUESTION,
//                                           buttonsBorderRadius:
//                                               const BorderRadius.all(
//                                             Radius.circular(2),
//                                           ),
//                                           dismissOnTouchOutside: true,
//                                           dismissOnBackKeyPress: false,
//                                           headerAnimationLoop: false,
//                                           animType: AnimType.BOTTOMSLIDE,
//                                           title:
//                                               'Apakah Anda yakin buka kelas ini?',
//                                           showCloseIcon: true,
//                                           btnCancelOnPress: () {},
//                                           btnOkOnPress: () {
//                                             // jadwalMengajarC.bukaKelas(
//                                             //     listJadwal[idx]
//                                             //         .idJadwal
//                                             //         .toString(),
//                                             //     nik!);
//                                             Future.delayed(
//                                                 const Duration(
//                                                     milliseconds: 500), () {
//                                               // jadwalMengajarC
//                                               //     .getDataJadwalMengajar();
//                                             });
//                                           },
//                                         ).show();
//                                       },
//                                       editKelasFunc: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => EditKelas(
//                                                 jadwalMengajar:
//                                                     listJadwal[idx]),
//                                           ),
//                                         );
//                                         // print(listJadwal[idx].idUnit);
//                                       },
//                                       batalBukaKelasFunc: () {
//                                         AwesomeDialog(
//                                           context: context,
//                                           dialogType: DialogType.INFO_REVERSED,
//                                           buttonsBorderRadius:
//                                               const BorderRadius.all(
//                                             Radius.circular(2),
//                                           ),
//                                           dismissOnTouchOutside: true,
//                                           dismissOnBackKeyPress: false,
//                                           headerAnimationLoop: false,
//                                           animType: AnimType.BOTTOMSLIDE,
//                                           desc:
//                                               'Apakah Anda yakin membatalkan buka kelas ini?',
//                                           showCloseIcon: true,
//                                           btnCancelOnPress: () {},
//                                           btnOkOnPress: () {
//                                             jadwalMengajarC.batalBukaKelas(
//                                               listJadwal[idx]
//                                                   .idJadwal
//                                                   .toString(),
//                                             );
//                                             Future.delayed(
//                                                 const Duration(
//                                                     milliseconds: 500), () {
//                                               // jadwalMengajarC
//                                               //     .getDataJadwalMengajar();
//                                             });
//                                           },
//                                         ).show();
//                                       },
//                                       jadwalMengajarModel: listJadwal[idx],
//                                     ),
//                                   ),
//                                 );
//                               }),
//                         );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
