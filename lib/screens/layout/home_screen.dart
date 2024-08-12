import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mongodb_app/provider/app_provider.dart';
import 'package:mongodb_app/screens/items_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;

  Future<void> getCategories() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    setState(() {
      loading = true;
    });
    await appProvider.getCategories();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(2),
              child: Image.asset(
                "assets/images/menu.png",
                color: Colors.white,
              ),
            ),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions: [
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "assets/images/shopping-bag.png",
                color: Colors.white,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
      body: loading
          ? const Center(
              child: SpinKitPulse(
                color: Colors.white,
                size: 70,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Every Bite a",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Text(
                    "Better burger!",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: appProvider.categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 200,
                        childAspectRatio: 1 / 2,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemsScreen(
                                  categoryId:
                                      appProvider.categories[index].categoryId,
                                  categoryname: appProvider
                                      .categories[index].categoryName,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(7),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'http://localhost:8081${appProvider.categories[index].categoryImage}',
                                    placeholder: (context, url) => Image.asset(
                                      "assets/images/burger.png",
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      "assets/images/burger.png",
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    appProvider.categories[index].categoryName,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
