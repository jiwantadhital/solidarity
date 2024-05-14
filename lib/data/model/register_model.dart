class RegisterModel {
  String? status;
  String? message;
  int? customerId;
  Data? data;

  RegisterModel({this.status, this.message, this.customerId, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    customerId = json['customer_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['customer_id'] = this.customerId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? code;
  String? firstName;
  String? lastName;
  String? phone;
  String? dob;
  String? imageUrl;
  String? email;
  String? address;
  String? occupation;
  String? bioDescription;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.code,
      this.firstName,
      this.lastName,
      this.phone,
      this.dob,
      this.imageUrl,
      this.email,
      this.address,
      this.occupation,
      this.bioDescription,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    dob = json['dob'];
    imageUrl = json['image_url'];
    email = json['email'];
    address = json['address'];
    occupation = json['occupation'];
    bioDescription = json['bio_description'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['image_url'] = this.imageUrl;
    data['email'] = this.email;
    data['address'] = this.address;
    data['occupation'] = this.occupation;
    data['bio_description'] = this.bioDescription;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
