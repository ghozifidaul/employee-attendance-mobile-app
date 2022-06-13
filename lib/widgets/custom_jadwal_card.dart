import 'package:employee_attendance_app/models/jadwal_mengajar_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomJadwalKuliahCard extends StatelessWidget {
  // final String? waktuMulai;
  // final String? waktuSelesai;
  // final String? namaMk;
  // final String? lokasi;
  final String? waktuSekarang;
  final JadwalMengajarModel jadwalMengajarModel;
  final void Function() bukaKelasFunc;
  final void Function() editKelasFunc;
  final void Function() batalBukaKelasFunc, daftarHadirFunc, hapusJadwalFunc;
  // final MKModel dataMK;

  const CustomJadwalKuliahCard({
    Key? key,
    // this.waktuMulai,
    // this.waktuSelesai,
    // this.namaMk,
    // this.lokasi,
    this.waktuSekarang,
    required this.jadwalMengajarModel,
    required this.bukaKelasFunc,
    required this.editKelasFunc,
    required this.batalBukaKelasFunc,
    required this.daftarHadirFunc,
    required this.hapusJadwalFunc,
  }) : super(key: key);

  Widget columnKelasDibuka() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 5),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.green,
            primary: Colors.white,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: daftarHadirFunc,
          // icon: const Icon(Icons.list),
          child: const Text(
            'Daftar Hadir',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.red,
            primary: Colors.white,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: batalBukaKelasFunc,
          // icon: const Icon(Icons.cancel_outlined),
          child: const Text(
            'Batal Buka Kelas',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget rowKelasBelumDibuka() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                width: double.maxFinite,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    primary: Colors.white,
                  ),
                  onPressed: bukaKelasFunc,
                  child: const Text(
                    'Buka Kelas',
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              flex: 1,
              child: SizedBox(
                width: double.maxFinite,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    primary: Colors.white,
                  ),
                  onPressed: editKelasFunc,
                  child: const Text(
                    'Edit Kelas',
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(height: 5),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            primary: Colors.white,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: hapusJadwalFunc,
          child: const Text(
            'Hapus Jadwal',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // DateTime timeStart =
    //     DateFormat("hh:mm").parse(jadwalMengajarModel.waktuMulai!);
    // DateTime timeEnd =
    //     DateFormat("hh:mm").parse(jadwalMengajarModel.waktuSelesai!);
    // DateTime timeNow = DateFormat("hh:mm").parse(waktuSekarang!);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF52ABAB),
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(10)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        jadwalMengajarModel.waktuMulai ?? '-',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(color: Colors.white),
                      ),
                      const Icon(
                        Icons.play_circle_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFC35656),
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        jadwalMengajarModel.waktuSelesai ?? '-',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(color: Colors.white),
                      ),
                      const Icon(
                        Icons.stop_circle_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jadwalMengajarModel.namaMK ?? '-',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3E3E3E),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          jadwalMengajarModel.namaRuang ?? '-',
                          style: Theme.of(context)
                              .textTheme
                              .overline
                              ?.copyWith(color: const Color(0xFFA1A1A1)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  jadwalMengajarModel.statusPerkuliahan == "0"
                      ? rowKelasBelumDibuka()
                      : columnKelasDibuka()
                  // const SizedBox(height: 10),
                  // if (timeStart.isAtSameMomentAs(timeNow) ||
                  //     (timeStart.isBefore(timeNow) &&
                  //         timeEnd.isAfter(timeNow)) ||
                  //     timeEnd.isAtSameMomentAs(timeNow))
                  //   // if (true)
                  //   GestureDetector(
                  //     onTap: () {
                  //       // Navigator.push(
                  //       //   context,
                  //       //   MaterialPageRoute(
                  //       //     builder: (context) => Presensi(dataMK: dataMK),
                  //       //   ),
                  //       // );
                  //       // print('dataMK:' + dataMK.namaGedung);
                  //       // print('LatLng : ' +
                  //       //     dataMK.listKoordinat[0].latitude.toString());
                  //     },
                  //     child: Container(
                  //         width: double.infinity,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(5),
                  //           color: const Color(0xFF2B7C79),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(2.0),
                  //           child: Center(
                  //               child: Text(
                  //             'Absen',
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .caption
                  //                 ?.copyWith(color: Colors.white),
                  //           )),
                  //         )),
                  //   )
                  // else
                  //   Container()
                ],
              ),
            ))
      ],
    );
  }
}
