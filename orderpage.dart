// import 'package:flutter/material.dart';

// class orderpage extends StatelessWidget{

//   final String image;
//   final String itemname;
//   final String itemprice;
//   final String itemtotal;
//   final String total;

//   orderpage({
//     required this.image,
//     required this.itemname,
//     required this.itemprice,
//     required this.itemtotal,
//     required this.total
//   });


//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: Text("Order"),
//         backgroundColor: Colors.black,
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: Colors.black,
//         child: Column(
//           children: [
//             Card(
//               child: ListTile(
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                 child: Image.network(image)),
//                 title: Text(itemname,),
//                 subtitle: Text(itemprice),
//                 trailing: Text(itemtotal),
//                 ),
//             ),
//              Divider(color: Colors.white24),
//              Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Total:$total")
//               ],
//              )
            
//           ],
//         ),
//       )
//     );
//   }

// }

    
