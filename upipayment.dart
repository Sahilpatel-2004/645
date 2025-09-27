import 'package:flutter/material.dart';

class upipayment extends StatefulWidget {
  @override
  State<upipayment> createState() => _upipaymentState();
}

class _upipaymentState extends State<upipayment> {
  List<String> PaymentType = [
    "Google Pay",
    "Phone Pay",
    "Paytm",
    "Net Banking",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("UPI Payment", style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: PaymentType.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: InkWell(
                    onTap: (){
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                          bottom: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.white
                          ),
                          right: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.white
                          ),
                          left: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.white
                          ),
                          top: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.white
                          ),
                        )
                      ),
                      height: MediaQuery.of(context).size.height*0.07,
                      width:double.infinity,
                      child: Card(
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            PaymentType[index].toString(),
                            style: TextStyle(color: Colors.white,fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
