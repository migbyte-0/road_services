// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget? myChild;
  final double? myHeight;
  final double? myWidth;
  final Color firstGradientColor;
  final Color secondGradientColor;
  final BorderRadius? myContainerBorderRadius;
  final List<BoxShadow>? myShadow;

  const GradientContainer({
    super.key,
    this.myChild,
    this.myHeight,
    this.myWidth,
    required this.firstGradientColor,
    required this.secondGradientColor,
    this.myContainerBorderRadius,
    this.myShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: myHeight,
      width: myWidth,
      decoration: BoxDecoration(
          boxShadow: myShadow,
          borderRadius: myContainerBorderRadius,
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[firstGradientColor, secondGradientColor])),
      child: myChild,
    );
  }
}
