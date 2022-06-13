import 'package:flutter/material.dart';

class GreyContainer extends StatelessWidget {
  const GreyContainer({
    Key? key,
    required this.containerChild,
  }) : super(key: key);

  final Widget containerChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 4),
            color: const Color(0xFF000000).withOpacity(0.1),
          )
        ],
      ),
      child: containerChild,
    );
  }
}
