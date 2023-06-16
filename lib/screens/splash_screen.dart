import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/menu_item.dart';
import '../providers/menu_provider.dart';
import '../services/firebase_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late List<MenuItem> menuItems = [];

  @override
  void initState() {
    super.initState();
    fetchMenuItems();

    // Initialize the animation controller
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));

    // Define the fade-in animation
    _fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);

    // Define the slide-up animation
    _slideAnimation = Tween<double>(begin: 0, end: -0.2).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    // Start the animation
    _animationController.forward();

    // Navigate to the home screen after 1.5 seconds
    Timer(const Duration(seconds: 3), () => _navigateToLoginScreen());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> fetchMenuItems() async {
    try {
      // Fetch menu items from Firebase
      final fetchedMenuItems = await FirebaseService.fetchMenuItems();
      setState(() {
        menuItems = fetchedMenuItems;
        // Store the menu items in a shared location
        // For example, using provider package:
        Provider.of<MenuProvider>(context, listen: false)
            .setMenuItems(menuItems);
      });
    } catch (error) {
      // Handle error
    }
  }

  void _navigateToLoginScreen() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      // User is already authenticated
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // User is not authenticated
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/images/bg2.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),

          // Logo and text
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation
                  .drive(Tween(begin: Offset.zero, end: const Offset(0, -0.2))),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.jpg',
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'My App',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
