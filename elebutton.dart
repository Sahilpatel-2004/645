import 'package:flutter/material.dart';

class Elevetionbutton extends StatelessWidget{
  final String name;
  final VoidCallback onPressed;
  final bool loading;

  Elevetionbutton({
    required this.name,
    this.loading = false,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:loading ? Center(child: CircularProgressIndicator()) : Center(
                child: Text(
                  "$name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            );
  }
  
}