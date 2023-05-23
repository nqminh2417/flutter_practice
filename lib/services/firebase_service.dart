import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/menu_item.dart';


class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  static Future<List<MenuItem>> getSideMenuItems() async {
    QuerySnapshot querySnapshot = await _firestore.collection('side_menu_items').orderBy('orderId', descending: false).get();
    
    List<DocumentSnapshot> documentSnapshots = querySnapshot.docs;

    List<MenuItem> menuItems = documentSnapshots.map((doc) {
      return MenuItem(
        title: doc['title'],
        route: doc['route'],
        icon: doc['icon'],
      );
    }).toList();

    return menuItems;
  }

  static Future<List<MenuItem>> fetchMenuItems() async {
    QuerySnapshot snapshot = await _firestore.collection('side_menu_items').orderBy('orderId', descending: false).get();
    List<MenuItem> menuItems = snapshot.docs.map((doc) {
      // Perform mapping here to convert document data to MenuItem objects
      // Extract the necessary fields like title, route, and icon
      String title = doc['title'];
      String route = doc['route'];
      IconData icon = _mapIconData(doc['icon']);

      return MenuItem(
        title: title,
        route: route,
        icon: icon,
      );
    }).toList();

    return menuItems;
  }

  static IconData _mapIconData(String icon) {
    // Perform mapping from the icon string to the corresponding IconData
    // You can use a Map or switch statement to map the string to IconData
    // Example:
    switch (icon) {
      case 'home':
        return Icons.home;
      case 'calendar_month':
        return Icons.calendar_month;
      case 'settings':
        return Icons.settings;
      case 'person':
        return Icons.person;
      case 'logout':
        return Icons.logout;
      // Add more cases for different icons
      default:
        return Icons.help;
    }
  }
}