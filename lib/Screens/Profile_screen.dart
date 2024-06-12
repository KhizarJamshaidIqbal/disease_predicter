import 'dart:io';
import 'package:disease_predictor/auth/forgot_password.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final userData = await _firestore.collection('users').doc(userId).get();
      if (userData.exists) {
        return userData.data();
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    return;
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final picker = ImagePicker();
  late final AuthService _auth;
  late String _userName = '';
  late String _userEmail = '';
  late String _createdAt = '';
  late String _profileImageUrl = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _auth = AuthService();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        final userData = await _auth.getUserData(userId);
        if (userData != null) {
          setState(() {
            _userName = userData['name'] ?? '';
            _userEmail = userData['email'] ?? '';
            _profileImageUrl = userData['profileImageUrl'] ?? '';

            // Convert Timestamp to DateTime and format it
            final Timestamp timestamp = userData['createdAt'];
            final DateTime createdAtDateTime = timestamp.toDate();
            _createdAt = DateFormat('yyyy-MM-dd').format(createdAtDateTime);
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileName = 'profile_images/${_auth.currentUser!.uid}.jpg';
      final firebaseStorageRef =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      await firebaseStorageRef.putFile(file);
      final downloadUrl = await firebaseStorageRef.getDownloadURL();
      setState(() {
        _profileImageUrl = downloadUrl;
      });
      // Save the image URL to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({'profileImageUrl': downloadUrl});
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _profileImageUrl.isNotEmpty
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(_profileImageUrl),
                              )
                            : const CircleAvatar(
                                radius: 50,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                ),
                              ),
                        Positioned(
                          right: 0,
                          bottom: -10,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5, bottom: 5),
                              child: IconButton(
                                onPressed: _pickImage,
                                icon: const Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  _buildInfoCard(
                    icon: Icons.person,
                    label: 'Name:',
                    value: _userName,
                  ),
                  const SizedBox(height: 10),
                  _buildInfoCard(
                    icon: Icons.email,
                    label: 'Email:',
                    value: _userEmail,
                  ),
                  const SizedBox(height: 10),
                  _buildInfoCard(
                    icon: Icons.calendar_today,
                    label: 'Created At:',
                    value: _createdAt,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _resetPassword,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Reset Password',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.orange,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _resetPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
  }
}
