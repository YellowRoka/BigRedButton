import 'package:flutter/material.dart';

import 'CentralIcons.dart';

class InternalCircle extends StatelessWidget {
  final double              size;
  final double              innerCircleSize;
  final double              offsetValue;
  final int                 milisecTimer;
  final bool                isClicked;
  final AnimationController controller;
  final VoidCallback        cbk;

  const InternalCircle({
    Key? key, 
    required this.innerCircleSize, 
    required this.offsetValue, 
    required this.milisecTimer, 
    required this.isClicked, 
    required this.controller, 
    required this.cbk, 
    required this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return         Container(
      width:      innerCircleSize - offsetValue,
      height:     innerCircleSize - offsetValue,

      decoration: BoxDecoration(
        shape:    BoxShape.circle,
        gradient: LinearGradient(
          begin:    Alignment.topCenter,
          end:      Alignment.bottomCenter,
          colors:   ( !isClicked )?( [ Colors.red.shade400, Colors.red.shade800 ] ):( [ Colors.red.shade800, Colors.red.shade400, Colors.red.shade100 ] )
        ),

        boxShadow: const [ BoxShadow(
          color:      Colors.black,
          offset:       Offset.zero,
          blurRadius:   30.0,
          spreadRadius: 0.5,
          blurStyle:    BlurStyle.normal,
        ) ]
      ),
  
      child: GestureDetector(
        onTap: cbk,
        child: Center(
          child: CentralIcons( 
            isAnimationFinished: controller.isCompleted,
            milisecTimer:        milisecTimer, 
            size:                size,
            )
        ),
      ),

    );
  }
}
