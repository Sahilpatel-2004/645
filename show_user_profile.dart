import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:resturent_app/function/buttonfunction.dart';
import 'package:resturent_app/function/containerfun.dart';
import 'package:resturent_app/utils/utils.dart';
import 'package:resturent_app/view/User_data/login_user.dart';

class show_user_profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return show_user_profilestate();
  }
}

class show_user_profilestate extends State<show_user_profile> {
  late DatabaseReference ref;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final auth = FirebaseAuth.instance;

  void issignout() {
    auth
        .signOut()
        .then((value) {
          Utils().toast("Successful SignOut");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => login()),
          );
        })
        .onError((error, StackTrace) {
          Utils().toast(error.toString());
        });
  }

  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref("UserDetail").child(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 24, 24),
        title: Text("Your Profile", style: TextStyle(color: Colors.white)),
      ),
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
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                data["Image Url"] != null &&
                                        data["Image Url"] != ""
                                    ? NetworkImage(data["Image Url"])
                                    : NetworkImage(
                                      "https://cdn-icons-png.flaticon.com/512/9815/9815472.png",
                                    ),
                          ),
                        ),
                        SizedBox(height: 20),
                        container(
                          name: "User Name: ${data["User_Name"] ?? "N/A"}",
                        ),
                        container(
                          name: "Phone: ${data["User_MobileNumber"] ?? "N/A"}",
                        ),
                        container(name: "City : ${data["User_City"] ?? "N/A"}"),
                        container(
                          name: "Address: ${data["User_Address"] ?? "N/A"}",
                        ),
                        container(name: "Age: ${data["User_Age"] ?? "N/A"}"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        buttonFun(
                          butname: "SignOut",
                          onpresse: () {
                            issignout();
                          },
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
