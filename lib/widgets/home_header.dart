import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  final String? nama;
  final ImageProvider<Object>? userImage;
  final Function logOut;
  final Function(Object, StackTrace?) onError;

  const HomeHeader({
    Key? key,
    required this.nama,
    required this.logOut,
    required this.userImage,
    required this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 25.0,
        top: 10.0,
        bottom: 10.0,
      ),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
        color: Color(0xFF3ABBA2),
      ),
      child: SafeArea(
        child: Row(
          children: [
            userImage == null
                ? Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  )
                : Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: userImage!,
                        onError: onError,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assalamualaikum,',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    nama == null ? 'Nama Kosong' : nama!,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: () => logOut(),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: const Text(''),
            ),
          ],
        ),
      ),
    );
  }
}
