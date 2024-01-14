import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppDoneIcon extends StatelessWidget {
  const AppDoneIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset('lib/assets/jsons/done.json', height: 40,width: 40, repeat: false,));
  }
}
