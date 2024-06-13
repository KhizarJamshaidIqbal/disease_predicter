import 'dart:developer';
import 'package:disease_predictor/auth/auth_service.dart';
import 'package:disease_predictor/auth/login_screen.dart';
import 'package:disease_predictor/widgets/button.dart';
import 'package:disease_predictor/widgets/textfild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../Screens/Navigation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 60),
              const Text("Signup",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
              const SizedBox(height: 30),
              Center(child: Lottie.asset('assets/signUp.json', height: 300, width: 300)),
              const SizedBox(height: 50),
              CustomTextField(
                hint: "Enter Name",
                label: "Name",
                controller: _name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: "Enter Email",
                label: "Email",
                controller: _email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: "Enter Password",
                label: "Password",
                isPassword: true,
                controller: _password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: "Confirm Password",
                label: "Confirm Password",
                isPassword: true,
                controller: _confirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm Password is required';
                  }
                  if (value != _password.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  isLoading: _isLoading,
                  label: "Signup",
                  onPressed: _signup,
                ),
              ),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Already have an account? "),
                InkWell(
                  onTap: () => goToLogin(context),
                  child: const Text("Login", style: TextStyle(color: Colors.red)),
                )
              ]),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomBarCustom()),
      );

  void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  _signup() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // Set loading state to true when sign-up process begins
      });
      try {
        final user = await _auth.createUserWithEmailAndPassword(
            _name.text, _email.text, _password.text);
        if (user != null) {
          log("User Created Successfully");
          showSnackBar(context, "User Created Successfully", Colors.green);
          goToHome(context);
        } else {
          showSnackBar(context, "Sign up failed", Colors.red);
        }
      } catch (error) {
        if (error is FirebaseAuthException) {
          if (error.code == 'email-already-in-use') {
            // Handle the case where the email is already in use
            showSnackBar(context, "Email already in use", Colors.red);
          } else {
            // Handle other FirebaseAuth errors
            showSnackBar(context, "Sign up failed: ${error.message}", Colors.red);
          }
        } else {
          // Handle other errors
          showSnackBar(context, "Sign up failed", Colors.red);
        }
      } finally {
        setState(() {
          _isLoading = false; // Set loading state to false when sign-up process completes
        });
      }
    }
  }
}
