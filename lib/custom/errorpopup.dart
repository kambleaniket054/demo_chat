import 'package:flutter/material.dart';

class Erorrpopup extends StatefulWidget{
  Widget child;
  var data;
  var vm_class;
  Erorrpopup(this.child,this.data,this.vm_class);
  @override
  State<StatefulWidget> createState() {
    return Erorrpopupstate();
  }
}
class Erorrpopupstate extends State<Erorrpopup>{
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Overlay(
       initialEntries: [
         OverlayEntry(builder: (context){
           return Container(
             height: 120,
             width: 120,
             color: Colors.white,
             child: Text("n0data"),
           );
         }),
       ],
      ),
        widget.child,
    ],
    );
  }

}