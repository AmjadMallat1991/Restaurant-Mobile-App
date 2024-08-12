import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mongodb_app/models/cart_model.dart';
import 'package:mongodb_app/models/category_model.dart';
import 'package:mongodb_app/models/order_model.dart';
import 'package:mongodb_app/models/product_model.dart';
import 'package:mongodb_app/services/app_services.dart';

class AppProvider with ChangeNotifier {
  List<ProductsModel> products = [];
  List<CategoryModel> categories = [];
  List<CartModel> cartList = [];
  List<OrderModel> orderList = [];

  String totalPrice = '';
  String subTotal = '';
  String delivery = '';

  ProductsModel productModel = ProductsModel();
  AppServices service = AppServices();
  bool success = false;
  bool error = false;

  Future<String> getProductsById({required String categoryId}) async {
    String message = '';
    products = [];
    try {
      Map<String, dynamic> response =
          await service.getProductsById(categoryId: categoryId);

      if (response['success']) {
        success = true;
        error = false;
        for (var item in response['products']) {
          products.add(ProductsModel.fromJson(item));
        }
        message = 'success';
      } else {
        success = false;
        error = false;

        products = [];
      }
    } catch (err, stack) {
      success = false;
      error = true;

      products = [];
      message = '$err\n\n$stack';
    }

    notifyListeners();

    return message;
  }

  Future<String> getProductDetails({required String productId}) async {
    String message = '';
    productModel = ProductsModel();

    try {
      Map<String, dynamic> response =
          await service.getProductDetails(productId: productId);

      if (response['success']) {
        success = true;
        error = false;
        productModel = ProductsModel.fromJson(response['product']);
        message = 'success';
      } else {
        success = false;
        error = false;

        productModel = ProductsModel();
      }
    } catch (err, stack) {
      success = false;
      error = true;

      products = [];
      message = '$err\n\n$stack';
    }

    notifyListeners();

    return message;
  }

  Future<String> getCategories() async {
    String message = '';
    categories = [];
    try {
      Map<String, dynamic> response = await service.getCategories();

      if (response['success']) {
        success = true;
        error = false;
        for (var item in response['categories']) {
          categories.add(CategoryModel.fromJson(item));
        }
        message = 'success';
      } else {
        success = false;
        error = false;

        categories = [];
      }
    } catch (err, stack) {
      success = false;
      error = true;

      categories = [];
      message = '$err\n\n$stack';
    }

    notifyListeners();

    return message;
  }

  Future<String> getCart() async {
    String message = '';
    cartList = [];
    try {
      Map<String, dynamic> response = await service.getCart();

      if (response['success']) {
        success = true;
        error = false;
        totalPrice = response["total"] ?? '';
        subTotal = response["subtotal"] ?? '';
        delivery = response["delivery"] ?? '';
        for (var item in response['cart']) {
          cartList.add(CartModel.fromJson(item));
        }
        message = 'success';
      } else {
        success = false;
        error = false;

        cartList = [];
      }
    } catch (err, stack) {
      success = false;
      error = true;

      cartList = [];
      message = '$err\n\n$stack';
    }

    notifyListeners();

    return message;
  }

  Future<String> addToCart({
    required String productId,
    required int quantity,
  }) async {
    String message = '';
    try {
      Map<String, dynamic> response = await service.addToCart(
        productId: productId,
        quantity: quantity,
      );

      if (response['success']) {
        for (var item in cartList) {
          if (item.productId == productId) {
            item.quantity += quantity;
            item.price = response['cart'].firstWhere(
                (cartItem) => cartItem['product_id'] == productId)['price'];

            break;
          }
        }
        totalPrice = response["total"] ?? '';
        subTotal = response["subtotal"] ?? '';
        delivery = response["delivery"] ?? '';

        success = true;
        error = false;
        message = 'success';
      } else {
        success = false;
        error = false;
        message = 'Failed to add item to cart';
      }
    } catch (err, stack) {
      success = false;
      error = true;
      message = '$err\n\n$stack';
    }

    notifyListeners();
    return message;
  }

  Future<String> removeFromCart({
    required String productId,
    required int quantity,
  }) async {
    String message = '';
    try {
      Map<String, dynamic> response = await service.removeFromCart(
        productId: productId,
        quantity: quantity,
      );

      if (response['success']) {
        for (var item in cartList) {
          if (item.productId == productId) {
            item.quantity -= quantity;

            if (item.quantity <= 0) {
              cartList.remove(item);
            } else {
              item.price = response['cart'].firstWhere(
                  (cartItem) => cartItem['product_id'] == productId)['price'];
            }
            break;
          }
        }
        totalPrice = response["total"] ?? '';
        subTotal = response["subtotal"] ?? '';
        delivery = response["delivery"] ?? '';

        success = true;
        error = false;
        message = 'Item removed from cart successfully.';
      } else {
        success = false;
        error = false;
        message = 'Failed to remove item from cart';
      }
    } catch (err, stack) {
      success = false;
      error = true;
      message = '$err\n\n$stack';
    }

    notifyListeners();
    return message;
  }

  Future<String> placeOrder({
    required String fullName,
    required String email,
    required String addressName,
    required String city,
    required String phoneNumber,
    required String subTotal,
    required String total,
    required List<dynamic> items,
  }) async {
    String message = '';
    try {
      Map<String, dynamic> response = await service.placeOrder(
        fullName: fullName,
        email: email,
        addressName: addressName,
        city: city,
        phoneNumber: phoneNumber,
        subTotal: subTotal,
        total: total,
        items: items,
      );
      if (response['success']) {
        success = true;
        error = false;
        message = response['message'];
      } else {
        success = false;
        error = false;
        message = response['message'];
      }
    } catch (err, stack) {
      success = false;
      error = true;
      message = '$err\n\n$stack';
    }

    notifyListeners();
    return message;
  }

  Future<String> getOrders({required String status}) async {
    String message = '';
    orderList = [];
    try {
      Map<String, dynamic> response = await service.getOrders(status: status);

      if (response['success']) {
        success = true;
        error = false;

        for (var order in response['orders']) {
          orderList.add(OrderModel.fromJson(order));
        }
        message = 'success';
      } else {
        success = false;
        error = false;

        orderList = [];
      }
    } catch (err, stack) {
      success = false;
      error = true;

      orderList = [];
      message = '$err\n\n$stack';
    }

    notifyListeners();

    return message;
  }
}
