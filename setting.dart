import 'package:flutter/material.dart';

class setting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return settingstate();
  }

}
class settingstate extends State<setting>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
    );
  }

}