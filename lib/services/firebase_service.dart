import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/menu_item.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<MenuItem>> fetchMenuItems() async {
    QuerySnapshot snapshot = await _firestore
        .collection('side_menu_items')
        .orderBy('orderId', descending: false)
        .get();

    List<MenuItem> menuItems = snapshot.docs.map((doc) {
      // Perform mapping here to convert document data to MenuItem objects
      // Extract the necessary fields like title, route, and icon
      String description = doc['description'];
      String docId = doc['docId'];
      bool isParent = doc['isParent'];
      int orderId = doc['orderId'];
      String parentId = doc['parentId'];
      String route = doc['route'];
      String title = doc['title'];
      IconData icon = _mapIconData(doc['icon']);

      return MenuItem(
        description: description,
        docId: docId,
        isParent: isParent,
        orderId: orderId,
        parentId: parentId,
        title: title,
        route: route,
        icon: icon,
      );
    }).toList();

    // List<MenuItem> reorderedItems = [];
    // First way
    // Find the parent items and add them to the reordered list
    // for (MenuItem item in menuItems) {
    //   if (item.isParent) {
    //     reorderedItems.add(item);

    //     // Find the child items with matching parentId and add them to the reordered list
    //     List<MenuItem> childItems =
    //         menuItems.where((child) => child.parentId == item.docId).toList();
    //     childItems.sort((a, b) => a.orderId.compareTo(b.orderId));
    //     reorderedItems.addAll(childItems);
    //   }
    // }

    // Second way
    // Sort the items by parentId and orderId
    //     menuItems.sort((a, b) {
    //       // First, sort by parentId
    //       int parentComparison = a.parentId.compareTo(b.parentId);
    //       if (parentComparison != 0) {
    //         return parentComparison;
    //       }

    //       // If the parentId is the same, sort by orderId
    //       return a.orderId.compareTo(b.orderId);
    //     });

    // // Retrieve the parent items and add them to the reordered list
    //     for (MenuItem item in menuItems) {
    //       if (item.isParent) {
    //         reorderedItems.add(item);
    //         // Retrieve the child items with the same parentId and add them to the reordered list
    //         for (MenuItem childItem in menuItems) {
    //           if (!childItem.isParent && childItem.parentId == item.docId) {
    //             reorderedItems.add(childItem);
    //           }
    //         }
    //       }
    //     }

    // Print the reordered items
    // for (MenuItem item in reorderedItems) {
    //   print(
    //       'Title: ${item.title}, ParentId: ${item.parentId}, OrderId: ${item.orderId}');
    // }

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
