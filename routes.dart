// import 'package:flutter/material.dart';
// import 'package:resturent_app/user_owner_selection.dart';
// import 'package:resturent_app/utils/routes/routes_name.dart';
// import 'package:resturent_app/view/hotel_owner/login_owner.dart';
// import 'package:resturent_app/view/hotel_owner/signup_owner.dart';
// import 'package:resturent_app/view/hotel_page/hotel_about.dart';
// import 'package:resturent_app/view/hotel_page/hotel_record.dart';
// import 'package:resturent_app/view/User_data/login_user.dart';
// import 'package:resturent_app/view/User_data/signup_user.dart';
// import 'package:resturent_app/view/User_data/user_hotel_main_page.dart';

// class Routes{

//   static Route<dynamic> generateRoutes(RouteSettings setting){

//     switch(setting.name){
//       case RoutesName.login:
//       return MaterialPageRoute(builder: (BuildContext context)=>login());

//       case RoutesName.login_as_owner:
//       return MaterialPageRoute(builder: (BuildContext context)=>login_as_owner());

//       case RoutesName.signup:
//       return MaterialPageRoute(builder: (BuildContext context)=>signup());

//       case RoutesName.signup_as_owner:
//       return MaterialPageRoute(builder: (BuildContext context)=>signup_as_owner());

     

//       case RoutesName.hotel_about:
//       return MaterialPageRoute(builder: (BuildContext context)=>hotel_about());

//       case RoutesName.hotel_record:
//       return MaterialPageRoute(builder: (BuildContext context)=>hotel_record());

//       case RoutesName. user_main_page:
//       return MaterialPageRoute(builder: (BuildContext context)=> user_main_page());

//       default :
//       return MaterialPageRoute(builder: (_)=>
//       Scaffold(
//         body: Center(
//           child: Text("No Routes Define"),
//         ),
//       )
//       );
//     }

//   }
// }