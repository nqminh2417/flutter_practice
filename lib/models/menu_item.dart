// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String route;
  final IconData? icon;

  MenuItem({
    required this.title,
    required this.route,
    required this.icon,
  });

  MenuItem copyWith({
    String? title,
    String? route,
    IconData? icon,
  }) {
    return MenuItem(
      title: title ?? this.title,
      route: route ?? this.route,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'route': route,
      'icon': icon?.codePoint,
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      title: map['title'] as String,
      route: map['route'] as String,
      icon: map['icon'] != null ? IconData(map['icon'] as int, fontFamily: 'MaterialIcons') : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuItem.fromJson(String source) => MenuItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MenuItem(title: $title, route: $route, icon: $icon)';

  @override
  bool operator ==(covariant MenuItem other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.route == route &&
      other.icon == icon;
  }

  @override
  int get hashCode => title.hashCode ^ route.hashCode ^ icon.hashCode;
}

// class MenuItem {
//   final String title;
//   final String route;
//   final IconData? iconData;

//   MenuItem({
//     required this.title,
//     required this.route,
//     required this.iconData,
//   });
// }
