// import 'dart:async';
// import 'dart:convert';

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:package_info_plus/package_info_plus.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool kunciPassword = true;
  final TextEditingController _nomorIndukController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formLoginKey = GlobalKey<FormState>();
  bool loadingLogin = false;
  String appVersion = "";

  showErrorDialog(String msg, String jdl) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.RIGHSLIDE,
      title: jdl,
      desc: msg,
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
    ).show();
  }

  cekLogin() {
    setState(() {
      loadingLogin = true;
    });

    Timer(const Duration(seconds: 1),
        () => Navigator.pushReplacementNamed(context, '/home'));
  }

  gantiKunciPassword() {
    if (mounted) {
      setState(() {
        kunciPassword = !kunciPassword;
      });
    }
  }

  // getState() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   if (mounted) {
  //     setState(() {
  //       appVersion = packageInfo.version;
  //     });
  //   }
  // }

  @override
  void initState() {
    // getState();
    super.initState();
  }

  @override
  void dispose() {
    _nomorIndukController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/login_image.png',
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Location-Based Employee Attendance App',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: const Color(0xFF1AAC7A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                padding: const EdgeInsets.only(
                  // top: 20.0,
                  right: 20,
                  left: 20,
                ),
                decoration: const BoxDecoration(
                    color: Color(0xFF1AAC7A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    )),
                child: Form(
                  key: _formLoginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nomorIndukController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: GoogleFonts.poppins(),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.person_outlined),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF1AAC7A),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: kunciPassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: GoogleFonts.poppins(),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: kunciPassword
                              ? GestureDetector(
                                  onTap: gantiKunciPassword,
                                  child:
                                      const Icon(Icons.visibility_off_outlined),
                                )
                              : GestureDetector(
                                  onTap: gantiKunciPassword,
                                  child: const Icon(Icons.visibility_outlined),
                                ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      loadingLogin
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFF00160A),
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  textStyle: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () {
                                cekLogin();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Masuk'),
                              ),
                            ),
                      const SizedBox(height: 5),
                      Center(
                        child: Text(
                          appVersion,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
