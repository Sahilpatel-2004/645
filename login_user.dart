import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:resturent_app/view/User_data/signup_user.dart';
import 'package:resturent_app/view/User_data/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resturent_app/utils/utils.dart';

class login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return loginstate();
  }
}

class loginstate extends State<login> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference database = FirebaseDatabase.instance.ref("User_Login");
  UserCredential ?userCredential;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  void islogin(String email, String password) async {
    setState(() {
      loading = true;
    });

    try {
      // Firebase Authentication
       userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Replace '.' with ',' in email to match Realtime DB key
      String safeEmail = email.trim().replaceAll('.', ',');

      // Get user data from Realtime Database
      final userRef = database.child(safeEmail);
      final snapshot = await userRef.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        final role = data["role"];

        if (role == "user") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("role", "user");

          Utils().flushbar("Login Successful");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => user_profile()),
          );
        } else {
          await _auth.signOut();
          Utils().flushbar_error("This is not a user account. Please login as Owner.");
        }
      } else {
        await _auth.signOut();
        Utils().flushbar_error("No user data found in database.");
      }
    } catch (e) {
      Utils().flushbar_error(e.toString());
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login As User", style: TextStyle(color: Colors.white)),
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: emailcontroller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      label: Text("E-mail", style: TextStyle(color: Colors.white)),
                      hintText: "Enter Your E-mail",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
                    controller: passwordcontroller,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      label: Text("Password", style: TextStyle(color: Colors.white)),
                      hintText: "Enter Your Password",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      prefixIcon: Icon(Icons.password, color: Colors.white),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      islogin(emailcontroller.text, passwordcontroller.text);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: double.infinity,
                      child: Center(
                        child: loading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Login",
                                style: TextStyle(color: Colors.white, fontSize: 25),
                              ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(blurRadius: 25, color: Colors.white)],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: double.infinity,
                      child: Center(
                        child:Text(
                                "Signup",
                                style: TextStyle(color: Colors.white, fontSize: 25),
                              ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(blurRadius: 25, color: Colors.white)],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
