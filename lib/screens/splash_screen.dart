import 'package:flutter/material.dart';
import 'package:mongodb_app/main.dart';
import 'package:mongodb_app/screens/layout/home_layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> appCheck() async {
    await api.fetchApiToken();
    await Future.delayed(const Duration(milliseconds: 3000));
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (final BuildContext context) => HomeLayoutScreen(
          index: 0,
        ),
      ),
      (final route) => false,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((final time) {
      appCheck();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Image.asset(
          "assets/images/splash_screen.jpeg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
