import 'package:cloud_firestore/cloud_firestore.dart';

// class FirebaseService {
  // static Future getMenuItems() {
  //   final docMenuItems = FirebaseFirestore.instance.collection('side_menu_items');
  // }
// }

class FirebaseService {

  static Future<List<DocumentSnapshot>> getMenuItems() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('side_menu_items').orderBy('orderId', descending: false).get();
    return querySnapshot.docs;
  }
}