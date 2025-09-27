import 'package:flutter/material.dart';
import 'package:indicator_bottom_navigationbar/indicator_bottom_navigationbar.dart';
import 'package:resturent_app/view/User_data/show_user_profile.dart';
import 'package:resturent_app/view/User_data/user_hotel_main_page.dart';
import 'package:resturent_app/view/User_data/user_setting.dart';

class UserBottomnavigator extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return UserBottomnavigatorstate();
  }

}
class UserBottomnavigatorstate extends State<UserBottomnavigator>{

  int currentIndex = 0;

  static List<IconLabel> iconLabels=[
    IconLabel(Icons.restaurant_outlined, "Reastaurant Name"),
    IconLabel(Icons.person, "Profile"),
    IconLabel(Icons.person, "setting"),
  ];

  final List<Widget> screen = [
    user_main_page(),
    show_user_profile(),
    user_setting()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: IndicatorBottomNavigationbar(
        currentIndex: currentIndex, 
        onTap: (index){
          setState(() {
          currentIndex = index;
          });
        }, 
        iconLabels: iconLabels,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[700]!,
        backgroundColor: Colors.black,
        indicatorHeight: 2.5,
        indicatorWidth: 70,
      ),
      body: screen[currentIndex],
    );
  }

}