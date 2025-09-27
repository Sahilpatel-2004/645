import 'package:flutter/material.dart';

class Completepayment extends StatelessWidget{
  final String totalamount;
  final String resturentname;

  Completepayment({
    required this.totalamount,
    required this.resturentname
  });

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.black,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height*0.4,
            width: MediaQuery.of(context).size.width*0.6,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.white,
                  blurStyle: BlurStyle.outer,
                )
              ]
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text("Payment Successful",style: TextStyle(color: Colors.green,fontSize: 20),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("Total Amount :",style: TextStyle(fontSize: 20,color: Colors.white),),
                    ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(totalamount,style: TextStyle(fontSize: 20,color: Colors.white),),
                )

                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 5),
                        child: Text("Resturent Name :",style: TextStyle(fontSize: 20,color: Colors.green),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 5),
                        child: Text(resturentname,style: TextStyle(fontSize: 20,color: Colors.green),),
                      )
                    ],
                  ),
                )
              ],
            ),
          
          ),
        )
      ],
    ),
   ); 
  }
}