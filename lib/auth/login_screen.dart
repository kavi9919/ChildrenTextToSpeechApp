import 'dart:developer';
import 'package:child_auth/auth/auth_service.dart';
import 'package:child_auth/auth/signup_screen.dart';
import 'package:child_auth/ui/homepage.dart';
import 'package:child_auth/widgets/button.dart';
import 'package:child_auth/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isLandscape = screenWidth > screenHeight;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isLandscape ? screenWidth * 0.5 : screenWidth,
                maxHeight: isLandscape ? screenHeight * 0.8 : screenHeight,
              ),
              child: Column(
                children: [
                  const Spacer(),
                  const Text(
                    "EduAut",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipOval(
                        child: Container(
                          width: 250.0,
                          height: 250.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            "assets/main.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hint: "Enter Email",
                    label: "Email",
                    controller: _email,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hint: "Enter Password",
                    label: "Password",
                    isPassword: true,
                    controller: _password,
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    label: "Login",
                    onPressed: _login,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      InkWell(
                        onTap: () => goToSignup(context),
                        child: const Text(
                          "Signup",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void goToSignup(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );

  void goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );

  Future<void> _login() async {
    final user =
        await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {
      log("User Logged In");
      goToHome(context);
    }
  }
}
