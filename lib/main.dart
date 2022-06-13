// import 'package:employee_attendance_app/views/auth.dart';
import 'package:employee_attendance_app/views/home.dart';
import 'package:employee_attendance_app/views/login_screen.dart';
import 'package:employee_attendance_app/views/pengajuan_cuti.dart';
import 'package:employee_attendance_app/views/presensi_terakhir.dart';
import 'package:employee_attendance_app/views/riwayat_cuti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('id_ID', null).then((_) => runApp(
        GetMaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            textTheme: TextTheme(
              headline1: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: const Color(0xFF3ABBA2),
              ),
              headline2: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
              headline3: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
              ),
              headline4: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black,
              ),
              bodyText1: GoogleFonts.poppins(
                fontSize: 12,
              ),
            ),
          ),
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const Home(),
            // '/auth': (context) => const AuthLogin(),
            '/pengajuan_cuti': (context) => const PengajuanCuti(),
            '/presensi_terakhir': (context) => const PresensiTerakhir(),
            '/riwayat_cuti': (context) => const RiwayatCuti(),
          },
        ),
      ));
}
