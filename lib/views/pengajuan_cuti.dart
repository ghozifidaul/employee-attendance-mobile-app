import 'dart:io';

import 'package:employee_attendance_app/controllers/jenis_cuti_controller.dart';
import 'package:employee_attendance_app/controllers/pengajuan_cuti_controller.dart';
import 'package:employee_attendance_app/widgets/custom_loading_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PengajuanCuti extends StatefulWidget {
  const PengajuanCuti({Key? key}) : super(key: key);

  @override
  State<PengajuanCuti> createState() => _PengajuanCutiState();
}

class _PengajuanCutiState extends State<PengajuanCuti> {
  DateTime selectedDate = DateTime.now();
  DateTime tglAkhirCuti = DateTime.now().add(const Duration(days: 1));

  final TextEditingController _tglCutiController = TextEditingController();
  final TextEditingController _tglAkhirCutiController = TextEditingController();
  final TextEditingController _fieldAlasanJutiController =
      TextEditingController();

  JenisCutiController jenisCutiController = Get.put(JenisCutiController());

  PengajuanCutiController pengajuanCutiController =
      Get.put(PengajuanCutiController());

  int idCuti = 0;
  File? fileDokumen;
  final _formPengajuanCutiKey = GlobalKey<FormState>();

  Future<void> _pilihTglMulaiCuti(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010, 1),
      lastDate: DateTime(2030, 12),
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _tglCutiController.text =
            DateFormat('yyyy-MM-dd', 'id_ID').format(picked);
      });
    }
  }

  Future<void> _pilihTglAkhirCuti(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tglAkhirCuti,
      firstDate: DateTime(2010, 1),
      lastDate: DateTime(2030, 12),
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        tglAkhirCuti = picked;
        _tglAkhirCutiController.text =
            DateFormat('yyyy-MM-dd', 'id_ID').format(picked);
      });
    }
  }

  Widget pilihTanggalMulaiCuti() => TextFormField(
        controller: _tglCutiController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Tanggal Cuti Harus Diisi';
          }
          return null;
        },
        onTap: () => _pilihTglMulaiCuti(context),
        decoration: InputDecoration(
          hintText: 'Pilih Tanggal Cuti',
          suffixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      );

  Widget pilihTanggalAkhirCuti() => TextFormField(
        controller: _tglAkhirCutiController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Tanggal Cuti Harus Diisi';
          }
          return null;
        },
        onTap: () => _pilihTglAkhirCuti(context),
        decoration: InputDecoration(
          hintText: 'Pilih Tanggal Selesai Cuti',
          suffixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      );

  Widget fieldAlasanCuti() => TextFormField(
        controller: _fieldAlasanJutiController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Alasan Cuti Harus Diisi';
          }
          return null;
        },
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Masukkan Alasan Cuti',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      );

  Widget btnUploadFoto() {
    if (fileDokumen != null) {
      return TextFormField(
        initialValue: fileDokumen!.path,
        enabled: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();
          setState(() {
            fileDokumen = File(result!.files.single.path!);
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: const Color(0xFFBDBDBD),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.photo_camera_outlined,
                color: Colors.white,
                size: 50,
              ),
              SizedBox(height: 5),
              Text(
                'Upload Dokumen Pendukung Cuti',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget dropdownAlasanCuti() {
    if (jenisCutiController.isLoading.isTrue) {
      // kalau loading return loading progress
      return const CustomLoadingWidget(pesanLoading: 'Loading...');
    } else {
      if (jenisCutiController.listJenisCuti.isEmpty) {
        // kalau listnya kosong return container kosong
        return Container();
      } else {
        return DropdownButtonFormField<int>(
          value: idCuti,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          items: jenisCutiController.listJenisCuti
              .map((element) => DropdownMenuItem(
                    value: int.parse(element.idJenisCuti!),
                    child: Text(element.jenisCuti!),
                  ))
              .toList(),
          onChanged: (val) {
            setState(() {
              idCuti = val!;
            });
          },
        );
      }
    }
  }

  Widget btnAjukanCuti() {
    if (pengajuanCutiController.isLoading.isTrue) {
      return const CustomLoadingWidget(
          pesanLoading: 'Mengirimkan Pengajuan Cuti');
    } else {
      return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF3ABBA2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        onPressed: () {
          if (_formPengajuanCutiKey.currentState!.validate()) {
            pengajuanCutiController.simpanCuti(
              idCuti.toString(),
              _fieldAlasanJutiController.text,
              _tglCutiController.text,
              _tglAkhirCutiController.text,
              fileDokumen!,
            );
            setState(() {
              _tglCutiController.clear();
              _tglAkhirCutiController.clear();
              _fieldAlasanJutiController.clear();
              fileDokumen = null;
            });
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Ajukan Cuti',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      );
    }
  }

  Widget btnRiwayatCuti() => TextButton(
        style: TextButton.styleFrom(
          primary: const Color(0xFF3ABBA2),
        ),
        onPressed: () => Navigator.pushNamed(context, '/riwayat_cuti'),
        child: const Text('Riwayat Cuti'),
      );

  Widget labelForm(String labelName) => Text(
        labelName,
        style: Theme.of(context).textTheme.bodyText1,
      );

  @override
  void initState() {
    jenisCutiController.getDataJenisCutiFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF3ABBA2)),
        title: Text(
          'Pengajuan Cuti',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formPengajuanCutiKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ------- Form Tanggal Mulai Cuti -------------
                labelForm('Tanggal Mulai Cuti'), // label form
                const SizedBox(height: 5), // padding
                pilihTanggalMulaiCuti(), // field
                // ---------------------------------------------

                // ------- Form Tanggal Akhir Cuti -------------
                const SizedBox(height: 10), // margin top
                labelForm('Tanggal Selesai Cuti'), // label
                const SizedBox(height: 5), // padding
                pilihTanggalAkhirCuti(), // field
                // ---------------------------------------------

                // ------- Form Pilih Jenis Cuti ---------------
                const SizedBox(height: 10),
                labelForm('Jenis Cuti'),
                const SizedBox(height: 5),
                Obx(() => dropdownAlasanCuti()),
                // ---------------------------------------------

                // ------- Form Tanggal Akhir Cuti -------------
                const SizedBox(height: 10), // margin top
                labelForm('Alasan Cuti'), // label
                const SizedBox(height: 5), // padding
                fieldAlasanCuti(), // field
                // ---------------------------------------------

                // ---- Button Upload Dokumen Cuti -------------
                const SizedBox(height: 10),
                btnUploadFoto(),
                // ---------------------------------------------

                // ------- Form Button Submit Cuti -------------
                const SizedBox(height: 10),
                Obx(() => btnAjukanCuti()),
                // ---------------------------------------------

                // ------- Button Cek Riwayat Cuti -------------
                btnRiwayatCuti(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
