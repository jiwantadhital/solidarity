class ChatFriendModel {
  String? status;
  List<Dataum>? data;

  ChatFriendModel({this.status, this.data});

  ChatFriendModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Dataum>[];
      json['data'].forEach((v) {
        data!.add(new Dataum.fromJson(v));
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

class Dataum {
  SendFrom? sendFrom;
  SendFrom? sendTo;
  String? chatWith;
  String? message;
  String? createdAt;

  Dataum(
      {this.sendFrom,
      this.sendTo,
      this.chatWith,
      this.message,
      this.createdAt});

  Dataum.fromJson(Map<String, dynamic> json) {
    sendFrom = json['send_from'] != null
        ? new SendFrom.fromJson(json['send_from'])
        : null;
    sendTo =
        json['send_to'] != null ? new SendFrom.fromJson(json['send_to']) : null;
    chatWith = json['chat_with'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sendFrom != null) {
      data['send_from'] = this.sendFrom!.toJson();
    }
    if (this.sendTo != null) {
      data['send_to'] = this.sendTo!.toJson();
    }
    data['chat_with'] = this.chatWith;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class SendFrom {
  String? id;
  String? name;
  String? imageUrl;

  SendFrom({this.id, this.name, this.imageUrl});

  SendFrom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
