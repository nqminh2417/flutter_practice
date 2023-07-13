import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/models/youtube_channel.dart';

import '../models/menu_item.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final User? _user = FirebaseAuth.instance.currentUser;

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

  static Future<List<YoutubeChannel>> getYtChannels() async {
    if (_user == null) {
      return [];
    }

    String uid = _user!.uid;
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('youtube_channels')
        .get();

    List<YoutubeChannel> channelList = snapshot.docs.map((doc) {
      String channelId = doc['channelId'];
      String title = doc['title'];
      bool isBlocked = doc['isBlocked'];

      return YoutubeChannel(
          channelId: channelId, title: title, isBlocked: isBlocked);
    }).toList();

    return channelList;
  }

  static Future<void> addYtChannel(YoutubeChannel channel) async {
    try {
      await _firestore
          .collection('users')
          .doc(_user!.uid)
          .collection('youtube_channels')
          .add({
        'channelId': channel.channelId,
        'title': channel.title,
        'isBlocked': channel.isBlocked
      });
    } catch (e) {
      // handle exception
    }
  }

  static Future<void> updateChannel(YoutubeChannel channel) async {
    try {
      await _firestore
          .collection('users')
          .doc(_user!.uid)
          .collection('youtube_channels')
          .doc(channel.channelId)
          .update({'isBlocked': channel.isBlocked});
    } catch (e) {
      // Handle exception
    }
  }
}
