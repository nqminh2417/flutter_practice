import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData.light().copyWith(
      // Add any additional properties or overrides here
      appBarTheme: const AppBarTheme(elevation: 0),
      listTileTheme: const ListTileThemeData(
          iconColor: Colors.black, textColor: Colors.black),
      // Other theme properties...
      );

  static final darkTheme = ThemeData.dark().copyWith(
    // Add any additional properties or overrides here
    appBarTheme: const AppBarTheme(elevation: 0),
    // Other theme properties...
  );

  static final dimTwitterTheme = ThemeData(
    // Add any additional properties or overrides here
    brightness: Brightness.dark,
    // primaryColor: const Color(0xff16202a),
    scaffoldBackgroundColor: const Color(0xff16202a),
    appBarTheme: const AppBarTheme(
      color: Color(0xff16202a),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white, // Set the desired color for icons
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xff16202a)),
    bottomSheetTheme: const BottomSheetThemeData(
      modalBackgroundColor: Color(0xff16202a),
    ),
    listTileTheme: const ListTileThemeData(
        iconColor: Colors.white, textColor: Colors.white),
    // Other theme properties...
  );

  static final nightTelegramTheme = ThemeData(
    // Add any additional properties or overrides here
    brightness: Brightness.dark,
    // primaryColor: const Color(0xff1c242f),
    scaffoldBackgroundColor: const Color(0xff1d2733),
    appBarTheme: const AppBarTheme(
      color: Color(0xff262e39),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white, // Set the desired color for icons
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xff1c242f)),
    bottomSheetTheme: const BottomSheetThemeData(
      modalBackgroundColor: Color(0xff1c242f),
    ),
    listTileTheme: const ListTileThemeData(
        iconColor: Colors.white, textColor: Colors.white),
    // Other theme properties...
  );
}
