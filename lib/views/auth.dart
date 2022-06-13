import 'dart:async';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:root/root.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin({Key? key}) : super(key: key);

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  // bool? isRoot;

  // cekRoot() async {
  //   if (Platform.isAndroid) {
  //     bool? result = await Root.isRooted();

  //     setState(() {
  //       isRoot = result;
  //     });

  //     if (isRoot != null && isRoot == false) {
  //       cekLogin();
  //     }
  //   } else {
  //     cekLogin();
  //   }
  // }

  cekLogin() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // if (prefs.containsKey('nomor_induk')) {
    //   Timer(const Duration(seconds: 1), () {
    //     Navigator.pushReplacementNamed(context, '/home');
    //   });
    // } else {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
    // }
  }

  Widget backgroundAuth() {
    return Stack(
      children: [
        Image.asset(
          'assets/images/img_splash.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Cek Status Login...',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget backgroundIfPhoneisRooted() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Device Anda terdeteksi telah di-root, harap gunakan device lain untuk menggunakan aplikasi.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // cekLogin();
    // cekRoot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backgroundAuth(),
    );
  }
}
