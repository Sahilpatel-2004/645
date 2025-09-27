import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:resturent_app/view/User_data/user_bottomnavigator.dart';
import 'dart:async';
import 'package:resturent_app/view/hotel_owner/login_owner.dart';
import 'package:resturent_app/view/hotel_page/hotel_detail.dart';
import 'package:resturent_app/view/hotel_page/hotel_mainpage.dart';

class Selection extends StatefulWidget {
  @override
  State<Selection> createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  final DatabaseReference ownerRef = FirebaseDatabase.instance.ref("Owner SignUp Data"); // ✅
  final DatabaseReference userRef = FirebaseDatabase.instance.ref("User_Login"); // ✅
  final DatabaseReference resturentDetailRef = FirebaseDatabase.instance.ref("ResturentDetail");
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;
  User? user;

  @override
  void initState() {
    super.initState();
  }

  // ✅ OWNER PATH
  Future<void> navigateOwner() async {
    setState(() => loading = true);

    user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => login_as_owner()));
      return;
    }

    String safeEmail = user!.email!.replaceAll('.', ',');

    try {
      final snapshot = await ownerRef.child(safeEmail).get();

      if (!snapshot.exists) {
        // ✅ User is logged in, but not an owner
        // await auth.signOut();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => login_as_owner()));
        return;
      }

      final resturentSnap = await resturentDetailRef.child(safeEmail).get();

      if (resturentSnap.exists) {
        final hotelName = resturentSnap.child("Resturent_Name").value.toString();
        final phone = resturentSnap.child("PhoneNumber").value.toString();
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => hotelmainpage(hotelname: hotelName, number: phone),
        ));
      } else {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => hotel_detail(email: user!.email!),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    setState(() => loading = false);
  }

 

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                "assets/images/user_and_owner_selection.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Select Your Role",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: InkWell(
                    onTap: navigateOwner, // 🔁 UPDATED
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black87,
                      ),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Center(
                        child: Text(
                          "Owner",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: InkWell(
                    onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>UserBottomnavigator()));}, // 🔁 UPDATED
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black87,
                      ),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Center(
                        child: Text(
                          "User",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
