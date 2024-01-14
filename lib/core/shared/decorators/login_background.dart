// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../shared_exports.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({
    Key? key,
    required this.firstColor,
    required this.secondColor,
    required this.thirdColor,
    required this.firstHeight,
    required this.secondHeight,
    required this.thirdHeight,
  }) : super(key: key);
final Color firstColor;
final Color secondColor;
final Color thirdColor;

final double firstHeight;
final double secondHeight;
final double  thirdHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: FirstClipper(),
          child: Container(color: firstColor, height: firstHeight),
        ),
        ClipPath(
          clipper: SecondWaveClipper(),
          child: Container(color: secondColor, height: secondHeight),
        ),
        ClipPath(
          clipper: FirstClipper(),
          child: Container(color: thirdColor, height: thirdHeight),
        ),
      ],
    );
  }
}
