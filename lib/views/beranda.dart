import 'package:employee_attendance_app/controllers/kalender_presensi_controller.dart';
import 'package:employee_attendance_app/controllers/preferensi_controller.dart';
import 'package:employee_attendance_app/controllers/presentase_presensi.dart';
import 'package:employee_attendance_app/models/kalender_presensi.dart';
import 'package:employee_attendance_app/widgets/custom_loading_widget.dart';
import 'package:employee_attendance_app/widgets/grey_container.dart';
import 'package:employee_attendance_app/widgets/indicator.dart';
import 'package:employee_attendance_app/widgets/presensi_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  String? nomorInduk;
  bool isDosen = false;

  PresentasePresensiController presentasePresensiController =
      Get.put(PresentasePresensiController());

  KalenderPresensiController kalenderPresensiController =
      Get.put(KalenderPresensiController());

  PreferensiController prefC = Get.put(PreferensiController());

  Widget pageTitle() => Text(
        'Beranda',
        style: Theme.of(context).textTheme.headline1,
      );

  List<KalenderPresensiModel> _getEventsForDay(DateTime day) =>
      kalenderPresensiController.listKalenderPresensi
          .where((listkal) => isSameDay(day, listkal.tgl))
          .toList();

  _onDaySelected(DateTime selectedDay, DateTime focusedDay) =>
      kalenderPresensiController.setFocusedDay(selectedDay);

  Widget _markerKalender(List<KalenderPresensiModel> events) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: events.map((e) {
          switch (e.statusAbsen) {
            case "Alpha":
              return Container(
                width: 5,
                height: 5,
                color: Colors.red,
              );
            case "Terlambat":
              return Container(
                width: 5,
                height: 5,
                color: Colors.yellow,
              );
            case "Hadir":
              return Container(
                width: 5,
                height: 5,
                color: Colors.green,
              );
            default:
              return Container(
                width: 5,
                height: 5,
                color: Colors.blue,
              );
          }
        }).toList(),
      );

  KalenderPresensiModel getKalenderPresensi(DateTime day) {
    return kalenderPresensiController.getKalenderPresensiFromDay(day);
  }

  Widget _rowEventKalender(String lblData, String isiData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          lblData,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          isiData,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget kalenderPresensi() {
    if (kalenderPresensiController.isLoading.value != true) {
      return GreyContainer(
        containerChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              locale: 'id_ID',
              eventLoader: _getEventsForDay,
              focusedDay: kalenderPresensiController.focusedDay.value,
              selectedDayPredicate: (day) =>
                  isSameDay(kalenderPresensiController.focusedDay.value, day),
              onDaySelected: _onDaySelected,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              firstDay: DateTime(2010),
              lastDay: DateTime(2030),
              calendarBuilders: CalendarBuilders(
                markerBuilder:
                    (context, day, List<KalenderPresensiModel> events) {
                  if (events.isEmpty) {
                    return Container();
                  } else {
                    return _markerKalender(events);
                  }
                },
              ),
            ),
            const Divider(),
            _rowEventKalender(
              'Status Absen',
              getKalenderPresensi(kalenderPresensiController.focusedDay.value)
                      .statusAbsen ??
                  '-',
            ),
            const Divider(),
            _rowEventKalender(
              'Jam Datang',
              getKalenderPresensi(kalenderPresensiController.focusedDay.value)
                      .jamDatang ??
                  'Tidak Absen',
            ),
            const Divider(),
            isDosen
                ? Container()
                : _rowEventKalender(
                    'Jam Pulang',
                    getKalenderPresensi(
                                kalenderPresensiController.focusedDay.value)
                            .jamPulang ??
                        'Tidak Absen',
                  ),
          ],
        ),
      );
    } else {
      return const CustomLoadingWidget(pesanLoading: 'Loading...');
    }
  }

  Widget chartPresensi() {
    if (presentasePresensiController.listPieChartSectionData.isEmpty) {
      return Container();
    } else {
      return const PieChartSample2();
    }
  }

  Widget rowIndicator(
          Color indicatorColor, String indicatorLabel, int indicatorValue) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Indicator(
            color: indicatorColor,
            text: indicatorLabel,
            isSquare: true,
          ),
          Text(
            indicatorValue.toString(),
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      );

  Widget keteranganChart() {
    if (presentasePresensiController.listPieChartSectionData.isEmpty) {
      return Container();
    } else {
      return GreyContainer(
        containerChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Keterangan :',
              style: Theme.of(context).textTheme.headline3,
            ),
            const Divider(),
            rowIndicator(
              const Color(0xffBB3A3A),
              'Alpha',
              presentasePresensiController
                  .presenstasePresensiBulanIni.value.alpha!,
            ),
            const Divider(),
            rowIndicator(
              const Color(0xff3A75BB),
              'Cuti',
              presentasePresensiController
                  .presenstasePresensiBulanIni.value.cuti!,
            ),
            const Divider(),
            rowIndicator(
              Colors.green,
              'Hadir',
              presentasePresensiController
                  .presenstasePresensiBulanIni.value.hadir!,
            ),
            const Divider(),
            rowIndicator(
              Colors.redAccent,
              'Izin Tidak Masuk',
              presentasePresensiController
                  .presenstasePresensiBulanIni.value.izinTidakMasuk!,
            ),
            const Divider(),
            rowIndicator(
              Colors.blue,
              'Lembur',
              presentasePresensiController
                  .presenstasePresensiBulanIni.value.lembur!,
            ),
            const Divider(),
            rowIndicator(
              Colors.blueGrey,
              'Libur',
              presentasePresensiController
                  .presenstasePresensiBulanIni.value.libur!,
            ),
            const Divider(),
            rowIndicator(
              const Color(0xffCFD23A),
              'Terlambat',
              presentasePresensiController
                  .presenstasePresensiBulanIni.value.terlambat!,
            ),
            const Divider(),
            rowIndicator(
              Colors.greenAccent,
              'Pulang Awal',
              presentasePresensiController
                  .presenstasePresensiBulanIni.value.pulangAwal!,
            ),
            const Divider(),
            rowIndicator(
              Colors.lightGreen,
              'Sakit',
              presentasePresensiController
                  .presenstasePresensiBulanIni.value.sakit!,
            ),
            const Divider(),
            rowIndicator(
              Colors.pink,
              'Tidak Absen Datang',
              presentasePresensiController
                  .presenstasePresensiBulanIni.value.tidakAbsenDatang!,
            ),
            const Divider(),
            rowIndicator(
              Colors.purple,
              'Tidak Absen Pulang',
              presentasePresensiController
                  .presenstasePresensiBulanIni.value.tidakAbsenPulang!,
            ),
          ],
        ),
      );
    }
  }

  getPrefs() async {
    bool isDosenFromPref = await prefC.isDosen();
    if (mounted) {
      setState(() {
        isDosen = isDosenFromPref;
      });
    }
  }

  @override
  void initState() {
    presentasePresensiController.getDataPresentaseFromAPI();
    kalenderPresensiController.getDataPresensiFromAPI();
    getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pageTitle(),
            Obx(() => kalenderPresensi()),
            Text(
              'Presensi Bulan Ini',
              style: Theme.of(context).textTheme.headline2,
            ),
            Obx(() => chartPresensi()),
            Obx(() => keteranganChart()),
          ],
        ),
      ),
    );
  }
}
