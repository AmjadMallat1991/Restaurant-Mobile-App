class CartModel {
  String productName = '';
  String price = '';
  String image = '';
  String productId = '';
  int quantity = 0;

  CartModel({
    this.productName = "",
    this.quantity = 0,
    this.price = "",
    this.image = "",
    this.productId = "",
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'] ?? "";
    quantity = json['quantity'] ?? 0;
    price = json['price'] ?? "";
    image = json['image'] ?? "";
    productId = json['product_id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['quantity'] = quantity;
    data['price'] = price;
    data['image'] = image;
    data['product_id'] = productId;
    return data;
  }
}
