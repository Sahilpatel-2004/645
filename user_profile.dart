import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:resturent_app/function/buttonfunction.dart';
import 'package:resturent_app/utils/utils.dart';

class user_profile extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return user_profilestate();
  }
}

class user_profilestate extends State<user_profile> {

  final NameController = TextEditingController();
  final AddressController = TextEditingController();
  final AgeController = TextEditingController();
  final PhoneNumber = TextEditingController();
  final citycontroller = TextEditingController();
  final database = FirebaseDatabase.instance.ref("UserDetail");
  final id = DateTime.now().millisecondsSinceEpoch.toString();
  bool loading = false;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  File? image;
  String? imageurl;
  final picker = ImagePicker();

  Future<void> getimage(ImageSource source)async{
    final ImagePicker picker = ImagePicker();
    final XFile? pickerimage = await picker.pickImage(source: source);
    if(pickerimage != null){
      setState(() {
        image = File(pickerimage.path);
      });
    }else{
      print("No Image Picked");
    }
  }

  Future uploadImage()async{
    if(image == null){
      Utils().toast("Image is Null. Please Choose Image");
      return ;
    }
    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/da6l0lc1r/image/upload"
    );
    final reqest = http.MultipartRequest('POST',url)
    ..fields['upload_preset'] = "ttkogh0x"
    ..files.add(await http.MultipartFile.fromPath('file',image!.path));
    final response = await reqest.send();

    if(response.statusCode == 200){
      final res = await http.Response.fromStream(response);
      final data = jsonDecode(res.body);
      imageurl = data['secure_url'];
    }else{
      Utils().toast("Image Upload Faild.state code is ${response.statusCode}");
      imageurl =null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User_Registration"),
        backgroundColor: Colors.grey[200],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.30,
            image: AssetImage("assets/images/user_and_owner_selection.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: InkWell(
                        onTap: (){
                          getimage(ImageSource.gallery);
                        },
                        child: image == null ? CircleAvatar(
                          maxRadius: 75,
                        ): Image.file(image!)
                      ),
                    ),
                    buildtextfiled(NameController, "Enter Your Name", "Name"),
                    buildtextfiled(AgeController, "Enter Your Age", "Age"),
                    buildtextfiled(PhoneNumber, "Enter Your Phone Number", "PhoneNumber"),
                    buildtextfiled(AddressController, "Enter Your Address", "Address"),
                    buildtextfiled(citycontroller, "Enter Your City Name", "City"),

                    buttonFun(butname: "Submit", onpresse: () async{
                      setState(() {
                        loading = true;
                      });
                      await uploadImage();
                      database.child(uid).set({
                        "User_Name":NameController.text.toString(),
                        "User_Age":AgeController.text.toString(),
                        "User_MobileNumber":PhoneNumber.text.toString(),
                        "User_Address":AddressController.text.toString(),
                        "User_City":citycontroller.text.toString(),
                        "Image Url": imageurl!,
                      }).then((value){
                        Utils().toast("Successful Register");
                        setState(() {
                          loading = false;
                        });
                        Navigator.pop(context); 

                      }).onError((error,StackTrace){
                        setState(() {
                          loading =false;
                        });
                        Utils().toast(error.toString());
                      });

                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildtextfiled(
    TextEditingController controller,
    String hintText,
    String labelText
  ) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          label: Text(labelText,style: TextStyle(fontWeight: FontWeight.bold),),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            ),
        ),
      ),
    );
  }
}
