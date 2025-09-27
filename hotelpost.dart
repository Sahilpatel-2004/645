import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resturent_app/function/buttonfunction.dart';
import 'package:resturent_app/utils/utils.dart';

class hotel_post extends StatefulWidget {
  final String resturentname;

  hotel_post({required this.resturentname});
  @override
  State<StatefulWidget> createState() {
    return hotel_pagestate();
  }
}

class hotel_pagestate extends State<hotel_post> {
  final iteam_name = TextEditingController();
  final iteam_dec = TextEditingController();
  final item_price = TextEditingController();
  final database = FirebaseFirestore.instance.collection("user-file");
  User? user = FirebaseAuth.instance.currentUser;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  bool loading = false;

  File? image;
  String? imageurl;
  final picker = ImagePicker();

  Future<void> getimage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedimage = await picker.pickImage(source: source);
    if (pickedimage != null) {
      setState(() {
        image = File(pickedimage.path);
      });
    } else {
      print("No Image Picked");
    }
  }

  Future<void> _uploadimage() async {
    if (image == null) {
      Utils().flushbar("Image is null. Please Pick an image first");
      return;
    }

    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/da6l0lc1r/image/upload",
    );
    final request =
        http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = "ttkogh0x"
          ..files.add(await http.MultipartFile.fromPath('file', image!.path));
    final response = await request.send();

    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      final data = jsonDecode(res.body);
      imageurl = data["secure_url"];
      Utils().flushbar("Upload Message: $imageurl");
    } else {
      Utils().flushbar("Image Upload Faild. State code:${response.statusCode}");
      imageurl = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset("assets/images/restaurant-interior.jpg",fit: BoxFit.cover,))),
           Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: InkWell(
                  onTap: () {
                    getimage(ImageSource.gallery);
                    // getimage(ImageSource.camera);
                  },
                  child:
                      image == null
                          ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border(
                                bottom: BorderSide(style: BorderStyle.solid),
                                left: BorderSide(style: BorderStyle.solid),
                                right: BorderSide(style: BorderStyle.solid),
                                top: BorderSide(style: BorderStyle.solid),
                              ),
                            ),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Center(
                              child: Text(
                                "Choose The Iteam",
                                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                          : Image.file(image!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  controller: iteam_name,
                  decoration: InputDecoration(
                    hintText: "Enter Iteam Name",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  controller: iteam_dec,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Enter Iteam Description",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  controller: item_price,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: "Enter Iteam Price",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              buttonFun(
                butname: "Submit",
                
                loading: loading,
                onpresse: () async {
                  setState(() {
                    loading = true;
                  });
                  await _uploadimage();
                  database
                      .doc(DateTime.now().millisecondsSinceEpoch.toString())
                      .set({
                        "Resturent": widget.resturentname,
                        "Iteam Name": iteam_name.text.toString(),
                        "Iteam Description": iteam_dec.text.toString(),
                        "Iteam Price": item_price.text.toString(),
                        "Image_Url": imageurl!,
                      })
                      .then((value) {
                        Utils().toast("Post Upload Successful");
                        setState(() {
                          loading = false;
                          image = null;
                          iteam_name.clear();
                          iteam_dec.clear();
                          item_price.clear();
                        });
                      })
                      .onError((error, StackTrace) {
                        Utils().toast_error(error.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                },
              ),
            ],
          ),
          ],
        ),
      ),
    );
  }
}
