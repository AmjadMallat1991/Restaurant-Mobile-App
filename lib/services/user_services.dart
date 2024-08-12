import 'package:dio/dio.dart';
import 'package:mongodb_app/constant/api_links.dart';
import 'package:mongodb_app/main.dart';
import 'package:mongodb_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  Future<UserModel> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      final response = await api.post(
        ApiLinks.getRequestRoute("signup"),
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );
      if (response['data']['accessToken'] != null) {
        await preferences.setString(
            'accessToken', response['data']['accessToken']);
        await preferences.setString(
            'refreshToken', response['refreshToken'] ?? '');
      }
      print(preferences.getString("accessToken"));
      final returnable = UserModel.fromJson(response);
      return returnable;
    } on DioException catch (error) {
      return UserModel.fromJson(error.response?.data ??
          {
            'success': false,
            'message': error.message,
          });
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final response = await api.post(
        ApiLinks.getRequestRoute("signin"),
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response['data'] != null && response['data']['accessToken'] != null) {
        await preferences.setString(
            'accessToken', response['data']['accessToken']);
        await preferences.setString(
            'refreshToken', response['refreshToken'] ?? '');
      }

      final returnable = UserModel.fromJson(response);
      return returnable;
    } on DioException catch (error) {
      return UserModel.fromJson(error.response?.data ??
          {
            'success': false,
            'message': error.message,
          });
    }
  }

  Future<bool> signOut() async {
    try {
      final response = await api.post(
        ApiLinks.getRequestRoute("signout"),
      );
      if (response['success']) {
        SharedPreferences storage = await SharedPreferences.getInstance();
        await storage.remove('accessToken');
        await storage.remove('refreshToken');
      }
      return true;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> getProtectedData() async {
    try {
      final response = await api.get('protected');
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> getAddresses() async {
    try {
      final response = await api.get(
        ApiLinks.getRequestRoute("address"),
      );
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> addAddress({
    required String city,
    required String addressName,
    required String addressDetails,
    required String phoneNumber,
  }) async {
    try {
      final response =
          await api.post(ApiLinks.getRequestRoute("address"), data: {
        "address_details": addressDetails,
        "address_name": addressName,
        "city": city,
        "phone_number": phoneNumber,
      });
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> setDefault({required String addressId}) async {
    try {
      final response = await api.put("addresses/$addressId/default");
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> deleteAddress(
      {required String addressId}) async {
    try {
      final response = await api.delete("addresses/$addressId");
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> updateFavorites({
    required String productId,
  }) async {
    try {
      final response =
          await api.post(ApiLinks.getRequestRoute("update_favorite"), data: {
        "productId": productId,
      });
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> getFavorites() async {
    try {
      final response = await api.get(
        ApiLinks.getRequestRoute("favorites"),
      );
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }
}
