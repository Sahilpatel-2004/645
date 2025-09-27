
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  void flushbar(String message){
    Flushbar(
      title: message,
      messageColor: Colors.white,
      backgroundColor: Colors.black,
      duration: Duration(seconds: 10),
    );
  }

  void flushbar_error(String message){
    Flushbar(
      title: message,
      messageColor: Colors.white,
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    );
  }

  void toast_error(msg){
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
   void toast(msg){
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  }

}

