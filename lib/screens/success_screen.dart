import 'package:flutter/material.dart';
import 'package:mongodb_app/constant/colors.dart';
import 'package:mongodb_app/provider/app_provider.dart';
import 'package:mongodb_app/screens/layout/home_layout_screen.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/success_once.webp',
          ),
          const Text(
            'You have successfully\ncompleted your order!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              height: 1.3,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              appProvider.cartList.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return HomeLayoutScreen(index: 0);
                  },
                ),
                (Route<dynamic> bool) => false,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: mainYellow,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                'CONTINUE SHOPPING',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
