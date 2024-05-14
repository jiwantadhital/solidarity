class ProfileFriendsModel {
  String? status;
  List<Data>? data;

  ProfileFriendsModel({this.status, this.data});

  ProfileFriendsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? customerId;
  String? categoryId;
  String? network;
  String? status;
  String? createdAt;
  String? updatedAt;
  Customer? customer;
  Category? category;
  Customer? networkFriend;

  Data(
      {this.id,
      this.customerId,
      this.categoryId,
      this.network,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.customer,
      this.category,
      this.networkFriend});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    categoryId = json['category_id'];
    network = json['network'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    networkFriend = json['network_friend'] != null
        ? new Customer.fromJson(json['network_friend'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['category_id'] = this.categoryId;
    data['network'] = this.network;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.networkFriend != null) {
      data['network_friend'] = this.networkFriend!.toJson();
    }
    return data;
  }
}

class Customer {
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

  Customer(
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

  Customer.fromJson(Map<String, dynamic> json) {
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

class Category {
  int? id;
  String? title;
  String? slug;
  String? code;
  String? status;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.title,
      this.slug,
      this.code,
      this.status,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    code = json['code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['code'] = this.code;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
