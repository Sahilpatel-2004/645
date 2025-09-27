import 'package:flutter/material.dart';
import 'package:resturent_app/view/User_data/user_profile.dart';

class user_setting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return user_settingstate();
  }

}
class user_settingstate extends State<user_setting>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Setting",style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildContainer("Change Profile",(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>user_profile()));
              }),
              buildContainer("Logout",(){
              
            }),
            buildContainer("App version Info",(){
             
            }),
              buildContainer("Rate App",(){
               
              }),
              buildContainer("Change Theme",(){
             
            }),
            buildContainer("Share App",(){
             
            }),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildContainer(String name,VoidCallback onpresse){
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: InkWell(
        onTap: onpresse,
        child: Container(
          height: MediaQuery.of(context).size.height*0.07,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                blurStyle: BlurStyle.outer,
                color: Colors.white
              )
            ],
            borderRadius: BorderRadius.circular(15),
            border: Border(
              bottom: BorderSide(
                style: BorderStyle.solid
              ),
              right: BorderSide(
                style: BorderStyle.solid
              ),
              left: BorderSide(
                style: BorderStyle.solid
              ),
              top: BorderSide(
                style: BorderStyle.solid
              ),
            )
          ),
          child: Center(child: Text(name,style: TextStyle(fontSize: 20,color: Colors.white),)),
        ),
      ),
    );
  }

}