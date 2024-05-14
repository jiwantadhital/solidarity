class NewFriendsModel {
  String? status;
  String? message;
  List<NewData>? data;

  NewFriendsModel({this.status, this.message, this.data});

  NewFriendsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NewData>[];
      json['data'].forEach((v) {
        data!.add(new NewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewData {
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
  bool? friendRequestSent;
  bool? isFriend;

  NewData(
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
      this.updatedAt,
      this.friendRequestSent,
      this.isFriend});

  NewData.fromJson(Map<String, dynamic> json) {
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
    friendRequestSent = json['friend_request_sent'];
    isFriend = json['is_friend'];
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
    data['friend_request_sent'] = this.friendRequestSent;
    data['is_friend'] = this.isFriend;
    return data;
  }
}
