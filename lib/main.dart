import 'package:flutter/material.dart';
import 'package:mongodb_app/dio_helper.dart';
import 'package:mongodb_app/provider/app_provider.dart';
import 'package:mongodb_app/provider/user_provider.dart';
import 'package:mongodb_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

ApiService api = ApiService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        tabBarTheme: const TabBarTheme(
          indicator: BoxDecoration(), // This removes the default underline
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
