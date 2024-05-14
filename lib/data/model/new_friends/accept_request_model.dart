class AcceptedModel {
  String? status;
  String? message;
  Data? data;

  AcceptedModel({this.status, this.message, this.data});

  AcceptedModel.fromJson(Map<String, dynamic> json) {
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
  int? customerId;
  String? categoryId;
  String? network;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.customerId,
      this.categoryId,
      this.network,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    categoryId = json['category_id'];
    network = json['network'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['category_id'] = this.categoryId;
    data['network'] = this.network;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
