import 'package:child_auth/auth/auth_service.dart';
import 'package:child_auth/auth/login_screen.dart';
import 'package:child_auth/ui/homepage.dart';
import 'package:child_auth/widgets/button.dart';
import 'package:child_auth/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _age = TextEditingController();
  final _country = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _age.dispose();
    _country.dispose();
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
                    "Signup",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 50),
                  CustomTextField(
                    hint: "Enter Name",
                    label: "Name",
                    controller: _name,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hint: "Enter Age",
                    label: "Age",
                    controller: _age,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hint: "Enter Country",
                    label: "Country",
                    controller: _country,
                  ),
                  const SizedBox(height: 20),
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
                    label: "Signup",
                    onPressed: _signup,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      InkWell(
                        onTap: () => goToLogin(context),
                        child: const Text(
                          "Login",
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

  void goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

  void goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );

  Future<void> _signup() async {
    final user =
        await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      print("User Created Successfully");
      goToHome(context);
    }
  }
}
