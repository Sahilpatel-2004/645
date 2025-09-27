import 'package:flutter/material.dart';
import 'package:resturent_app/view/hotel_page/hotel_about.dart';
import 'package:resturent_app/view/hotel_page/hotel_homepage.dart';
import 'package:resturent_app/view/hotel_page/hotelpost.dart';
import 'package:resturent_app/view/hotel_popup_mennu.dart/account.dart';
import 'package:resturent_app/view/hotel_popup_mennu.dart/setting.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class hotelmainpage extends StatefulWidget {
  final String hotelname,number;

  hotelmainpage({required this.hotelname,required this.number});

  @override
  State<hotelmainpage> createState() => _hotelmainpageState();
}

class _hotelmainpageState extends State<hotelmainpage> {
  String iteam1 = "setting";
  String iteam2 = "Resturent Account";

  int selectedIndex = 0;

  late List<Widget> screen;

  @override
  void initState() {
    super.initState();
    screen = [
      hotelhomepage(hotelname: widget.hotelname,),
      hotel_post(resturentname: widget.hotelname),
      hotel_about(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 6, 6),
        title: Center(
          child: Text(
            "${widget.hotelname} Restuarant",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            color: Colors.black,
            onSelected: (value) {
              if (value == iteam1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => setting()),
                );
              } else if (value == iteam2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage(number: widget.number)),
                );
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    child: Text(
                      iteam1,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    value: iteam1,
                  ),
                  PopupMenuItem(
                    child: Text(
                      iteam2,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    value: iteam2,
                  ),
                ],
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: screen[selectedIndex],
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.black,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home_outlined),
          BarItem(
            filledIcon: Icons.add_box,
            outlinedIcon: Icons.add_box_outlined,
          ),
          BarItem(filledIcon: Icons.info, outlinedIcon: Icons.info_outline),
        ],
      ),
    );
  }
}
