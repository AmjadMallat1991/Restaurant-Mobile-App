import 'package:flutter/material.dart';
import 'package:mongodb_app/models/address_model.dart';
import 'package:mongodb_app/models/product_model.dart';
import 'package:mongodb_app/models/user_model.dart';
import 'package:mongodb_app/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserStatus { guest, logIn }

class UserProvider with ChangeNotifier {
  UserStatus status = UserStatus.guest;
  UserServices services = UserServices();
  UserModel currentUser = UserModel();
  bool success = false;
  bool error = false;
  String statusFav = '';
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  List<AddressModel> addressList = [];
  List<ProductsModel> favoritesList = [];

  Future<bool> signup() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    currentUser = await services.signUp(
      firstName: firstName.text,
      lastName: lastName.text,
      email: email.text,
      password: password.text,
      confirmPassword: confirmPassword.text,
    );
    notifyListeners();
    if (currentUser.success) {
      preferences.setBool("logged", true);
      preferences.setString("email", currentUser.data!.email);
      preferences.setString("first_name", currentUser.data!.firstName);
      email.text = currentUser.data!.email;
      firstName.text = currentUser.data!.firstName;
      lastName.text = currentUser.data!.lastName;
      preferences.setBool("logged", true);

      status = UserStatus.logIn;
      success = true;
      return true;
    } else {
      success = false;
      return false;
    }
  }

  Future<bool> signIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    currentUser = await services.signIn(
      email: email.text.trim(),
      password: password.text,
    );

    if (currentUser.success) {
      preferences.setString("user_id", currentUser.data!.userId);
      preferences.setString("first_name", currentUser.data!.firstName);
      preferences.setString("last_name", currentUser.data!.lastName);
      preferences.setString("email", currentUser.data!.email);
      email.text = currentUser.data!.email;
      firstName.text = currentUser.data!.firstName;
      lastName.text = currentUser.data!.lastName;

      preferences.setBool("logged", true);
      status = UserStatus.logIn;
      Future.delayed(
        const Duration(milliseconds: 400),
        () {
          notifyListeners();
        },
      );
      return true;
    } else {
      error = true;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (await services.signOut()) {
      preferences.setBool("logged", false);
      preferences.remove("first_name");
      preferences.remove("last_name");
      preferences.remove("email");
      print(preferences.getBool("logged"));
      status = UserStatus.guest;
      email.text = '';
      firstName.text = '';
      lastName.text = '';
      password.text = '';
      confirmPassword.text = '';

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<String> getAddresses() async {
    String message = '';
    addressList = [];
    try {
      Map<String, dynamic> response = await services.getAddresses();

      if (response['success']) {
        success = true;
        error = false;
        for (var item in response['addresses']) {
          addressList.add(AddressModel.fromJson(item));
        }
        message = 'success';
      } else {
        success = false;
        error = false;

        addressList = [];
      }
    } catch (err, stack) {
      success = false;
      error = true;

      addressList = [];
      message = '$err\n\n$stack';
    }

    notifyListeners();

    return message;
  }

  Future<String> addAddress({
    required String city,
    required String addressName,
    required String addressDetails,
    required String phoneNumber,
  }) async {
    String message = '';
    addressList = [];
    try {
      Map<String, dynamic> response = await services.addAddress(
        city: city,
        addressName: addressName,
        addressDetails: addressDetails,
        phoneNumber: phoneNumber,
      );

      if (response['success']) {
        success = true;
        error = false;
        getAddresses();

        message = 'success';
      } else {
        success = false;
        error = false;

        addressList = [];
      }
    } catch (err, stack) {
      success = false;
      error = true;

      addressList = [];
      message = '$err\n\n$stack';
    }

    notifyListeners();

    return message;
  }

  Future<String> setDefault({required String addressId}) async {
    String message = '';
    try {
      Map<String, dynamic> response =
          await services.setDefault(addressId: addressId);

      if (response['success']) {
        success = true;
        error = false;
        message = 'success';
      } else {
        success = false;
        error = false;
      }
    } catch (err, stack) {
      success = false;
      error = true;
      message = '$err\n\n$stack';
    }

    notifyListeners();

    return message;
  }

  Future<String> deleteAddress({required String addressId}) async {
    String message = '';
    try {
      Map<String, dynamic> response =
          await services.deleteAddress(addressId: addressId);

      if (response['success']) {
        success = true;
        error = false;
        message = 'success';
      } else {
        success = false;
        error = false;
      }
    } catch (err, stack) {
      success = false;
      error = true;
      message = '$err\n\n$stack';
    }

    notifyListeners();

    return message;
  }

  Future<String> updateFavorite({
    required String productId,
  }) async {
    String message = '';
    try {
      Map<String, dynamic> response = await services.updateFavorites(
        productId: productId,
      );

      if (response['success']) {
        success = true;
        error = false;
        statusFav = response['status'];
        message = 'success';
      
      } else {
        success = false;
        error = false;
      }
    } catch (err, stack) {
      success = false;
      error = true;

      message = '$err\n\n$stack';
    }

    notifyListeners();

    return message;
  }

  Future<String> getfavorites() async {
    String message = '';
    favoritesList = [];
    try {
      Map<String, dynamic> response = await services.getFavorites();

      if (response['success']) {
        success = true;
        error = false;
        for (var item in response['data']) {
          favoritesList.add(ProductsModel.fromJson(item));
        }
        message = 'success';
      } else {
        success = false;
        error = false;

        favoritesList = [];
      }
    } catch (err, stack) {
      success = false;
      error = true;

      favoritesList = [];
      message = '$err\n\n$stack';
    }

    notifyListeners();

    return message;
  }
}
