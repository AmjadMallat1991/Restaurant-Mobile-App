import 'package:flutter/material.dart';
import 'package:mongodb_app/constant/colors.dart';
import 'package:mongodb_app/screens/authentication/sign_in_screen.dart';
import 'package:mongodb_app/screens/authentication/sign_up_screen.dart';

class MainAccountScreen extends StatefulWidget {
  const MainAccountScreen({super.key});

  @override
  State<MainAccountScreen> createState() => _MainAccountScreenState();
}

class _MainAccountScreenState extends State<MainAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Image.asset(
              "assets/images/Burger Day.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 270,
            right: 50,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 170,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: mainYellow,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            right: 50,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 170,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: mainYellow,
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
