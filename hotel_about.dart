import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class hotel_about extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return hotel_aboutstate();
  }
}

class hotel_aboutstate extends State<hotel_about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.09,
              width: double.infinity,
              child: Text(
                "Baba Sai Restaurant in Surat offers a variety of dining options, including Chinese and organic food, and is known for its vegetarian options. ",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.09,
              width: double.infinity,
            
              child: Text(
                " It's a family-friendly and group-friendly establishment with features like a fireplace, wheelchair accessibility, and a kids' menu.",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.09,
              width: double.infinity,
              child: Text(
                "There are multiple locations, including one on Varachha Road specializing in dosa and Chinese cuisine. ",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
