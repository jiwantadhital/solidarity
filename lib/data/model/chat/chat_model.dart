class ChatModel {
  String? status;
  List<Data>? data;

  ChatModel({this.status, this.data});

  ChatModel.fromJson(Map<String, dynamic> json) {
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
  String? sendFrom;
  String? sendTo;
  String? type;
  String? message;
  String? createdAt;
  String? updatedAt;
  MsgSender? msgSender;
  MsgSender? msgReceiver;

  Data(
      {this.id,
      this.sendFrom,
      this.sendTo,
      this.type,
      this.message,
      this.createdAt,
      this.updatedAt,
      this.msgSender,
      this.msgReceiver});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sendFrom = json['send_from'];
    sendTo = json['send_to'];
    type = json['type'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    msgSender = json['msg_sender'] != null
        ? new MsgSender.fromJson(json['msg_sender'])
        : null;
    msgReceiver = json['msg_receiver'] != null
        ? new MsgSender.fromJson(json['msg_receiver'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['send_from'] = this.sendFrom;
    data['send_to'] = this.sendTo;
    data['type'] = this.type;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.msgSender != null) {
      data['msg_sender'] = this.msgSender!.toJson();
    }
    if (this.msgReceiver != null) {
      data['msg_receiver'] = this.msgReceiver!.toJson();
    }
    return data;
  }
}

class MsgSender {
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

  MsgSender(
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

  MsgSender.fromJson(Map<String, dynamic> json) {
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
