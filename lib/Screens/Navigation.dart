import 'package:disease_predictor/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:disease_predictor/home_screen.dart';

import 'Predict_Screen.dart';
import 'Profile_screen.dart';

class BottomBarCustom extends StatefulWidget {
  static const title = 'salomon_bottom_bar';

  const BottomBarCustom({super.key});

  @override
  _BottomBarCustomState createState() => _BottomBarCustomState();
}

class _BottomBarCustomState extends State<BottomBarCustom> {
  var _currentIndex = 0;
  final listOfScreen = [
    const HomeScreen(),
    const PredictScreen(),
    const ProfileScreen(),
  ];
  final listOfAppBarTitle = ['Home', 'Predict Diseases', 'Profile'];
  late final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFFF9800),
        title: Text(listOfAppBarTitle[_currentIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
      body: listOfScreen[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i; // Fix: Assign i to _currentIndex
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: const Color(0xFFFF9800),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.stacked_bar_chart_outlined),
            title: const Text("Predict Diseases"),
            selectedColor: const Color(0xFFFF9800),
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: const Color(0xFFFF9800),
          ),
        ],
      ),
    );
  }
}
