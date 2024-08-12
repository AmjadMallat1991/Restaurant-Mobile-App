import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mongodb_app/constant/api_links.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Dio api = Dio(
    BaseOptions(
      baseUrl: ApiLinks.getBaseLink('mongo_db'),
    ),
  );

  String? _accessToken;
  String? _apiToken;

  ApiService() {
    api.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        SharedPreferences storage = await SharedPreferences.getInstance();
        _accessToken = storage.getString('accessToken');
        _apiToken = storage.getString('apiToken');

        if (_accessToken != null) {
          options.headers['Authorization'] = 'Bearer $_accessToken';
        }

        if (_apiToken != null) {
          options.headers['x-api-token'] = _apiToken;
        }

        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            return handler.next(options);
          }
        } on SocketException catch (_) {
          Response res = Response(
            requestOptions: options,
            data: {'success': false, 'message': 'no_connection'},
          );

          DioException error =
              DioException(requestOptions: options, response: res);
          return handler.reject(error);
        }
      },
      onError: (DioException error, handler) async {
        if (error.response != null && error.response!.statusCode == 401) {
          await refreshToken();
          return handler.resolve(await _retry(error.requestOptions));
        }
        return handler.next(error);
      },
      onResponse: (Response response, handler) {
        handler.next(response);
      },
    ));
  }

  Future<void> fetchApiToken() async {
    try {
      final response =
          await api.get(ApiLinks.getRequestRoute('generate-api-token'));
      print('Response from API: ${response.data}');
      if (response.data['apiToken'] != null) {
        SharedPreferences storage = await SharedPreferences.getInstance();
        await storage.setString('apiToken', response.data['apiToken']);
        _apiToken = response.data['apiToken']; // Store in memory
        print('API token fetched and stored: $_apiToken');
      } else {
        print('API token not found in response');
      }
    } catch (e) {
      print('Failed to fetch API token: $e');
    }
  }

  Future<void> refreshToken() async {
    // Implementation for refreshing token
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    requestOptions.headers['Authorization'] = 'Bearer $_accessToken';
    return api.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      ),
    );
  }

 Future<Map<String, dynamic>> post(String route, {Map<String, dynamic>? data}) async {
  try {
    // Get the token from SharedPreferences
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? accessToken = storage.getString('accessToken');

    // Set the Authorization header if the token is available
    final response = await api.post(
      route,
      data: data,
      options: Options(
        headers: {
          'Authorization': accessToken != null ? 'Bearer $accessToken' : '',
        },
      ),
    );
    return response.data;
  } on DioException catch (error) {
    return error.response?.data ?? {'success': false, 'message': error.message};
  }
}


  Future<Map<String, dynamic>> get(String route) async {
  try {
    // Get the token from SharedPreferences
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? accessToken = storage.getString('accessToken');

    // Set the Authorization header if the token is available
    final response = await api.get(
      route,
      options: Options(
        headers: {
          'Authorization': accessToken != null ? 'Bearer $accessToken' : '',
        },
      ),
    );
    return response.data;
  } on DioException catch (error) {
    return error.response?.data ?? {'success': false, 'message': error.message};
  }
}

 Future<Map<String, dynamic>> put(String route, {Map<String, dynamic>? data}) async {
  try {
    // Get the token from SharedPreferences
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? accessToken = storage.getString('accessToken');

    // Set the Authorization header if the token is available
    final response = await api.put(
      route,
      data: data,
      options: Options(
        headers: {
          'Authorization': accessToken != null ? 'Bearer $accessToken' : '',
        },
      ),
    );
    return response.data;
  } on DioException catch (error) {
    return error.response?.data ?? {'success': false, 'message': error.message};
  }
}

  Future<Map<String, dynamic>> delete(String route, {Map<String, dynamic>? data}) async {
  try {
    // Get the token from SharedPreferences
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? accessToken = storage.getString('accessToken');

    // Set the Authorization header if the token is available
    final response = await api.delete(
      route,
      data: data,
      options: Options(
        headers: {
          'Authorization': accessToken != null ? 'Bearer $accessToken' : '',
        },
      ),
    );
    return response.data;
  } on DioException catch (error) {
    return error.response?.data ?? {'success': false, 'message': error.message};
  }
}

}
