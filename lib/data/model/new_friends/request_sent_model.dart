class RequestSentModel {
  String? status;
  String? message;
  Data? data;

  RequestSentModel({this.status, this.message, this.data});

  RequestSentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? sentFrom;
  String? sentTo;
  String? status;
  String? createdAt;
  String? updatedAt;
  RequestSendFrom? requestSendFrom;
  RequestSendTo? requestSendTo;

  Data(
      {this.id,
      this.sentFrom,
      this.sentTo,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.requestSendFrom,
      this.requestSendTo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sentFrom = json['sent_from'];
    sentTo = json['sent_to'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    requestSendFrom = json['request_send_from'] != null
        ? new RequestSendFrom.fromJson(json['request_send_from'])
        : null;
    requestSendTo = json['request_send_to'] != null
        ? new RequestSendTo.fromJson(json['request_send_to'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sent_from'] = this.sentFrom;
    data['sent_to'] = this.sentTo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.requestSendFrom != null) {
      data['request_send_from'] = this.requestSendFrom!.toJson();
    }
    if (this.requestSendTo != null) {
      data['request_send_to'] = this.requestSendTo!.toJson();
    }
    return data;
  }
}

class RequestSendFrom {
  int? id;
  String? code;
  String? firstName;
  String? lastName;
  String? email;
  String? address;
  String? phone;
  String? imageUrl;
  String? dob;
  String? occupation;
  String? bioDescription;
  String? status;
  String? createdAt;
  String? updatedAt;

  RequestSendFrom(
      {this.id,
      this.code,
      this.firstName,
      this.lastName,
      this.email,
      this.address,
      this.phone,
      this.imageUrl,
      this.dob,
      this.occupation,
      this.bioDescription,
      this.status,
      this.createdAt,
      this.updatedAt});

  RequestSendFrom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    imageUrl = json['image_url'];
    dob = json['dob'];
    occupation = json['occupation'];
    bioDescription = json['bio_description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['image_url'] = this.imageUrl;
    data['dob'] = this.dob;
    data['occupation'] = this.occupation;
    data['bio_description'] = this.bioDescription;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class RequestSendTo {
  int? id;
  String? code;
  String? firstName;
  String? lastName;
  String? email;
  String? address;
  String? phone;
  String? imageUrl;
  String? dob;
  String? occupation;
  String? bioDescription;
  String? status;
  String? createdAt;
  String? updatedAt;

  RequestSendTo(
      {this.id,
      this.code,
      this.firstName,
      this.lastName,
      this.email,
      this.address,
      this.phone,
      this.imageUrl,
      this.dob,
      this.occupation,
      this.bioDescription,
      this.status,
      this.createdAt,
      this.updatedAt});

  RequestSendTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    imageUrl = json['image_url'];
    dob = json['dob'];
    occupation = json['occupation'];
    bioDescription = json['bio_description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['image_url'] = this.imageUrl;
    data['dob'] = this.dob;
    data['occupation'] = this.occupation;
    data['bio_description'] = this.bioDescription;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
