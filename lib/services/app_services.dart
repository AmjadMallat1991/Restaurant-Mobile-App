import 'package:dio/dio.dart';
import 'package:mongodb_app/constant/api_links.dart';
import 'package:mongodb_app/main.dart';

class AppServices {
  Future<Map<String, dynamic>> getProductsById(
      {required String categoryId}) async {
    try {
      final response = await api.get(
        "${ApiLinks.getRequestRoute("get_products_by_id")}/$categoryId",
      );
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> getProductDetails(
      {required String productId}) async {
    try {
      final response = await api.get(
        "${ApiLinks.getRequestRoute("get_product_details")}/$productId",
      );
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> getCategories() async {
    try {
      final response =
          await api.get(ApiLinks.getRequestRoute('get_categories'));
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> getCart() async {
    try {
      final response = await api.get(ApiLinks.getRequestRoute('cart'));
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> addToCart(
      {required String productId, required int quantity}) async {
    try {
      final response =
          await api.post(ApiLinks.getRequestRoute('add_cart'), data: {
        "product_id": productId,
        "quantity": quantity,
      });
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> removeFromCart(
      {required String productId, required int quantity}) async {
    try {
      final response =
          await api.post(ApiLinks.getRequestRoute('remove_cart'), data: {
        "product_id": productId,
        "quantity": quantity,
      });
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> placeOrder({
    required String fullName,
    required String email,
    required String addressName,
    required String city,
    required String phoneNumber,
    required String subTotal,
    required String total,
    required List<dynamic> items,
  }) async {
    try {
      final response =
          await api.post(ApiLinks.getRequestRoute('place_order'), data: {
        "phone_number": phoneNumber,
        "address_name": addressName,
        "city": city,
        "full_name": fullName,
        "email": email,
        "items": items,
        "subtotal": subTotal,
        "total": total,
      });
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }

  Future<Map<String, dynamic>> getOrders({required String status}) async {
    try {
      final response =
          await api.get("${ApiLinks.getRequestRoute('order')}?status=$status");
      return response;
    } on DioException catch (error) {
      return error.response?.data ??
          {'success': false, 'message': error.message};
    }
  }
}
