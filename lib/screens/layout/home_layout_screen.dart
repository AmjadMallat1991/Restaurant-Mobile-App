import 'package:flutter/material.dart';
import 'package:mongodb_app/provider/app_provider.dart';
import 'package:mongodb_app/provider/user_provider.dart';
import 'package:mongodb_app/screens/layout/cart_screen.dart';
import 'package:mongodb_app/screens/layout/favorite_screen.dart';
import 'package:mongodb_app/screens/layout/home_screen.dart';
import 'package:mongodb_app/screens/authentication/main_account_screen.dart';
import 'package:mongodb_app/screens/layout/user_account_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HomeLayoutScreen extends StatefulWidget {
  HomeLayoutScreen({super.key, required this.index});
  int index;
  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  getData() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    final app = Provider.of<AppProvider>(context, listen: false);

    final preferences = await SharedPreferences.getInstance();
    if (preferences.getBool("logged") ?? false) {
      user.status = UserStatus.logIn;
      user.email.text = preferences.getString("email")!;
      user.firstName.text = preferences.getString("first_name")!;
      user.lastName.text = preferences.getString("last_name")!;
      user.getfavorites();
      user.getAddresses();
      app.getCart();
    } else {
      user.status = UserStatus.guest;
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final List<Widget> screens = [
      const HomeScreen(),
      const FavoritesScreen(),
      const CartScreen(),
      userProvider.status == UserStatus.guest
          ? const MainAccountScreen()
          : const UserAccountScreen(),
    ];
    return Scaffold(
      body: screens[widget.index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.black,
          indicatorColor: Colors.white,
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Colors.black);
            }
            return const IconThemeData(color: Colors.white);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(color: Colors.white);
            }
            return const TextStyle(color: Colors.white);
          }),
        ),
        child: NavigationBar(
          height: 65,
          labelBehavior: labelBehavior,
          selectedIndex: widget.index,
          onDestinationSelected: (int index) {
            setState(() {
              widget.index = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.restaurant),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline_outlined),
              label: 'Favorite',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
