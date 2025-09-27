import 'package:flutter/material.dart';

class buttonFun extends StatelessWidget{

  final String butname;
  final bool loading;
  final VoidCallback onpresse;

  buttonFun({
    required this.butname,
    required this.onpresse,
    this.loading = false

  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpresse,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.white
              ),
            ],
            
            color: Colors.black,
            borderRadius: BorderRadius.circular(15)
          ),
          height: MediaQuery.of(context).size.height*0.06,
          width: double.infinity,

          child: loading ? Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ) : Center(child: Text(butname,style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.03,color: Colors.lightBlueAccent[400]),))
        ),
      ),
    );

    
  }

 

}

    