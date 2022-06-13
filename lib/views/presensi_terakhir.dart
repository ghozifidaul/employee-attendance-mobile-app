import 'dart:async';

import 'package:employee_attendance_app/models/presensi_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PresensiTerakhir extends StatefulWidget {
  const PresensiTerakhir({Key? key}) : super(key: key);

  @override
  State<PresensiTerakhir> createState() => _PresensiTerakhirState();
}

class _PresensiTerakhirState extends State<PresensiTerakhir> {
  List<Presensi>? listPresensi;
  bool loadingData = false;
  String? nomorInduk;
  bool isDosen = false;

  getDataPresensi() async {
    if (mounted) {
      setState(() {
        loadingData = true;
      });
    }

    List<Presensi> listPresensiData = List.generate(
        5,
        (index) => Presensi(
              tgl: '13-06-2022',
              ket: 'Hadir',
              jamDatang: '09.00',
              jamPulang: '17.00',
            ));

    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          listPresensi = listPresensiData;
          loadingData = false;
        });
      }
    });
  }

  @override
  void initState() {
    getDataPresensi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF3ABBA2)),
        title: Text(
          'Presensi Terakhir',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: loadingData
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  Text(
                    'Loading Data',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              )
            : listPresensi == null
                ? Center(
                    child: Text(
                      'Data Presensi Kosong',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) {
                            return Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listPresensi![i].tgl!,
                                      style: GoogleFonts.poppins(),
                                    ),
                                    Row(
                                      children: [
                                        listPresensi![i].jamDatang == null
                                            ? Text(
                                                'Belum Absen',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                ),
                                              )
                                            : Text(
                                                'Jam Datang : ${listPresensi![i].jamDatang}',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                ),
                                              ),
                                        isDosen
                                            ? const Text('')
                                            : const Text(' / '),
                                        isDosen
                                            ? Container()
                                            : listPresensi![i].jamPulang == null
                                                ? Text(
                                                    'Belum Absen',
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                    ),
                                                  )
                                                : Text(
                                                    'Jam Pulang : ${listPresensi![i].jamPulang}',
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                      ],
                                    ),
                                    Text(
                                      'Ket : ${listPresensi![i].ket!}',
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: listPresensi!.length,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
