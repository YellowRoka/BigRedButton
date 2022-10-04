import 'package:flutter/material.dart';

class ExternalCircle extends StatelessWidget {
  
  final double outerCircleSize;
  final double offsetValue;

  const ExternalCircle({Key? key, required this.outerCircleSize, required this.offsetValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:     outerCircleSize + offsetValue,
      width:      outerCircleSize + offsetValue,
      decoration: BoxDecoration(
        shape:    BoxShape.circle,
        gradient: LinearGradient(
          begin:  Alignment.center,
          end:    Alignment.topCenter,
          colors: [ Colors.grey.shade50, Colors.grey.shade100 ]
        ),
        boxShadow: const [ 
          BoxShadow(
            color:      Colors.black,
            offset:       Offset.zero,
            blurRadius:   10.0,
            spreadRadius: 0.1,
            blurStyle:    BlurStyle.normal,
          ) 
        ]
      ),
    );
  }
}
