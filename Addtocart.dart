import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:resturent_app/utils/utils.dart';
import 'package:resturent_app/view/User_data/Conformcart.dart';

class AddtoCart extends StatelessWidget {
  final String image;
  final String foodname;
  final String foodprice;
  final String fooddescription;
  final int count;
  final String resturentname;

  AddtoCart({
    required this.resturentname,
    required this.image,
    required this.foodname,
    required this.fooddescription,
    required this.foodprice,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final int price = int.tryParse(foodprice) ?? 0;
    final int total = price * count;
    final database = FirebaseDatabase.instance.ref("AddToCart");
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Your Cart",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white24,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child:
                    image.isNotEmpty
                        ? Image.network(
                          image,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Center(
                                child: Text(
                                  "Image Error",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                        )
                        : Center(
                          child: Text(
                            "No Image",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodname,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    fooddescription,
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price:",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "₹$foodprice",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quantity:",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "$count",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  Divider(color: Colors.white24, thickness: 3, height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹$total",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Other Item Add In Cart",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          database.ref
                              .child(uid)
                              .child(
                                DateTime.now().microsecondsSinceEpoch
                                    .toString(),
                              )
                              .set({
                                "Image": image,
                                "ItemName": foodname,
                                "ItemDesc": fooddescription,
                                "ItemPrice": foodprice,
                                "ItemCount": count,
                                "ItemTotalPrice": total,
                              })
                              .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Item Added To Cart Successfully",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmCart(resturentname:resturentname,)));
                              })
                              .onError((error, StackTrace) {
                                Utils().toast_error(error.toString());
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Confrom Add to Cart",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
