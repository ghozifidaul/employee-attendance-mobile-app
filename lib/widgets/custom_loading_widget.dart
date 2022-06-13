import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLoadingWidget extends StatelessWidget {
  final String pesanLoading;
  const CustomLoadingWidget({
    Key? key,
    required this.pesanLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
          pesanLoading,
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
