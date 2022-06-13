// import 'dart:convert';
import 'dart:io' show exit;

import 'package:employee_attendance_app/controllers/preferensi_controller.dart';
import 'package:employee_attendance_app/controllers/presensi_hari_ini_controller.dart';
import 'package:employee_attendance_app/widgets/loading_lokasi_terkini.dart';
import 'package:employee_attendance_app/widgets/custom_loading_widget.dart';
import 'package:employee_attendance_app/widgets/presensi_button.dart';
import 'package:employee_attendance_app/models/gedung.dart';
import 'package:employee_attendance_app/models/presensi_model.dart';
import 'package:employee_attendance_app/widgets/row_presensi_peg.dart';
import 'package:employee_attendance_app/widgets/timer_presensi.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AbsenMap extends StatefulWidget {
  const AbsenMap({Key? key}) : super(key: key);

  @override
  State<AbsenMap> createState() => _AbsenMapState();
}

class _AbsenMapState extends State<AbsenMap> with WidgetsBindingObserver {
  GoogleMapController? mapController;
  String? nomorInduk, namaUser;
  List<Presensi>? listPresensi;
  List<String>? listStringLatLngGedung;
  List<String>? listNamaGedung;
  List<LatLng>? listLatLngGedungSegment;
  List<Gedung>? listGedungDanKoordinat;
  bool loadingData = false;
  bool loadingAbsen = false;
  bool locationServiceEnabled = true;
  bool locationPermissionAllowed = true;
  bool reloadMaps = false;
  bool loadingLocation = false;
  bool isDosen = false;

  final PresensiHariIniController presensiHariIniController =
      Get.put(PresensiHariIniController());
  PreferensiController prefC = Get.put(PreferensiController());

  final Map<String, Marker> _markers = {};
  final Map<String, Polygon> _polygons = {};

  LatLng? _center;

  // getPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? isDosenFromPref = await prefC.isDosen();
  //   if (mounted) {
  //     setState(() {
  //       nomorInduk = prefs.getString('nomor_induk');
  //       namaUser = prefs.getString('nama_user');
  //       listStringLatLngGedung = prefs.getStringList('list_gedung');
  //       listNamaGedung = prefs.getStringList('list_nama_gedung');
  //       isDosen = isDosenFromPref;
  //     });
  //   }
  //   prosesStringLatLang();
  //   presensiHariIniController.loadDataHariIni(nomorInduk!);
  // }

  prosesStringLatLang() {
    if (mounted) {
      setState(() {
        reloadMaps = true;
      });
    }

    int idx = 0;
    List<Gedung> listGedungData = [];
    for (var koordinatGedung in listStringLatLngGedung!) {
      List<String> stringlatlngsplitted = koordinatGedung.split("),(");
      List<LatLng> listLatLngGedung = [];

      for (var latlng in stringlatlngsplitted) {
        String removeSquareBracket = latlng.replaceAll("(", "");
        String removeSquareBracket2 = removeSquareBracket.replaceAll(")", "");
        String removeSpace = removeSquareBracket2.replaceAll(" ", "");
        List<String> strLatLngSplitted = removeSpace.split(",");

        listLatLngGedung.add(LatLng(
          double.parse(strLatLngSplitted[0]),
          double.parse(strLatLngSplitted[1]),
        ));
      }

      listGedungData.add(Gedung(
        namaGedung: listNamaGedung![idx],
        listLatLng: listLatLngGedung,
      ));
      idx++;
    }

    if (mounted) {
      setState(() {
        listGedungDanKoordinat = listGedungData;
        reloadMaps = false;
      });
    }
  }

  googleMapsInitilization() {
    if (mounted) {
      setState(() {
        _markers.clear();
        _markers['Unissula'] = Marker(
          markerId: const MarkerId('unissula'),
          position: _center!,
          infoWindow: const InfoWindow(
            title: 'Lokasi Anda',
            snippet: 'Lokasi anda terkini',
          ),
        );

        _polygons.clear();
        // for (var gedung in listGedungDanKoordinat!) {
        //   _polygons[gedung.namaGedung!] = Polygon(
        //     polygonId: PolygonId(gedung.namaGedung!),
        //     points: gedung.listLatLng!,
        //     fillColor: const Color(0xFF1AAC7A).withOpacity(0.3),
        //     strokeColor: const Color(0xFF1AAC7A),
        //     strokeWidth: 1,
        //   );
        // }

        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(
            target: _center!,
            zoom: 20,
          )),
        );
      });
    }
  }

  lokasiTerkiniOnResumed() async {
    if (locationServiceEnabled && locationPermissionAllowed) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      if (position.isMocked) {
        showDilarangMenggunakanMockLocaton();
      } else {
        setState(() {
          _center = LatLng(position.latitude, position.longitude);
          reloadMaps = false;
          loadingLocation = false;
        });
      }
    }
  }

  mapsOnResumed() async {
    bool serviceEnabled;

    if (mounted) {
      setState(() {
        loadingLocation = true;
        reloadMaps = true;
      });
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          reloadMaps = false;
          locationServiceEnabled = false;
          loadingLocation = false;
        });
      }
    } else {
      LocationPermission permission;
      if (mounted) {
        setState(() {
          locationServiceEnabled = true;
        });
      }
      permission = await Geolocator.checkPermission();

      switch (permission) {
        case LocationPermission.denied:
          await Geolocator.requestPermission().then((value) {
            if (value == LocationPermission.denied ||
                value == LocationPermission.deniedForever) {
              if (mounted) {
                setState(() {
                  reloadMaps = false;
                  locationPermissionAllowed = false;
                });
              }
            } else {
              if (mounted) {
                setState(() {
                  locationPermissionAllowed = true;
                });
              }
              lokasiTerkiniOnResumed();
            }
          });

          break;
        case LocationPermission.deniedForever:
          await Geolocator.requestPermission().then((value) {
            if (value == LocationPermission.denied ||
                value == LocationPermission.deniedForever) {
              if (mounted) {
                setState(() {
                  reloadMaps = false;
                  locationPermissionAllowed = false;
                  loadingLocation = false;
                });
              }
            } else {
              if (mounted) {
                setState(() {
                  locationPermissionAllowed = true;
                });
              }
              lokasiTerkiniOnResumed();
            }
          });
          break;
        default:
          if (mounted) {
            setState(() {
              locationPermissionAllowed = true;
            });
          }
          lokasiTerkiniOnResumed();
          break;
      }
    }
  }

  showAbsenSukses(BuildContext context, String msg) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      showCloseIcon: true,
      title: 'Presensi Sukses',
      desc: msg,
      btnOkOnPress: () {
        debugPrint('OnClcik');
      },
      btnOkIcon: Icons.check_circle,
    ).show();
  }

  showAbsenGagal(BuildContext context, String msg) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: true,
      title: 'Presensi Gagal',
      desc: msg,
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
    ).show();
  }

  showDilarangMenggunakanMockLocaton() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.RIGHSLIDE,
      title: 'Gagal',
      desc:
          'Presensi dideteksi menggunakan mock lockator, mohon dinonaktifkan.',
      btnOkOnPress: () {
        exit(0);
      },
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
    ).show();
  }

  cekAbsen(BuildContext context) async {
    if (mounted) {
      setState(() {
        loadingAbsen = true;
      });
    }
    kirimAbsen();
    // List<CekLokasi> listCekLokasi = [];
    // for (var i = 0; i < listGedungDanKoordinat!.length; i++) {
    //   List<double> listLat = [];
    //   List<double> listLng = [];

    //   for (var latlng in listGedungDanKoordinat![i].listLatLng!) {
    //     listLat.add(latlng.latitude);
    //     listLng.add(latlng.longitude);
    //   }

    //   CekLokasi cekLokasi = CekLokasi(
    //     latTitikSekarang: _center!.latitude,
    //     lngTitikSekarang: _center!.longitude,
    //     listLatPolygon: listLat,
    //     listLngPolygon: listLng,
    //   );

    //   listCekLokasi.add(cekLokasi);
    // }

    // int idx = 0;
    // for (var ceklok in listCekLokasi) {
    //   if (ceklok.apakahLokasiDalamPolygon()) {
    //     // kirimAbsen();
    //     break;
    //   } else {
    //     if (idx == listCekLokasi.length - 1) {
    //       showAbsenGagalTidakDalamWilayah();
    //     }
    //   }
    //   idx++;
    // }
  }

  showAbsenGagalTidakDalamWilayah() {
    showAbsenGagal(context, 'Anda tidak dalam wilayah gedung.');
    if (mounted) {
      setState(() {
        loadingAbsen = false;
      });
    }
  }

  checkLocationService() async {
    if (mounted) {
      setState(() {
        loadingLocation = true;
      });
    }
    bool serviceEnabled;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          locationServiceEnabled = false;
          loadingLocation = false;
        });
      }
    } else {
      checkLocationPermission();
    }
  }

  kirimAbsen() async {
    //   // print('status presensi : mengiirimkan data presensi...');
    //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //   String? deviceId;
    //   String? osName;

    //   if (Platform.isAndroid) {
    //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //     deviceId = androidInfo.androidId;
    //     osName = 'android';
    //   }

    //   if (Platform.isIOS) {
    //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //     deviceId = iosInfo.identifierForVendor;
    //     osName = 'ios';
    //   }
    //   var url = Uri.parse('http://parkir.unissula.ac.id/api/sim/absenpeg');

    //   var res = await http.post(url, body: {
    //     'nik': nomorInduk,
    //     'deviceid': deviceId,
    //     'os': osName,
    //   }).timeout(const Duration(seconds: 5), onTimeout: () {
    //     setState(() {
    //       loadingAbsen = false;
    //     });

    //     showAbsenGagal(context, 'Timeout');
    //     return http.Response('Error', 408);
    //   });

    //   if (res.statusCode == 200) {
    //     var resbody = res.body;
    //     // print('status presensi : resbody $resbody');
    //     if (resbody == "") {
    //       showAbsenGagal(context, 'Server Error');
    //       setState(() {
    //         loadingAbsen = false;
    //       });
    //     } else {
    //       var jsonData = json.decode(res.body);

    //       // print('status presensi : status code 200..., jsonData : $jsonData');
    //       if (jsonData == null) {
    //         // print('status presensi : json data null...');
    //         showAbsenGagal(context, 'Nomor induk tidak terbaca');
    //
    //       } else {
    //         // print('status presensi : status code 200..., jsonData : $jsonData');
    //         if (jsonData['status'] == "200") {
    //           // print('status presensi : data presensi sukses...');
    //           // getDataPresensi();
    showAbsenSukses(context, 'Presensi Berhasil');
    presensiHariIniController.loadDataHariIni();
    if (mounted) {
      setState(() {
        loadingAbsen = false;
      });
    }
    //           presensiHariIniController.loadDataHariIni(nomorInduk!);
    //         } else {
    //           showAbsenGagal(context, jsonData['message']);
    //         }

    //         if (mounted) {
    //           setState(() {
    //             loadingAbsen = false;
    //           });
    //         }
    //       }
    //     }
    //   } else {
    //     var statuscode = res.statusCode.toString();

    //     showAbsenGagal(context, 'Error : $statuscode');
    //     if (mounted) {
    //       setState(() {
    //         loadingAbsen = false;
    //       });
    //     }
    //   }
  }

  checkLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    switch (permission) {
      case LocationPermission.denied:
        await Geolocator.requestPermission().then((value) {
          if (value == LocationPermission.denied ||
              value == LocationPermission.deniedForever) {
            if (mounted) {
              setState(() {
                locationPermissionAllowed = false;
                loadingLocation = false;
              });
            }
          } else {
            getLokasiTerkini();
          }
        });
        break;
      case LocationPermission.deniedForever:
        await Geolocator.requestPermission().then((value) {
          if (value == LocationPermission.denied ||
              value == LocationPermission.deniedForever) {
            if (mounted) {
              setState(() {
                locationPermissionAllowed = false;
                loadingLocation = false;
              });
            }
          } else {
            getLokasiTerkini();
          }
        });
        break;
      default:
        getLokasiTerkini();
        break;
    }
  }

  getLokasiTerkini() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    if (position.isMocked) {
      showDilarangMenggunakanMockLocaton();
    } else {
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        loadingLocation = false;
      });
    }
  }

  Widget peringatanLokasi(String teks) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.warning),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              teks,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget googleMapWidget() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center!,
        zoom: 16,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: _markers.values.toSet(),
      polygons: _polygons.values.toSet(),
    );
  }

  Widget reloadMapsWidget() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
          const SizedBox(width: 10),
          Text(
            'Loading Maps...',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget locationNotEnabledOrAllowed() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Mohon aktfikan lokasi Anda dan izinkan aplikasi untuk mengakses lokasi Anda. Aplikasi harus memastikan apakah Anda berada dalam lokasi Kampus UNISSULA atau tidak. Presensi kehadiran hanya bisa dilakukan di dalam lokasi UNISSULA.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);
    checkLocationService();
    // getPrefs();
    super.initState();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    _markers.clear();
    _polygons.clear();
    if (mapController != null) {
      mapController!.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print('state = $state');
    if (state == AppLifecycleState.resumed) {
      mapsOnResumed();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return loadingLocation
        ? const LoadingLokasiTerkini()
        : Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: !locationServiceEnabled || !locationPermissionAllowed
                      ? locationNotEnabledOrAllowed()
                      : reloadMaps
                          ? reloadMapsWidget()
                          : googleMapWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Presensi Hari Ini',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                const TimerPresensi(),
                const Divider(),
                const RowPresensiPeg(),
                const SizedBox(height: 5),
                // const Divider(),
                loadingAbsen
                    ? const CustomLoadingWidget(
                        pesanLoading: 'Mengirimkan Presensi',
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => mapsOnResumed(),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF3ABBA2),
                              primary: Colors.white,
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(Icons.refresh),
                          ),
                          SizedBox(
                            width: 150,
                            child: PresensiButton(
                              onBtnPressed: () {
                                if (locationServiceEnabled &&
                                    locationPermissionAllowed) {
                                  cekAbsen(context);
                                } else {
                                  showAbsenGagal(
                                    context,
                                    'Layanan lokasi device anda tidak aktif atau aplikasi tidak diizinkan mengakses lokasi Anda.',
                                  );
                                }
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, '/presensi_terakhir'),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF3ABBA2),
                              primary: Colors.white,
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(Icons.pending_actions),
                          ),
                        ],
                      ),
                TextButton(
                  style: TextButton.styleFrom(primary: const Color(0xFF3ABBA2)),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/pengajuan_cuti'),
                  child: const Text('Pengajuan Cuti'),
                ),
              ],
            ),
          );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    googleMapsInitilization();
  }
}
