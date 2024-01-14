import 'package:flutter/material.dart';

import '../shared_exports.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({
    Key? key,
    required this.firstColor,
    required this.secondColor,
    required this.logo,
  }) : super(key: key);

  final Color firstColor;
  final Color secondColor;
  final String logo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 5,
            blurRadius: 9,
            offset: Offset(0, 9), // changes position of shadow
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 60,
        child: GradientIcon(
          myChild: Image.asset(logo, scale: 6,),
          firstGradientColor: firstColor, // Use the provided color
          secondGradientColor: secondColor, // Use the provided color
        ),
      ),
    );
  }
}
