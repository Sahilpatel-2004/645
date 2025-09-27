import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturent_app/Getx/controller/owner/signup_owner_controller.dart';
import 'package:resturent_app/function/buttonfunction.dart';
import 'package:resturent_app/view/hotel_owner/login_owner.dart';

class signup_as_owner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return signup_as_ownerstate();
  }
}

class signup_as_ownerstate extends State<signup_as_owner> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final signup_owner_controller signupcontroller = Get.put(signup_owner_controller());

  final database = FirebaseDatabase.instance.ref("Owner SignUp Data");
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  // void issignup(String email, String password) async {
  //   if (!_formKey.currentState!.validate()) return;

  //   setState(() {
  //     loading = true;
  //   });

  //   try {
  //     // Firebase Authentication
  //     await _auth.createUserWithEmailAndPassword(
  //       email: email.trim(),
  //       password: password.trim(),
  //     );

  //     // Save to Firebase Realtime Database
  //     String safeEmail = email.trim().replaceAll('.', ',');

  //     await database.child(safeEmail).set({
  //       "E-mail": email.trim(),
  //       "Password": password.trim(),
  //       "role": "owner", // ✅ Save role
  //     });

  //     // Save role locally
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString("role", "owner");

  //     Utils().toast("Signup Successful");

  //     // Navigate to login screen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => login_as_owner()),
  //     );

  //     // Clear fields
  //     emailcontroller.clear();
  //     passwordcontroller.clear();
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
        backgroundColor: Color.fromARGB(255, 82, 80, 80),
        foregroundColor: Colors.white,
        title: Text("SignUp As Owner", style: TextStyle(fontSize: 25)),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://img.freepik.com/free-photo/fresh-herbs-spices_23-2151950774.jpg?ga=GA1.1.2132475854.1710943859&semt=ais_keywords_boost",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: signupcontroller.emailcontroller.value,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      label: Text("E-mail", style: TextStyle(color: Colors.white)),
                      hintText: "Enter Your E-mail",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.white),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: signupcontroller.passwordcontroller.value,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      label: Text("Password", style: TextStyle(color: Colors.white)),
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(Icons.password, color: Colors.white),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                ),
                buttonFun(
                  butname: "Submit",
                  loading: loading,
                  onpresse: () {
                    signupcontroller.signup_owner();
                    Get.to(login_as_owner());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
