import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:resturent_app/view/User_data/Payment/credit/payment.dart';

class ConfirmCart extends StatefulWidget {
  final String resturentname;

  ConfirmCart({
    required this.resturentname
  });
  @override
  State<ConfirmCart> createState() => _ConfirmCartState();
}

class _ConfirmCartState extends State<ConfirmCart> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref(
    "AddToCart/${FirebaseAuth.instance.currentUser!.uid}",
  );

  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    calculateTotal();
  }

  Future<void> calculateTotal() async {
    final snapshot = await ref.get();
    int tempTotal = 0;

    if (snapshot.exists) {
      final data = snapshot.value as Map;

      data.forEach((key, value) {
        final item = value as Map;
        final itemTotal = int.tryParse(item['ItemTotalPrice'].toString()) ?? 0;
        tempTotal += itemTotal;
      });
    }

    setState(() {
      totalAmount = tempTotal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirm Cart",
          style: TextStyle(fontSize: 26, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                final data = snapshot.value as Map;
                final image = data['Image'] ?? "";
                final name = data['ItemName'] ?? "";
                final price = data['ItemPrice'] ?? "0";
                final count = data['ItemCount'] ?? 1;
                final total = data['ItemTotalPrice'] ?? 0;

                return Card(
                  color: Colors.grey[900],
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    constraints: BoxConstraints(
                      minHeight: 90,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "₹$price × $count",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "₹$total",
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () async {
                                await ref.child(snapshot.key!).remove();
                                calculateTotal();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Item removed from cart"),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Divider(color: Colors.white24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "₹$totalAmount",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            Payment(totalamount: totalAmount.toString(),resturentname:widget.resturentname,),
                  ),
                );

                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text("Pay Amount"),
                //     backgroundColor: Colors.green,
                //   ),
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Order Now",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
