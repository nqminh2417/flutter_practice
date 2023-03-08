import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/login_screen.dart';
import 'package:flutter_practice/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const LoginScreen(),
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