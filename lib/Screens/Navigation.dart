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
    PredictScreen(),
    const ProfileScreen(),
  ];
  final listOfAppBarTitle = ['Home', 'Predict Diseases', 'Profile'];
  late final AuthService _auth;
  String _userName = '';
  String _userEmail = '';
  String _profileImageUrl = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _auth = AuthService();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      final userData = await _auth.getUserData(userId);
      if (userData != null) {
        setState(() {
          _userName = userData['name'] ?? '';
          _userEmail = userData['email'] ?? '';
          _profileImageUrl = userData['profileImageUrl'] ?? '';
          _isLoading = false;
        });
      }
    }
  }

  Widget createDrawerHeader() {
    return DrawerHeader(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.orange,
      ),
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(left: 10, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 38,
                        backgroundImage: _profileImageUrl.isNotEmpty
                            ? NetworkImage(_profileImageUrl)
                            : AssetImage('assets/default_profile.jpg'),
                        child: _profileImageUrl.isEmpty
                            ? Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    _userEmail,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFFF9800),
        title: Text(
          listOfAppBarTitle[_currentIndex],
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.orange, // Set the background color of the drawer
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              createDrawerHeader(),
              ListTile(
                leading: Icon(Icons.home,
                    color: Colors.white), // Set icon color to white
                title: Text('Home',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)), // Set text color to white
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.stacked_bar_chart_outlined,
                    color: Colors.white), // Set icon color to white
                title: Text('Predict Diseases',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)), // Set text color to white
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person,
                    color: Colors.white), // Set icon color to white
                title: Text('Profile',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)), // Set text color to white
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: listOfScreen[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
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
