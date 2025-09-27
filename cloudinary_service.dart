

// import 'dart:io';
// import 'package:http/http.dart'as http;
// import 'package:file_picker/file_picker.dart';

// Future<bool> uploadCloudinary(FilePickerResult ? filepickerresult)async{
//   if(filepickerresult == null || filepickerresult.files.isEmpty){
//     print("No file Selected");
//     return false;
//   }
//   File file = File(filepickerresult.files.single.path!);

//   var url = Uri.parse("https://api.cloudinary.com/v1_1/da6l0lc1r/image/upload");

//   var request = http.MultipartRequest("POST",url);
//   var fileBytes =  await file.readAsBytes();

//   var MultipartFile = http.MultipartFile.fromBytes('file', fileBytes, filename: file.path.split("/").last);

//   request.files.add(MultipartFile);

//   request.fields["upload_preset"] = "ttkogh0x";

//   request.fields["resource_type"] = "image";
//   var response = await request.send();

//   var responsebody = await response.stream.bytesToString();

//   print(responsebody);

//   if(response.statusCode == 200){
//     print("Upload Successful");
//     return true;
//   }else{
//     print("Error Occoured");
//     return false;
//   }
// }