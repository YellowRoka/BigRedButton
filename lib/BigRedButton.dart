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

  late AnimationController internalCirlecontroller;
  late AnimationController animatedCirclecontroller;

  @override
  void initState(){

   _innerCircleSize = widget.size;
   _outerCircleSize = widget.size+20;

    internalCirlecontroller =
      AnimationController(
        duration: const Duration( milliseconds: 500 ),
        vsync:    this 
      )
      ..addListener( () => 
        setState( 
          (){
            _offsetValue = internalCirlecontroller.value * 20;

            if( internalCirlecontroller.isCompleted ){
              animatedCirclecontroller.forward();
            }
          } 
        ) 
      );
    
    animatedCirclecontroller = AnimationController(
      duration: Duration( milliseconds: widget.milisecTimer ),
      vsync:    this 
    )
    ..addListener( () => 
      setState(
        (){
          if( animatedCirclecontroller.isCompleted ){
            internalCirlecontroller.reverse();
            animatedCirclecontroller.reset();
            _isClicked = false;
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

        ExternalCircle( offsetValue: _offsetValue,             outerCircleSize: _outerCircleSize ),
        AnimatedCircle( controller:  animatedCirclecontroller, size:            widget.size      ),
        InternalCircle( 
          innerCircleSize: _innerCircleSize,
          offsetValue:     _offsetValue,
          isClicked:       _isClicked,

          milisecTimer:    widget.milisecTimer,
          controller:      internalCirlecontroller,
          size:            widget.size,

          cbk: () => setState( (){
              internalCirlecontroller.forward();
              _isClicked = true;
            } )
        ),
        
      ]
    );
  }

  @override
  void dispose(){
    internalCirlecontroller.dispose();
    animatedCirclecontroller.dispose();
    super.dispose();
  }

}
