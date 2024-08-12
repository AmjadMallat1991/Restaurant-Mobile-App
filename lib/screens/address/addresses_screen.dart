import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mongodb_app/constant/colors.dart';
import 'package:mongodb_app/functions/functions_helper.dart';
import 'package:mongodb_app/provider/user_provider.dart';
import 'package:mongodb_app/screens/address/add_address_screen.dart';
import 'package:provider/provider.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  bool loading = false;

  Future<void> getAddresses() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    setState(() {
      loading = true;
    });
    await userProvider.getAddresses();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: const Text(
          "My Addresses",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 12,
            child: loading
                ? const Center(
                    child: SpinKitPulse(
                      color: Colors.white,
                    ),
                  )
                : userProvider.addressList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/empty_address.png",
                              width: 200,
                              height: 200,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "You haven't added\nany addresses yet",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: userProvider.addressList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.maxFinite,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 17,
                                vertical: 10,
                              ),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 238, 238, 238),
                                  width: 0.7,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          userProvider.addressList[index].city,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      userProvider.addressList[index].defaults
                                          ? const Expanded(
                                              flex: 2,
                                              child: Text(
                                                "Default",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Divider(
                                    thickness: 0.6,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Address Name: ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey[200],
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          userProvider
                                              .addressList[index].addressName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Address Details: ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey[200],
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          userProvider.addressList[index]
                                              .addressDetails,
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Phone Number: ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey[200],
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          userProvider
                                              .addressList[index].phoneNumber,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Divider(
                                    thickness: 0.6,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              await showCustomDialog(
                                                context,
                                                title: "Set Default Address",
                                                description:
                                                    "Are you sure you want to set this as the default address?",
                                                yesButtonText: "Yes",
                                                noButtonText: "No",
                                                onYesPressed: () async {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  await userProvider.setDefault(
                                                    addressId: userProvider
                                                        .addressList[index]
                                                        .addressId,
                                                  );
                                                  await getAddresses();
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                },
                                                onNoPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                              );
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              alignment: Alignment.center,
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Set Default",
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(
                                          thickness: 0.7,
                                          color: Colors.grey[200],
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              await showCustomDialog(
                                                context,
                                                title: "Delete Address",
                                                description:
                                                    "Are you sure you want to delete this address?",
                                                yesButtonText: "Yes",
                                                noButtonText: "No",
                                                onYesPressed: () async {
                                                  Navigator.of(context).pop();
                                                  await userProvider
                                                      .deleteAddress(
                                                    addressId: userProvider
                                                        .addressList[index]
                                                        .addressId,
                                                  );
                                                  if (userProvider.success) {
                                                    userProvider.addressList
                                                        .removeAt(index);
                                                  }
                                                  setState(() {});
                                                },
                                                onNoPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                              );
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              alignment: Alignment.center,
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Remove",
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
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
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddAddressScreen(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 45,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: mainYellow,
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Add New Address",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
