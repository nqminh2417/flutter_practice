import 'package:flutter/material.dart';

import '../models/menu_item.dart';

/// The MenuProvider class is a ChangeNotifier that manages a list of MenuItem objects and notifies
/// listeners when the list is updated.
class MenuProvider extends ChangeNotifier {
  List<MenuItem> _menuItems = [];

  List<MenuItem> get menuItems => _menuItems;

  /// This function sets the menu items and notifies listeners.
  ///
  /// Args:
  ///   items (List<MenuItem>): items is a List of MenuItem objects that will be used to set the
  /// _menuItems variable. The notifyListeners() method is called after setting the _menuItems variable
  /// to notify any listeners that the state of the object has changed.
  void setMenuItems(List<MenuItem> items) {
    _menuItems = items;
    notifyListeners();
  }
}
