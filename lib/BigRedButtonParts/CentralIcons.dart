import 'package:flutter/material.dart';

class CentralIcons extends StatefulWidget {
  final bool   isAnimationFinished;
  final int    milisecTimer;
  final double size;

  const CentralIcons({ Key? key, required this.isAnimationFinished, required this.milisecTimer, required this.size }) : super(key: key);

  @override
  State<CentralIcons> createState() => _CentralIconsState();
}

class _CentralIconsState extends State<CentralIcons> with TickerProviderStateMixin {
  
  late int                 counter;
  late AnimationController controller;

  @override
  void initState(){
    counter    = ( widget.milisecTimer / 1000 ).ceil();
    controller = AnimationController(
      duration: Duration( milliseconds: widget.milisecTimer ),
      vsync:    this,
    )
    ..addListener( (){ 
      setState(() {
        counter = 1 + counter - ( controller.value * counter ).ceil();
      });
      }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.isAnimationFinished){
      controller.forward();
    }

    return Container(
      child: ( widget.isAnimationFinished )?(
        Text( 
          "$counter", 
          style: TextStyle(
            color:    Colors.white,
            fontWeight: FontWeight.bold,
            fontSize:   widget.size/3
            ),
          )
      ):(
        Stack(
          alignment: Alignment.center,
          children: [
            Icon( Icons.ac_unit, size: widget.size/3,  color: Colors.white54.withOpacity(0.7), ),
            Icon( Icons.ac_unit, size: widget.size/6,  color: Colors.white70.withOpacity(0.8), ),
            Icon( Icons.circle,  size: widget.size/12, color: Colors.white.withOpacity(1),     ),
          ],
        )
      ),
      
    );
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

}
