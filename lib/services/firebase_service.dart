import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {

  /// The function retrieves a list of document snapshots from a Firestore collection of side menu
  /// items, ordered by their order ID.
  /// 
  /// Returns:
  ///   The function `getMenuItems` returns a `Future` that resolves to a `List` of `DocumentSnapshot`
  /// objects. These `DocumentSnapshot` objects represent the documents retrieved from the Firestore
  /// collection "side_menu_items" and are ordered by the "orderId" field in ascending order.
  static Future<List<DocumentSnapshot>> getMenuItems() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('side_menu_items').orderBy('orderId', descending: false).get();
    return querySnapshot.docs;
  }
}