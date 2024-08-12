import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mongodb_app/constant/colors.dart';
import 'package:mongodb_app/provider/app_provider.dart';
import 'package:mongodb_app/screens/item_description_screen.dart';
import 'package:provider/provider.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen(
      {super.key, required this.categoryId, required this.categoryname});
  final String categoryId;
  final String categoryname;

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  bool loading = false;

  Future<void> getProductsById() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    setState(() {
      loading = true;
    });
    await appProvider.getProductsById(categoryId: widget.categoryId);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getProductsById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: Text(
          widget.categoryname,
          style: const TextStyle(
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
          : ListView.separated(
              itemCount: appProvider.products.length,
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
                          productId: appProvider.products[index].productId,
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
                                'http://localhost:8081${appProvider.products[index].image}',
                            placeholder: (context, url) => Image.asset(
                              "assets/images/burger.png",
                              width: 70,
                              height: 70,
                              color: Colors.grey,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/burger.png",
                              width: 70,
                              height: 70,
                              color: Colors.grey,
                            ),
                          ),
                          //  Image.network(
                          //   'http://localhost:8081${appProvider.products[index].image}',
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
                                appProvider.products[index].productName,
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
                                appProvider.products[index].productDescription,
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
                                appProvider.products[index].price,
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
