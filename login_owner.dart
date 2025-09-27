import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturent_app/Getx/controller/owner/login_owner_controller.dart';
import 'package:resturent_app/function/buttonfunction.dart';
import 'package:resturent_app/view/hotel_owner/signup_owner.dart';


class login_as_owner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return login_as_ownerstate();
  }
}

class login_as_ownerstate extends State<login_as_owner> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref(
    "Owner SignUp Data",
  );
  UserCredential? userCredential;
  final LoginOwnerController logincontroller = Get.put(
    LoginOwnerController(),
  );
  bool loading = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  // void islogin(String email, String password) async {
  //   setState(() {
  //     loading = true;
  //   });

  //   try {
  //     // Firebase Auth Login
  //      userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email.trim(),
  //       password: password.trim(),
  //     );

  //     String safeEmail = email.trim().replaceAll('.', ',');

  //     // Fetch role from Realtime DB
  //     final snapshot = await dbRef.child(safeEmail).get();

  //     if (snapshot.exists) {
  //       final data = Map<String, dynamic>.from(snapshot.value as Map);
  //       final role = data["role"];

  //       if (role == "owner") {
  //         // Save role in SharedPreferences
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setString("role", "owner");

  //         Utils().flushbar("Login Successful");

  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => hotel_detail(email: email.trim())),
  //         );
  //       } else {
  //         await _auth.signOut();
  //         Utils().flushbar_error("This account is not registered as an owner.");
  //       }
  //     } else {
  //       await _auth.signOut();
  //       Utils().flushbar_error("Owner data not found in the database.");
  //     }
  //   } catch (e) {
  //     Utils().flushbar_error(e.toString());
  //   }

  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login As Owner", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://img.freepik.com/free-photo/top-view-delicious-indonesian-bakso_23-2148933346.jpg?ga=GA1.1.2132475854.1710943859&semt=ais_keywords_boost",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  controller: logincontroller.emailController.value,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    label: Text(
                      "E-mail",
                      style: TextStyle(color: Colors.white),
                    ),
                    hintText: "Enter Your E-mail",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  controller: logincontroller.passwordController.value,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    label: Text(
                      "Password",
                      style: TextStyle(color: Colors.white),
                    ),
                    hintText: "Enter Your Password",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.password, color: Colors.white),
                  ),
                ),
              ),
              buttonFun(
                butname: "Login",
                loading: loading,
                onpresse: () {
                 logincontroller.loginOwner();
                },
              ),
              buttonFun(
                butname: "SignUp",
                onpresse: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => signup_as_owner()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
