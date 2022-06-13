import 'dart:convert';

import 'package:employee_attendance_app/models/presensi_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ListPresensi extends StatefulWidget {
  final String nomorInduk;
  const ListPresensi({Key? key, required this.nomorInduk}) : super(key: key);

  @override
  State<ListPresensi> createState() => _ListPresensiState();
}

class _ListPresensiState extends State<ListPresensi> {
  List<Presensi>? listPresensi;
  bool loadingData = false;

  getDataPresensi() async {
    if (mounted) {
      setState(() {
        loadingData = true;
      });
    }
    var uri = Uri.parse('http://parkir.unissula.ac.id/api/sim/viewabsen');
    var res = await http.post(uri, body: {
      'nik': widget.nomorInduk,
    });
    if (res.statusCode == 200) {
      var jsonData = json.decode(res.body);
      var listJsonPresensi = jsonData['data'] as List;
      List<Presensi> listPresensiData = listJsonPresensi
          .map((e) => Presensi(
                tgl: e['tglabsen'],
                ket: e['ket'],
                jamDatang: e['jamdatang'],
                jamPulang: e['jampulang'],
                warna: e['color'],
              ))
          .toList();
      if (mounted) {
        setState(() {
          listPresensi = listPresensiData;
          loadingData = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          loadingData = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getDataPresensi();
  }

  @override
  Widget build(BuildContext context) {
    if (loadingData) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Color(0xFF1AAC7A),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Loading Data Presensi',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }

    if (listPresensi == null) {
      if (listPresensi!.isEmpty) {
        return Center(
          child: Text(
            'Data Presensi Kosong',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        );
      }
    }

    return ListView.builder(
        itemCount: listPresensi!.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Card(
            color: const Color(0xFFE7E7E7),
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
                              'Jam Datang : ${listPresensi![i].jamDatang![0]}${listPresensi![i].jamDatang![1]}.${listPresensi![i].jamDatang![2]}${listPresensi![i].jamDatang![3]}',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                      const Text(' / '),
                      listPresensi![i].jamPulang == null
                          ? Text(
                              'Belum Absen',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            )
                          : Text(
                              'Jam Pulang : ${listPresensi![i].jamPulang![0]}${listPresensi![i].jamPulang![1]}.${listPresensi![i].jamPulang![2]}${listPresensi![i].jamPulang![3]}',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
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
        });
  }
}
