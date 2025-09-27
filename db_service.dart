// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class DbService {
//   User? user = FirebaseAuth.instance.currentUser;

//   Future<void> saveuploadfile(Map<String, String> data) async {
//     return FirebaseFirestore.instance
//         .collection("user-file")
//         .doc(user!.uid)
//         .collection("upload")
//         .doc()
//         .set(data);
//   }

//   Stream<QuerySnapshot> readUploadFiles() {
//     return FirebaseFirestore.instance
//         .collection("user-file")
//         .doc(user!.uid)
//         .collection("upload")
//         .snapshots();
//   }
// }
