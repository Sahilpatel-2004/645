import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resturent_app/function/buttonfunction.dart';
import 'package:resturent_app/utils/utils.dart';
import 'package:resturent_app/view/hotel_page/hotel_mainpage.dart';

class hotel_detail extends StatefulWidget {
  final String email;

  hotel_detail({required this.email});

  @override
  State<StatefulWidget> createState() {
    return hotel_detailstate();
  }
}

class hotel_detailstate extends State<hotel_detail> {
  final resturantcontroller = TextEditingController();
  final resturentownernamecontroller = TextEditingController();
  final opentimecontroller = TextEditingController();
  final closetimecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final locationcontroller = TextEditingController();
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
      print("No image picked");
    }
  }

  Future<void> _uploadimage() async {
    if (image == null) {
      print("Image is null. Please pick an image first.");
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
      print("Upload success: $imageurl");
    } else {
      print("Image upload failed. Status code: ${response.statusCode}");
    }
  }

  Future<void> photo() async {
    await _uploadimage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade200,
        title: Center(
          child: Text(
            "hotel_detail",
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.green.shade300, Colors.yellow.shade300],
              ),
            ),

            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    getimage(ImageSource.gallery);
                  },
                  child:
                      image == null
                          ? Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Icon(
                              Icons.person,
                              size: 90,
                              color: Colors.amber,
                            ),
                          )
                          : Image.file(image!),
                ),
                _buildTextField(
                  resturantcontroller,
                  "Enter Restaurant Name",
                  "Restaurant Name",
                ),
                _buildTextField(
                  resturentownernamecontroller,
                  "Enter Owner Name",
                  "Owner Name",
                ),
                _buildTextField(
                  phonecontroller,
                  "Enter Phone Number",
                  "Phone Number",
                ),
                _buildTextField(
                  opentimecontroller,
                  "Enter Open Time",
                  "Open Time",
                ),
                _buildTextField(
                  closetimecontroller,
                  "Enter Close Time",
                  "Close Time",
                ),
                _buildTextField(
                  locationcontroller,
                  "Enter Location",
                  "Location",
                ),
                buttonFun(
                  butname: "Submit",
                  loading: loading,
                  onpresse: () async {
                    setState(() {
                      loading = true;
                    });
                    await photo();
                    final uid = FirebaseAuth.instance.currentUser!.uid;
                    DatabaseReference database = FirebaseDatabase.instance.ref(
                      "ResturentDetail",
                    );
                    database
                        .child(widget.email.replaceAll('.', ','))
                        .set({
                          "UID": uid,
                          "Resturent_Name":
                              resturantcontroller.text.toString().toUpperCase(),
                          "Resturent_OwnerName":
                              resturentownernamecontroller.text
                                  .toString()
                                  .trim(),
                          "PhoneNumber": phonecontroller.text.toString().trim(),
                          "OpenTime": opentimecontroller.text.toString().trim(),
                          "CloseTime":
                              closetimecontroller.text.toString().trim(),
                          "Location": locationcontroller.text.toString().trim(),
                          "Image Url": imageurl.toString(),
                        })
                        .then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utils().flushbar("DataStore");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => hotelmainpage(
                                    hotelname:
                                        resturantcontroller.text.toString(),
                                    number: phonecontroller.text.toString(),
                                  ),
                            ),
                          );
                        })
                        .onError((error, StackTrace) {
                          print("$error");
                          Utils().toast(error.toString());
                          setState(() {
                            loading = false;
                          });
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          label: Text(labelText, style: TextStyle(color: Colors.black)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: BorderSide(),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}
