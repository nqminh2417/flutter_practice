import 'package:flutter/material.dart';

import '../models/menu_item.dart';

/// The MenuProvider class is a ChangeNotifier that manages a list of MenuItem objects and notifies
/// listeners when the list is updated.
class MenuProvider extends ChangeNotifier {
  /// This function sets the menu items and notifies listeners of the change.
  ///
  /// Args:
  ///   items (List<MenuItem>): items is a List of MenuItem objects that will be used to update the
  /// _menuItems list.
  List<MenuItem> _menuItems = [];

  List<MenuItem> get menuItems => _menuItems;

  void setMenuItems(List<MenuItem> items) {
    _menuItems = items;
    notifyListeners();
  }
}
