import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:resturent_app/utils/utils.dart';
import 'package:resturent_app/view/User_data/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return signupstate();
  }
}

class signupstate extends State<signup> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference database = FirebaseDatabase.instance.ref("User_Login");

  bool loading = false;

  final RegExp emailRegExp = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
);


  void issignup(String email, String password) async {
    setState(() {
      loading = true;
    });

    try {
    
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

     
      String safeEmail = email.trim().replaceAll('.', ',');

      await database.child(safeEmail).set({
        "Email": email.trim(),
        "Password": password.trim(),
        "role": "user",
      });

      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("role", "user");

      Utils().flushbar("Signup Successful");

      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => login()),
      );
    } catch (e) {
      Utils().flushbar_error(e.toString());
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 82, 80, 80),
        foregroundColor: Colors.white,
        title: Text("SignUp", style: TextStyle(fontSize: 25)),
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
                    controller: emailcontroller,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      }else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                        return "Please Enter the Vaild Emial";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: passwordcontroller,
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
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
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                     if (_formKey.currentState!.validate()) {
                      issignup(
                        emailcontroller.text,
                        passwordcontroller.text,
                      );
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
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 33, 33, 33),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(blurRadius: 25, color: Colors.white),
                        ],
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
