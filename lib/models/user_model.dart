class UserModel {
  bool success = false;
  Data? data;
  String? accessToken;
  String? message;

  UserModel();

  UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      success = false;
      message = 'An error occurred';
    } else {
      success = json['success'] ?? false;
      message = json['message'] ?? '';
      if (json['data'] != null) {
        data = json['data']['user'] != null
            ? Data.fromJson(json['data']['user'])
            : null;
        accessToken = json['data']['accessToken'];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = {'user': this.data!.toJson(), 'accessToken': accessToken};
    }
    return data;
  }
}

class Data {
  String userId = "";
  String firstName = "";
  String lastName = "";
  String email = "";

  Data({
    this.userId = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
  });

  factory Data.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Data();
    }
    return Data(
      userId: json['user_id'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      email: json['email'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }
}
