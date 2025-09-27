import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturent_app/Bloc/Counter/counter_bloc.dart';
import 'package:resturent_app/Bloc/Counter/counter_event.dart';
import 'package:resturent_app/Bloc/Counter/counter_state.dart';
import 'package:resturent_app/function/buttonfunction.dart';
import 'package:resturent_app/view/User_data/Addtocart.dart';
import 'package:resturent_app/view/User_data/login_user.dart';

class DetailPage extends StatefulWidget {
  final String tag;
  final String imageUrl;
  final String itemName;
  final String itemDesc;
  final String itemPrice;
  final String resturentname;

  DetailPage({
    required this.tag,
    required this.imageUrl,
    required this.itemName,
    required this.itemDesc,
    required this.itemPrice,
    required this.resturentname
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final DatabaseReference userRef = FirebaseDatabase.instance.ref("User_Login");
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemName, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Hero(
              tag: widget.tag,
              child: Image.network(
                widget.imageUrl,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Text(
                      widget.itemName,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Text(
                      widget.itemDesc,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "₹${widget.itemPrice}",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),

                    // Quantity Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<CounterBloc>().add(decrement());
                          },
                          icon: Icon(Icons.remove),
                          color: Colors.white,
                          iconSize: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: BlocBuilder<CounterBloc, CounterState>(
                            builder: (context, state) {
                              return Text(
                                state.count.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              );
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<CounterBloc>().add(increment());
                          },
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          iconSize: 30,
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    BlocBuilder<CounterBloc, CounterState>(
                      builder: (context, state) {
                        return buttonFun(
                          butname: "Add To Cart",
                          onpresse: () async {
                            setState(() => loading = true);

                            user = FirebaseAuth.instance.currentUser;

                            if (user == null) {
                              setState(() => loading = false);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => login()),
                              );
                              return;
                            }

                            String safeEmail = user!.email!.replaceAll('.', ',');

                            try {
                              final snapshot = await userRef.child(safeEmail).get();

                              if (!snapshot.exists) {
                                // ✅ Not found in user DB — logout and login again
                                // await auth.signOut();
                                setState(() => loading = false);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => login()),
                                );
                                return;
                              }

                              // ✅ User valid — go to AddToCart
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddtoCart(
                                    image: widget.imageUrl,
                                    foodname: widget.itemName,
                                    fooddescription: widget.itemDesc,
                                    foodprice: widget.itemPrice,
                                    count: state.count,
                                    resturentname: widget.resturentname,
                                  ),
                                ),
                              );
                            } catch (e) {
                              setState(() => loading = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: $e")),
                              );
                            }

                            setState(() => loading = false);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
