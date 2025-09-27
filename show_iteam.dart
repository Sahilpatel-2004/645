import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resturent_app/view/User_data/show_item_description.dart';

class showiteam extends StatefulWidget {
  final String resturentname;

  showiteam({required this.resturentname});

  @override
  State<StatefulWidget> createState() => showiteamstate();
}

class showiteamstate extends State<showiteam> {

  final CollectionReference ref = FirebaseFirestore.instance.collection("user-file");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.resturentname, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          
          Positioned.fill(
            child: Image.asset(
              'assets/images/download (2).jpg',
              fit: BoxFit.cover,
            ),
          ),

      
          StreamBuilder<QuerySnapshot>(
            stream: ref
                .where("Resturent", isEqualTo: widget.resturentname)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.amber),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "No items uploaded",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                );
              }

     
              final items = snapshot.data!.docs;

              return GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final data = items[index].data() as Map<String, dynamic>;

                  
                  final imageUrl = data["Image_Url"] ?? "";
                  final itemName = data["Iteam Name"] ?? "No Name";
                  final itemDesc = data["Iteam Description"] ?? "No Description";
                  final itemPrice = data["Iteam Price"] ?? "0";

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            tag: itemName,
                            imageUrl: imageUrl,
                            itemName: itemName,
                            itemDesc: itemDesc,
                            itemPrice: itemPrice,
                            resturentname: widget.resturentname,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              child: imageUrl.isNotEmpty
                                  ? Hero(
                                      tag: itemName,
                                      child: Image.network(
                                        imageUrl,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Center(
                                          child: Text("Image Error"),
                                        ),
                                      ),
                                    )
                                  : Center(child: Text("No Image")),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itemName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  itemDesc,
                                  style: TextStyle(fontSize: 13),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "₹$itemPrice",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
