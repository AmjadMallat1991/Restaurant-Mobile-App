class IngredientModel {
  String sId = '';
  String ingredientId = '';
  String ingredientName = '';
  String ingredientImage = '';

  IngredientModel({
    this.sId = "",
    this.ingredientId = "",
    this.ingredientName = "",
    this.ingredientImage = "",
  });

  IngredientModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "";
    ingredientId = json['ingredient_id'] ?? "";
    ingredientName = json['ingredient_name'] ?? "";
    ingredientImage = json['image'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['ingredient_id'] = ingredientId;
    data['ingredient_name'] = ingredientName;
    data['image'] = ingredientImage;
    return data;
  }
}
