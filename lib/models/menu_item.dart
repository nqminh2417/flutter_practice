// ignore_for_file: public_member_api_docs, sort_constructors_first

// class MenuItem {
//   final String title;
//   final String route;
//   final IconData? icon;

//   MenuItem({
//     required this.title,
//     required this.route,
//     required this.icon,
//   });

//   MenuItem copyWith({
//     String? title,
//     String? route,
//     IconData? icon,
//   }) {
//     return MenuItem(
//       title: title ?? this.title,
//       route: route ?? this.route,
//       icon: icon ?? this.icon,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'title': title,
//       'route': route,
//       'icon': icon?.codePoint,
//     };
//   }

//   factory MenuItem.fromMap(Map<String, dynamic> map) {
//     return MenuItem(
//       title: map['title'] as String,
//       route: map['route'] as String,
//       icon: map['icon'] != null ? IconData(map['icon'] as int, fontFamily: 'MaterialIcons') : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory MenuItem.fromJson(String source) => MenuItem.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'MenuItem(title: $title, route: $route, icon: $icon)';

//   @override
//   bool operator ==(covariant MenuItem other) {
//     if (identical(this, other)) return true;

//     return
//       other.title == title &&
//       other.route == route &&
//       other.icon == icon;
//   }

//   @override
//   int get hashCode => title.hashCode ^ route.hashCode ^ icon.hashCode;
// }

import 'dart:convert';

import 'package:flutter/material.dart';

class MenuItem {
  final String description;
  final String docId;
  final IconData? icon;
  late final bool isParent;
  final int orderId;
  final String parentId;
  final String route;
  final String title;
  bool isExpanded;

  MenuItem({
    required this.description,
    required this.docId,
    required this.icon,
    required this.isParent,
    required this.orderId,
    required this.parentId,
    required this.route,
    required this.title,
    this.isExpanded = true,
  });

  MenuItem copyWith({
    String? description,
    String? docId,
    IconData? icon,
    bool? isParent,
    int? orderId,
    String? parentId,
    String? route,
    String? title,
  }) {
    return MenuItem(
      description: description ?? this.description,
      docId: docId ?? this.docId,
      icon: icon ?? this.icon,
      isParent: isParent ?? this.isParent,
      orderId: orderId ?? this.orderId,
      parentId: parentId ?? this.parentId,
      route: route ?? this.route,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'docId': docId,
      'icon': icon?.codePoint,
      'isParent': isParent,
      'orderId': orderId,
      'parentId': parentId,
      'route': route,
      'title': title,
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      description: map['description'] as String,
      docId: map['docId'] as String,
      icon: map['icon'] != null
          ? IconData(map['icon'] as int, fontFamily: 'MaterialIcons')
          : null,
      isParent: map['isParent'] as bool,
      orderId: map['orderId'] as int,
      parentId: map['parentId'] as String,
      route: map['route'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuItem.fromJson(String source) =>
      MenuItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MenuItem(description: $description, docId: $docId, icon: $icon, isParent: $isParent, orderId: $orderId, parentId: $parentId, route: $route, title: $title)';
  }

  @override
  bool operator ==(covariant MenuItem other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.docId == docId &&
        other.icon == icon &&
        other.isParent == isParent &&
        other.orderId == orderId &&
        other.parentId == parentId &&
        other.route == route &&
        other.title == title;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        docId.hashCode ^
        icon.hashCode ^
        isParent.hashCode ^
        orderId.hashCode ^
        parentId.hashCode ^
        route.hashCode ^
        title.hashCode;
  }
}

// class MenuItem {
//   final String description;
//   final String docId;
//   final IconData? icon;
//   final bool isParent;
//   final int orderId;
//   final String parentId;
//   final String route;
//   final String title;

//   MenuItem({
//     required this.description,
//     required this.docId,
//     required this.icon,
//     required this.isParent,
//     required this.orderId,
//     required this.parentId,
//     required this.route,
//     required this.title,
//   });
// }