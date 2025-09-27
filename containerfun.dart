import 'package:flutter/material.dart';

class container extends StatelessWidget{

  final String name;
  container({
    required this.name
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        height: MediaQuery.of(context).size.height*0.09,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),topRight: Radius.circular(15),
            ),
          border: Border(
              bottom: BorderSide(
                style: BorderStyle.solid
              ),
              right: BorderSide(
                style: BorderStyle.solid
              ),
              left: BorderSide(
                style: BorderStyle.solid
              ),
              top: BorderSide(
                style: BorderStyle.solid,
              ),
            ),
        ),
        child: Center(child: Text(name,style: TextStyle(fontSize: 25,color: Colors.white),))
      
      ),
    );
  }

}