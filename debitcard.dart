import 'dart:math';

import 'package:debit_credit_card_widget/debit_credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:resturent_app/function/elebutton.dart';
import 'package:resturent_app/view/User_data/Payment/credit/completepayment.dart';

class CreditDebitCard extends StatefulWidget {
  final String totalamount;
  final String resturentname;

  CreditDebitCard({required this.totalamount,required this.resturentname});
  @override
  _CreditDebitCardState createState() => _CreditDebitCardState();
}

class _CreditDebitCardState extends State<CreditDebitCard> {
  final namecontroller = TextEditingController();
  final cardExpirycontroller = TextEditingController();
  final cardnumbercontroller = TextEditingController();

  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Credit/Debit Card Detail",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Total Amount :",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    widget.totalamount,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.white, thickness: sqrt1_2),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: namecontroller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter Name on Credit/Debit Card",
                  hintStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: cardnumbercontroller,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter Card Number",
                  hintStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Text(
                    pickedDate == null
                        ? "Pick Expiry Date"
                        : "Expiry: ${pickedDate!.month}/${pickedDate!.year}",
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        initialDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          pickedDate = date;
                        });
                      }
                    },
                    child: Text("Pick Date"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: DebitCreditCardWidget(
                cardHolderName: namecontroller.text,
                cardNumber: cardnumbercontroller.text,
                cardExpiry:
                    pickedDate != null
                        ? "${pickedDate!.month}/${pickedDate!.year % 100}"
                        : "MM/YY",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Elevetionbutton(
                name: "Process",
                onPressed: () {
                  String cardnumber = cardnumbercontroller.text.trim();
                  String cardholdername = namecontroller.text.trim();
                  if (cardnumber.isEmpty || cardholdername.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(

                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Enter above All Detail",
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                      ),
                    );
                  }
                  else if(pickedDate ==null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Enter Card Expiry Date",style: TextStyle(color: Colors.white),),
                      ),
                    );

                  }  
                  else if (cardnumber.length == 16) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Vaild Card Number Processing..."),
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Completepayment(totalamount: widget.totalamount,resturentname: widget.resturentname,),
                      ),
                    );
                  } 
                  
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Enter Vaild Card Number",style: TextStyle(color: Colors.white),),
                      ),
                    );
                    
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
