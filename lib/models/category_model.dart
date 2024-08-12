import 'package:mongodb_app/models/product_model.dart';

class CategoryModel {
  String sId = '';
  String categoryId = '';
  String categoryName = '';
  String categoryImage = '';
  List<ProductsModel> products = [];

  CategoryModel({
    this.sId = "",
    this.categoryId = "",
    this.categoryName = "",
    this.categoryImage = "",
    this.products = const [],
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "";
    categoryId = json['category_id'] ?? "";
    categoryName = json['category_name'] ?? "";
    categoryImage = json['image'] ?? "";
    if (json['products'] != null) {
      products = <ProductsModel>[];
      json['products'].forEach((v) {
        products.add(ProductsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['image'] = categoryImage;
    data['products'] = products.map((v) => v.toJson()).toList();
    return data;
  }
}
