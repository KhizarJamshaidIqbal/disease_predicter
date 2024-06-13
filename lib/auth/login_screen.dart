import 'dart:developer';

import 'package:disease_predictor/auth/auth_service.dart';
import 'package:disease_predictor/auth/forgot_password.dart';
import 'package:disease_predictor/auth/signup_screen.dart';
import 'package:disease_predictor/screens/navigation.dart';
import 'package:disease_predictor/widgets/button.dart';
import 'package:disease_predictor/widgets/textfild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
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
              const Text("Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
              const SizedBox(height: 30),
              Center(child: Lottie.asset('assets/login.json', height: 300, width: 300)),
              const SizedBox(height: 50),
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                hint: "Enter Email",
                label: "Email",
                controller: _email,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                hint: "Enter Password",
                label: "Password",
                controller: _password,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => goToForgotPassword(context),
                  child: const Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  isLoading: _isLoading,
                  label: "Login",
                  onPressed: _login,
                ),
              ),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Don't have an account? "),
                InkWell(
                  onTap: () => goToSignup(context),
                  child: const Text("Signup", style: TextStyle(color: Colors.red)),
                )
              ]),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignupScreen()),
  );

  goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BottomBarCustom()),
  );

  goToForgotPassword(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
  );

  void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = await _auth.loginUserWithEmailAndPassword(
            _email.text, _password.text);

        if (user != null) {
          log("User Logged In");
          showSnackBar(context, "Login Successful", Colors.green);
          goToHome(context);
        } else {
          showSnackBar(context, "Login Failed", Colors.red);
        }
      } catch (error) {
        showSnackBar(context, "Login Failed: ${error.toString()}", Colors.red);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
