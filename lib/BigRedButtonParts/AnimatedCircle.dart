import 'package:flutter/material.dart';

class AnimatedCircle extends StatelessWidget {
  final AnimationController controller;
  final double              size;

  const AnimatedCircle({Key? key, required this.controller, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width:  size,
      child: CircularProgressIndicator(
        color: Colors.red.shade800,
        strokeWidth: 40,
        value: controller.value
      )
    );
  }
}
