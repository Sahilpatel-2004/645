import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:resturent_app/view/User_data/show_iteam.dart';

class user_main_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return user_main_pagestate();
  }
}

class user_main_pagestate extends State<user_main_page> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref(
    "ResturentDetail",
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  bool loading = true;
  bool hasData = false;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;

    ref.once().then((DatabaseEvent event) {
      final data = event.snapshot.value as Map?;
      setState(() {
        hasData = data != null && data.isNotEmpty;
        loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(
                "assets/images/download (2).jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          loading
              ? Center(child: CircularProgressIndicator(color: Colors.black))
              : hasData
              ? Column(
                children: [
                  Expanded(
                    child: FirebaseAnimatedList(
                      query: ref,
                      itemBuilder: (context, snapshot, animation, index) {
                        final restaurantData = snapshot.value as Map?;

                        if (restaurantData == null ||
                            !restaurantData.containsKey("Resturent_Name")) {
                          return SizedBox(); 
                        }

                        final resturentName =
                            restaurantData["Resturent_Name"].toString();

                        return ListTile(
                          title: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => showiteam(
                                        resturentname: resturentName,
                                      ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.white,
                                ),
                              ),
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  resturentName.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
              : Center(
                child: Text(
                  "No restaurants available",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
        ],
      ),
    );
  }
}
