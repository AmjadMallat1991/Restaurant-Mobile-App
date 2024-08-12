import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mongodb_app/constant/colors.dart';
import 'package:mongodb_app/functions/functions_helper.dart';
import 'package:mongodb_app/provider/user_provider.dart';
import 'package:mongodb_app/screens/layout/home_layout_screen.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _focusNodes1 = FocusNode();
  final _focusNodes2 = FocusNode();
  final _focusNodes3 = FocusNode();
  final _focusNodes4 = FocusNode();
  final _focusNodes5 = FocusNode();
  bool loading = false;

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 0.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _focusNodes1,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (final text) {
                  _focusNodes2.requestFocus();
                },
                onTapOutside: (event) {
                  _focusNodes1.unfocus();
                },
                controller: userProvider.firstName,
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
                  hintText: "First Name",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _focusNodes2,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (final text) {
                  _focusNodes3.requestFocus();
                },
                onTapOutside: (event) {
                  _focusNodes2.unfocus();
                },
                controller: userProvider.lastName,
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
                  hintText: "Last Name",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _focusNodes3,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (final text) {
                  _focusNodes4.requestFocus();
                },
                onTapOutside: (event) {
                  _focusNodes3.unfocus();
                },
                controller: userProvider.email,
                textAlign: TextAlign.left,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? text) {
                  if (text == null) {
                    return "Please enter a valid email";
                  }
                  text = text.trim();

                  return RegExp(
                    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                  ).hasMatch(text)
                      ? null
                      : "Please enter a valid email";
                },
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
                  hintText: "Email",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _focusNodes4,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (final text) {
                  _focusNodes5.requestFocus();
                },
                onTapOutside: (event) {
                  _focusNodes4.unfocus();
                },
                controller: userProvider.password,
                textAlign: TextAlign.left,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (final String? text) {
                  if (text!.isEmpty) {
                    return "That field is required ";
                  } else if (text.length < 6) {
                    return "6 characters at least is required ";
                  } else {
                    return null;
                  }
                },
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
                  hintText: "Password",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _focusNodes5,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (final text) {
                  _focusNodes5.unfocus();
                },
                onTapOutside: (event) {
                  _focusNodes5.unfocus();
                },
                controller: userProvider.confirmPassword,
                textAlign: TextAlign.left,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (final String? text) {
                  if (text!.isEmpty) {
                    return "That field is required ";
                  } else if (text != userProvider.confirmPassword.text) {
                    return "PPassword mismatch";
                  } else {
                    return null;
                  }
                },
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
                  hintText: "Confirm Password",
                ),
              ),
              const SizedBox(
                height: 40,
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

                        if (await userProvider.signup()) {
                          Navigator.pushAndRemoveUntil(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomeLayoutScreen(index: 0),
                              ),
                              (route) => false);
                        } else {
                          // ignore: use_build_context_synchronously
                          displayErrorMotionToast(
                            context,
                            title: "Error Sign Up",
                            description: "User is Not Created",
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
                            "Sign Up",
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
