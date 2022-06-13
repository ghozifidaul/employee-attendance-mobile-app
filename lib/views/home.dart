import 'package:employee_attendance_app/controllers/preferensi_controller.dart';
// import 'package:employee_attendance_app/controllers/presensi_hari_ini_controller.dart';
import 'package:employee_attendance_app/views/absen_map.dart';
import 'package:employee_attendance_app/widgets/home_header.dart';
import 'package:employee_attendance_app/views/beranda.dart';
import 'package:employee_attendance_app/views/laporan.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String namaUser = 'Ghozi Fidaul Haq';
  String? linkFoto;
  int _selectedIndex = 1;
  ImageProvider<Object>? userImage;
  String? imageUrl;
  // bool isDosen = false;
  bool isImageError = false;
  PreferensiController prefC = Get.put(PreferensiController());

  List<Widget> listMenu = const [
    Beranda(),
    AbsenMap(),
    Laporan(),
  ];

  List<BottomNavigationBarItem> listBottomBarPeg = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.schedule),
      label: 'Presensi',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.assessment),
      label: 'Laporan',
    ),
  ];

  List<BottomNavigationBarItem> listBottomBarDosen = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.schedule),
      label: 'Presensi',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.assessment),
      label: 'Laporan',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.school),
      label: 'Mengajar',
    ),
  ];

  logout() {
    Navigator.pushReplacementNamed(context, '/auth');
  }

  onUserImageNotFound(Object object, StackTrace? stackTrace) {
    setState(() {
      userImage = const AssetImage('assets/images/broken_image.png');
    });
  }

  @override
  void initState() {
    // getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeHeader(
            nama: namaUser,
            logOut: () => logout(),
            userImage: const AssetImage('assets/images/foto_profil.jpg'),
            onError: onUserImageNotFound,
          ),
          Expanded(
            child: listMenu[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF3ABBA2),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (val) {
          if (mounted) {
            setState(() {
              _selectedIndex = val;
            });
          }
        },
        selectedLabelStyle: Theme.of(context).textTheme.bodyText1,
        unselectedLabelStyle: Theme.of(context).textTheme.bodyText1,
        items: listBottomBarPeg,
      ),
    );
  }
}
