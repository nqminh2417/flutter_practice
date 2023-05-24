import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/clock_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_practice/utils/constants.dart';

import 'firebase_options.dart';
import 'providers/menu_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/lichcupdien_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MenuProvider>(
        create: (_) => MenuProvider(),
      ),
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Access the MenuProvider instance
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: ThemeData(
        // Customize the AppBar theme
        appBarTheme: const AppBarTheme(
          elevation: 0, // Set elevation to 0 to remove the shadow
        ),
        // Set the app's theme mode based on the ThemeProvider's value
        brightness:
            themeProvider.isDarkModeOn ? Brightness.dark : Brightness.light,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        'clock': (context) => const ClockScreen(),
        'home': (context) => const HomeScreen(),
        'lich_cup_dien': (context) => const LichCupDienScreen(),
        'login': (context) => const LoginScreen(),
        'profile': (context) => const ProfileScreen(),
        'settings': (context) => const SettingsScreen(),
        // ... other routes
      },
    );
  }
}

// Form(child: Column(
//               children: [
//                 CustomTextFormField(hintText: 'Enter your email', icon: Icons.email, validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 }, controller: TextEditingController())
//               ],
//             ))
