import 'package:flutter/material.dart';
import 'package:mongodb_app/constant/colors.dart';
import 'package:motion_toast/motion_toast.dart';

void displayErrorMotionToast(BuildContext context,
    {required String title, required String description}) {
  MotionToast(
    icon: Icons.error,
    secondaryColor: Colors.white,
    primaryColor: Colors.red,
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    description: Text(
      description,
      style: const TextStyle(
        color: Colors.white, // Change the color here
      ),
    ),
    position: MotionToastPosition.bottom,
    width: 350,
    height: 80,
    dismissable: false,
  ).show(context);
}

Future<void> showCustomDialog(
  BuildContext context, {
  String title = "",
  String description = "",
  String yesButtonText = "",
  String noButtonText = "",
  required VoidCallback onYesPressed,
  required VoidCallback onNoPressed,
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          description,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w300,
            color: Colors.black87,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onNoPressed,
            child: Text(
              noButtonText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: onYesPressed,
            child: Text(
              yesButtonText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: mainYellow,
              ),
            ),
          ),
        ],
      );
    },
  );
}

displaySuccessMotionToast(
    {required BuildContext context, required String title}) {
  MotionToast toast = MotionToast(
    primaryColor: Colors.green,
    description: Center(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    dismissable: true,
    displaySideBar: false,
  );
  toast.show(context);
}
