import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:resturent_app/function/buttonfunction.dart';
import 'package:resturent_app/function/containerfun.dart';
import 'package:resturent_app/utils/routes/routes_name.dart';
import 'package:resturent_app/utils/utils.dart';

class AccountPage extends StatefulWidget {
  final String number;

  AccountPage({required this.number});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _auth = FirebaseAuth.instance;
  late final DatabaseReference ref;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    final emailKey = FirebaseAuth.instance.currentUser!.email!.replaceAll('.', ',');
    ref = FirebaseDatabase.instance.ref("ResturentDetail").child(emailKey);
  }

  void issingnout() {
    setState(() {
      loading = true;
    });
    _auth.signOut().then((value) {
      Utils().toast("You are signed out");
      setState(() {
        loading = false;
      });
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.login_as_owner,
        (route) => false,
      );
    }).onError((error, stackTrace) {
      Utils().toast(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(
                "assets/images/show_user_profile_bg_photo.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder<DatabaseEvent>(
            future: ref.once(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                return Center(child: Text("No data found"));
              }

              final data = Map<String, dynamic>.from(
                snapshot.data!.snapshot.value as Map,
              );

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "Resturent Account",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 35),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: data["Image Url"] != null &&
                                    data["Image Url"] != ""
                                ? NetworkImage(data["Image Url"])
                                : AssetImage("assets/images/default_profile.png") as ImageProvider,
                          ),
                        ),
                        SizedBox(height: 20),
                        container(
                          name: "Restaurant Name: ${data["Resturent_Name"] ?? "N/A"}",
                        ),
                        container(
                          name: "Owner Name: ${data["Resturent_OwnerName"] ?? "N/A"}",
                        ),
                        container(
                          name: "Phone: ${data["PhoneNumber"] ?? "N/A"}",
                        ),
                        container(
                          name: "Open Time: ${data["OpenTime"] ?? "N/A"}",
                        ),
                        container(
                          name: "Close Time: ${data["CloseTime"] ?? "N/A"}",
                        ),
                        container(
                          name: "Location: ${data["Location"] ?? "N/A"}",
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        buttonFun(
                          butname: "SignOut",
                          onpresse: issingnout,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
