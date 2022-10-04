import 'package:flutter/material.dart';
import 'package:unique_anim_button/BigRedButtonParts/InternalCircle.dart';

import 'BigRedButtonParts/AnimatedCircle.dart';
import 'BigRedButtonParts/ExternalCircle.dart';

class BigRedButton extends StatefulWidget {
  final int    milisecTimer;
  final double size;

  const BigRedButton({Key? key, required this.milisecTimer, required this.size}) : super(key: key);

  @override
  State<BigRedButton> createState() => _BigRedButtonState();
}

class _BigRedButtonState extends State<BigRedButton> with TickerProviderStateMixin {
  late double _innerCircleSize;
  late double _outerCircleSize;

  double _offsetValue     = 0;
  bool   _isClicked       = false;

  late AnimationController controller;
  late AnimationController controller2;

  @override
  void initState(){

   _innerCircleSize = widget.size;
   _outerCircleSize = widget.size+20;

    controller =
      AnimationController(
        duration: const Duration( milliseconds: 500 ),
        vsync:    this 
      )
      ..addListener( () => 
        setState( 
          (){
            _offsetValue = controller.value*20;

            if( controller.isCompleted ){
              controller2.forward();
            }
          } 
        ) 
      );
    
    controller2 = AnimationController(
      duration: Duration( milliseconds: widget.milisecTimer ),
      vsync:    this 
    )
    ..addListener( () => 
      setState( 
        (){
          if( controller2.isCompleted ){
            controller.reverse();
          }
        } 
      ) 
    );

    super.initState();
  }

  @override
  Widget build( BuildContext context ){
    return Stack(
      alignment: Alignment.center,
      children:  [

        ExternalCircle( offsetValue: _offsetValue, outerCircleSize: _outerCircleSize ),
        AnimatedCircle( controller: controller2, size: widget.size),
        InternalCircle( 
          innerCircleSize: _innerCircleSize,
          offsetValue:     _offsetValue,
          milisecTimer:    widget.milisecTimer,
          isClicked:       _isClicked,
          controller:      controller,
          size:            widget.size,
          
          cbk: (){
            setState( (){
              controller.forward();
              _isClicked = true;
            } );
          }, 
        ),
        
      ]
    );
  }

  @override
  void dispose(){
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

}
