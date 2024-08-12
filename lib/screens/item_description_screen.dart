import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mongodb_app/constant/colors.dart';
import 'package:mongodb_app/functions/functions_helper.dart';
import 'package:mongodb_app/provider/app_provider.dart';
import 'package:mongodb_app/provider/user_provider.dart';
import 'package:mongodb_app/screens/layout/home_layout_screen.dart';
import 'package:provider/provider.dart';

class ItemdescriptionScreen extends StatefulWidget {
  const ItemdescriptionScreen({super.key, required this.productId});
  final String productId;

  @override
  State<ItemdescriptionScreen> createState() => _ItemdescriptionScreenState();
}

class _ItemdescriptionScreenState extends State<ItemdescriptionScreen> {
  bool loading = false;
  bool loadingbtn = false;

  Future<void> getProductsById() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    setState(() {
      loading = true;
    });
    await appProvider.getProductDetails(productId: widget.productId);
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
    final userprovider = Provider.of<UserProvider>(context, listen: true);

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
                onPressed: () async {
                  if (userprovider.status == UserStatus.logIn) {
                    await userprovider.updateFavorite(
                      productId: widget.productId,
                    );
                    if (userprovider.success) {
                      if (userprovider.statusFav == 'add') {
                        userprovider.favoritesList
                            .add(appProvider.productModel);
                      } else if (userprovider.statusFav == 'remove') {
                        userprovider.favoritesList.removeWhere(
                            (element) => element.productId == widget.productId);
                      }
                    }
                    setState(() {});
                  } else {
                    Navigator.pushAndRemoveUntil(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (final BuildContext context) =>
                            HomeLayoutScreen(
                          index: 3,
                        ),
                      ),
                      (final route) => false,
                    );
                  }
                },
                icon: Icon(
                  userprovider.favoritesList.any(
                          (element) => element.productId == widget.productId)
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: userprovider.favoritesList.any(
                          (element) => element.productId == widget.productId)
                      ? Colors.red
                      : Colors.white,
                  size: 35,
                )),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 12,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 50,
                          child: Container(
                            height: 200,
                            width: 200,
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              "assets/images/smoke.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(35),
                          width: double.maxFinite,
                          height: 300,
                          child: CachedNetworkImage(
                            imageUrl:
                                'http://localhost:8081${appProvider.productModel.image}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Image.asset(
                              "assets/images/burger.png",
                              width: 100,
                              height: 100,
                              color: Colors.grey,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/burger.png",
                              width: 100,
                              height: 100,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      appProvider.productModel.productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      appProvider.productModel.productDescription,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      appProvider.productModel.price,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 25,
                        color: mainYellow,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Ingredients in the ${appProvider.productModel.productName}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 200,
                      width: double.maxFinite,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: appProvider.productModel.ingredients.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 180,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'http://localhost:8081${appProvider.productModel.ingredients[index].ingredientImage}',
                                      // fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Image.asset(
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
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    appProvider.productModel.ingredients[index]
                                        .ingredientName,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () async {
                if (userprovider.status == UserStatus.logIn) {
                  setState(() {
                    loadingbtn = true;
                  });
                  await appProvider.addToCart(
                    productId: widget.productId,
                    quantity: 1,
                  );

                  setState(() {
                    loadingbtn = false;
                  });
                  if (appProvider.success) {
                    displaySuccessMotionToast(
                      // ignore: use_build_context_synchronously
                      context: context, title: "Product added to cart",
                    );
                  }
                } else {
                  // displayErrorMotionToast(
                  //   // ignore: use_build_context_synchronously
                  //   context,
                  //   title: "Error Sign In",
                  //   description: "Please Sign In before add to cart",
                  // );
                  Navigator.pushAndRemoveUntil(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (final BuildContext context) => HomeLayoutScreen(
                        index: 3,
                      ),
                    ),
                    (final route) => false,
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 45,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 255, 230, 0),
                      Color.fromRGBO(187, 150, 0, 1),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                      color: const Color.fromARGB(255, 253, 215, 48)
                          .withOpacity(.6),
                    )
                  ],
                  borderRadius: BorderRadius.circular(30),
                  color: mainYellow,
                ),
                alignment: Alignment.center,
                child: loadingbtn
                    ? const Center(
                        child: SpinKitPulse(
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/cart.png",
                            color: Colors.white,
                            height: 60,
                            width: 60,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Add to cart",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
