class ApiLinks {
  static const Map<String, String> _apis = {
    'mongo_db': 'http://localhost:8081/api/',
  };

  static const Map<String, String> requests = {
    'signup': 'users/signup',
    'signin': 'users/signin',
    'signout': 'users/signout',
    'generate-api-token': 'users/generate-api-token',
    'get_products': 'products/get',
    'get_product_details': 'products/get_product_id',
    'get_products_by_id': 'products/get_by_category',
    'get_categories': 'categories/get',
    'address': 'addresses',
    'update_favorite': 'users/update-favorite',
    'favorites': 'users/favorites',
    'cart': 'cart',
    'add_cart': 'cart/add_cart',
    'remove_cart': 'cart/remove_cart',
    'order': 'users/orders',
    'place_order': 'users/placeOrder',
  };

  static String getRequestRoute(String request) {
    return requests[request]!;
  }

  static String getBaseLink(String apiName) {
    return _apis[apiName]!;
  }
}
