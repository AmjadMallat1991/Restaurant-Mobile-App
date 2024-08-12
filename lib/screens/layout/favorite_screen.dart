import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mongodb_app/constant/colors.dart';
import 'package:mongodb_app/provider/user_provider.dart';
import 'package:mongodb_app/screens/item_description_screen.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool loading = false;

  // Future<void> getFavorites() async {
  //   final provider = Provider.of<UserProvider>(context, listen: false);

  //   setState(() {
  //     loading = true;
  //   });
  //   await provider.getfavorites();
  //   setState(() {
  //     loading = false;
  //   });
  // }

  // @override
  // void initState() {
  //   getFavorites();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: const Text(
          "Favorites",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: loading
          ? const Center(
              child: SpinKitPulse(
                color: Colors.white,
                size: 70,
              ),
            )
          : userProvider.favoritesList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/wishlist_dark.png"),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "No Favorites",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "You can add an item to your\nfavorites by click 'Favorite Icon'",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  itemCount: userProvider.favoritesList.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemdescriptionScreen(
                              productId:
                                  userProvider.favoritesList[index].productId,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 120,
                        width: double.maxFinite,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CachedNetworkImage(
                                imageUrl:
                                    'http://localhost:8081${userProvider.favoritesList[index].image}',
                                placeholder: (context, url) => Image.asset(
                                  "assets/images/burger.png",
                                  width: 70,
                                  height: 70,
                                  color: Colors.grey,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/burger.png",
                                  width: 70,
                                  height: 70,
                                  color: Colors.grey,
                                ),
                              ),
                              //  Image.network(
                              //   'http://localhost:8081${userProvider.favoritesList[index].image}',
                              //   // fit: BoxFit.cover,
                              // ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userProvider
                                        .favoritesList[index].productName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    userProvider.favoritesList[index]
                                        .productDescription,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    userProvider.favoritesList[index].price,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: mainYellow,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
