import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mongodb_app/constant/colors.dart';
import 'package:mongodb_app/functions/functions_helper.dart';
import 'package:mongodb_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController addressnameController = TextEditingController();
  TextEditingController addressDetailsController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  FocusNode focus3 = FocusNode();
  FocusNode focus4 = FocusNode();
  bool loading = false;
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
          "Add Address",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Text(
                "Address Name",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[200],
                ),
              ),
              TextFormField(
                focusNode: focus1,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (final text) {
                  focus2.requestFocus();
                },
                onTapOutside: (event) {
                  focus1.unfocus();
                },
                controller: addressnameController,
                textAlign: TextAlign.left,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (final String? text) => text!.isNotEmpty
                    ? null
                    : "Hold up. this field is required.",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "add address name",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Address Details",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[200],
                ),
              ),
              TextFormField(
                focusNode: focus2,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (final text) {
                  focus3.requestFocus();
                },
                onTapOutside: (event) {
                  focus2.unfocus();
                },
                controller: addressDetailsController,
                textAlign: TextAlign.left,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (final String? text) => text!.isNotEmpty
                    ? null
                    : "Hold up. this field is required.",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "add address details",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "City",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[200],
                ),
              ),
              TextFormField(
                focusNode: focus3,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (final text) {
                  focus4.requestFocus();
                },
                onTapOutside: (event) {
                  focus3.unfocus();
                },
                controller: cityController,
                textAlign: TextAlign.left,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (final String? text) => text!.isNotEmpty
                    ? null
                    : "Hold up. this field is required.",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "add city",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Phone Number",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[200],
                ),
              ),
              TextFormField(
                focusNode: focus4,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (final text) {
                  focus4.unfocus();
                },
                onTapOutside: (event) {
                  focus4.unfocus();
                },
                controller: phoneNumberController,
                textAlign: TextAlign.left,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (final String? text) => text!.isNotEmpty
                    ? null
                    : "Hold up. this field is required.",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "add phone number",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      if (!loading) {
                        setState(() {
                          loading = true;
                        });
                        await userProvider.addAddress(
                          addressDetails: addressDetailsController.text,
                          addressName: addressnameController.text,
                          city: cityController.text,
                          phoneNumber: phoneNumberController.text,
                        );
                        if (userProvider.success) {
// ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        } else {
                          displayErrorMotionToast(
                            // ignore: use_build_context_synchronously
                            context,
                            title: "Error add address",
                            description: "Please check the requireds",
                          );
                        }
                        setState(() {
                          loading = false;
                        });
                      }
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 170,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 255, 230, 0),
                          Color.fromRGBO(187, 150, 0, 1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: mainYellow,
                    ),
                    child: loading
                        ? const Center(
                            child: SpinKitPulse(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 25,
                              letterSpacing: 0.5,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
