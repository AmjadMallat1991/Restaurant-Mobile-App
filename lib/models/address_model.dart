class AddressModel {
  String userId = '';
  String addressDetails = '';
  String addressName = '';
  String city = '';
  String phoneNumber = '';
  bool defaults = false;
  String addressId = '';

  AddressModel({
    this.userId = '',
    this.addressDetails = '',
    this.addressName = '',
    this.city = '',
    this.phoneNumber = '',
    this.defaults = false,
    this.addressId = '',
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] ?? "";
    addressDetails = json['address_details'] ?? "";
    addressName = json['address_name'] ?? "";
    city = json['city'] ?? "";
    phoneNumber = json['phone_number'] ?? "";
    defaults = json['default'] ?? false;
    addressId = json['address_id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['address_details'] = addressDetails;
    data['address_name'] = addressName;
    data['city'] = city;
    data['phone_number'] = phoneNumber;
    data['default'] = defaults;
    data['address_id'] = addressId;
    return data;
  }
}
