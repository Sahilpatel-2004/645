import 'package:flutter/material.dart';
import 'package:resturent_app/view/User_data/Payment/UPI/upipayment.dart';
import 'package:resturent_app/view/User_data/Payment/cash/cashondelivery.dart';
import 'package:resturent_app/view/User_data/Payment/credit/debitcard.dart';

class Payment extends StatefulWidget {
  final String totalamount;
  final String resturentname;

  Payment({required this.totalamount,required this.resturentname});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String selectedPayment = 'UPI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Payment",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Amount:",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Text(
                  "₹${widget.totalamount}",
                  style: TextStyle(fontSize: 25, color: Colors.greenAccent),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Payment Options
            Text(
              "Select Payment Method:",
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            SizedBox(height: 10),
            RadioListTile(
              activeColor: Colors.green,
              tileColor: Colors.grey[900],
              title: Text("UPI", style: TextStyle(color: Colors.white)),
              value: 'UPI',
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value.toString();
                });
              },
            ),
            RadioListTile(
              activeColor: Colors.green,
              tileColor: Colors.grey[900],
              title: Text(
                "Credit / Debit Card",
                style: TextStyle(color: Colors.white),
              ),
              value: 'Card',
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value.toString();
                });
              },
            ),
            RadioListTile(
              activeColor: Colors.green,
              tileColor: Colors.grey[900],
              title: Text(
                "Cash on Delivery",
                style: TextStyle(color: Colors.white),
              ),
              value: 'Cash',
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value.toString();
                });
              },
            ),

            Spacer(),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (_) => AlertDialog(
                        backgroundColor: Colors.black,
                        title: Text(
                          "Order Confirmed",
                          style: TextStyle(color: Colors.greenAccent),
                        ),
                        content: Text(
                          "Payment via $selectedPayment\nTotal: ₹${widget.totalamount}",
                          style: TextStyle(color: Colors.white),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if ("$selectedPayment" == "Card") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreditDebitCard(totalamount: widget.totalamount,resturentname: widget.resturentname,),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Enter your Credit/Debit Card Detail",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }else if("$selectedPayment" == "UPI"){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>upipayment()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Choose Any UPI",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }else{
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cashondelivery()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Cash On Delivery",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );

                              }
                            },
                            child: Text(
                              "OK",
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                          ),
                        ],
                      ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Proceed to Pay",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
