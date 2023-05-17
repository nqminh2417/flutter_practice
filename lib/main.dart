import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter_practice/utils/constants.dart';

import 'firebase_options.dart';
import 'providers/menu_provider.dart';
import 'screens/home_screen.dart';
import 'screens/lichcupdien_screen.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuProvider(), // Create an instance of MenuProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashScreen(),
          'home': (_) => const HomeScreen(),
          'lich_cup_dien': (_) => const LichCupDienScreen(),
          // ... other routes
        },
      ),
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