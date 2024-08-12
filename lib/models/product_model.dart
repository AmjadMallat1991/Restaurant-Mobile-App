import 'package:mongodb_app/models/ingredient_model.dart';

class ProductsModel {
  String productName = '';
  String productDescription = '';
  String price = '';
  String image = '';
  String productId = '';
  List<IngredientModel> ingredients = [];

  ProductsModel({
    this.productName = "",
    this.productDescription = "",
    this.price = "",
    this.image = "",
    this.productId = "",
    this.ingredients = const [],
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'] ?? "";
    productDescription = json['product_description'] ?? "";
    price = json['price'] ?? "";
    image = json['image'] ?? "";
    productId = json['product_id'] ?? "";
    if (json['ingredients'] != null) {
      ingredients = <IngredientModel>[];
      json['ingredients'].forEach((v) {
        ingredients.add(IngredientModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['product_description'] = productDescription;
    data['price'] = price;
    data['image'] = image;
    data['product_id'] = productId;
    data['ingredients'] = ingredients.map((v) => v.toJson()).toList();
    return data;
  }
}
