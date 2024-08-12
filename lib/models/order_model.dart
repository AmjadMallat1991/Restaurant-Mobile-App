import 'package:mongodb_app/models/cart_model.dart';

class OrderModel {
  String orderId = '';
  String fullName = '';
  String email = '';
  String addressName = '';
  String city = '';
  String phoneNumber = '';
  String subTotal = '';
  String total = '';
  String status = '';
  String date = '';
  String delivery = '';
  List<CartModel> items = [];

  OrderModel({
    this.orderId = "",
    this.fullName = "",
    this.email = "",
    this.addressName = "",
    this.city = "",
    this.phoneNumber = "",
    this.subTotal = "",
    this.total = "",
    this.status = "",
    this.date = "",
    this.delivery = "",
    this.items = const [],
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'] ?? "";
    fullName = json['full_name'] ?? 0;
    email = json['email'] ?? "";
    addressName = json['address_name'] ?? "";
    city = json['city'] ?? "";
    phoneNumber = json['phone_number'] ?? "";
    status = json['status'] ?? "";
    date = json['date'] ?? "";
    total = json['total'] ?? "";
    subTotal = json['subtotal'] ?? "";
    delivery = json['delivery'] ?? "";
    if (json['items'] != null) {
      items = <CartModel>[];
      json['items'].forEach((v) {
        items.add(CartModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['full_name'] = fullName;
    data['email'] = email;
    data['addressName'] = addressName;
    data['city'] = city;
    data['phone_number'] = phoneNumber;
    data['status'] = status;
    data['date'] = date;
    data['total'] = total;
    data['subtotal'] = subTotal;
    data['delivery'] = delivery;
    data['items'] = items.map((v) => v.toJson()).toList();

    return data;
  }
}
