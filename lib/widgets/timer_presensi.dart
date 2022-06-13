import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TimerPresensi extends StatelessWidget {
  const TimerPresensi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateFormat('EEEE, dd MMMM yyyy ', 'id_ID').format(
            DateTime.now(),
          ),
          style: Theme.of(context).textTheme.headline3,
        ),
        StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            return Center(
              child: Text(
                DateFormat('HH:mm:ss', 'id_ID').format(DateTime.now()),
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ],
    );
  }
}
