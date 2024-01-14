import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final Widget myChild;
  final Color firstGradientColor;
  final Color secondGradientColor;
  const GradientIcon({
    super.key,
    required this.myChild,
    required this.firstGradientColor,
    required this.secondGradientColor,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [firstGradientColor, secondGradientColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: myChild,
    );
  }
}
