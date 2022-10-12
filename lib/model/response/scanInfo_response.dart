class ScanInfoResponse {
  bool? status;
  String? message;
  List<Data>? data;
  int? barcodeStatus;

  ScanInfoResponse({this.status, this.message, this.data, this.barcodeStatus});

  ScanInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    barcodeStatus = json['barcode_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['barcode_status'] = this.barcodeStatus;
    return data;
  }
}

class Data {
  String? id;
  String? productId;
  String? barcodeImg;
  String? postedDate;
  String? createdAt;
  String? assignId;
  String? assignDate;
  String? insertDate;
  String? updateDate;
  String? mechanicId;
  String? productName;
  String? quantity;
  String? newQuantity;
  String? warrantyDate;
  String? roleId;
  String? updatedAt;
  String? updateQuantity;
  String? totalQuantity;
  String? description;
  String? productImage;
  String? capacity;
  WarrantyInfo? warrantyInfo;

  Data(
      {this.id,
      this.productId,
      this.barcodeImg,
      this.postedDate,
      this.createdAt,
      this.assignId,
      this.assignDate,
      this.insertDate,
      this.updateDate,
      this.mechanicId,
      this.productName,
      this.quantity,
      this.newQuantity,
      this.warrantyDate,
      this.roleId,
      this.updatedAt,
      this.updateQuantity,
      this.totalQuantity,
      this.description,
      this.productImage,
      this.capacity,
      this.warrantyInfo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    barcodeImg = json['barcode_img'];
    postedDate = json['posted_date'];
    createdAt = json['created_at'];
    assignId = json['assign_id'];
    assignDate = json['assign_date'];
    insertDate = json['insert_date'];
    updateDate = json['update_date'];
    mechanicId = json['mechanic_id'];
    productName = json['product_name'];
    quantity = json['quantity'];
    newQuantity = json['new_quantity'];
    warrantyDate = json['warranty_date'];
    roleId = json['role_id'];
    updatedAt = json['updated_at'];
    updateQuantity = json['update_quantity'];
    totalQuantity = json['total_quantity'];
    description = json['description'];
    productImage = json['product_image'];
    capacity = json['capacity'];
    warrantyInfo = json['warranty_info'] != null&&json['warranty_info'] is Map
        ? new WarrantyInfo.fromJson(json['warranty_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['barcode_img'] = this.barcodeImg;
    data['posted_date'] = this.postedDate;
    data['created_at'] = this.createdAt;
    data['assign_id'] = this.assignId;
    data['assign_date'] = this.assignDate;
    data['insert_date'] = this.insertDate;
    data['update_date'] = this.updateDate;
    data['mechanic_id'] = this.mechanicId;
    data['product_name'] = this.productName;
    data['quantity'] = this.quantity;
    data['new_quantity'] = this.newQuantity;
    data['warranty_date'] = this.warrantyDate;
    data['role_id'] = this.roleId;
    data['updated_at'] = this.updatedAt;
    data['update_quantity'] = this.updateQuantity;
    data['total_quantity'] = this.totalQuantity;
    data['description'] = this.description;
    data['product_image'] = this.productImage;
    data['capacity'] = this.capacity;
    if (this.warrantyInfo != null) {
      data['warranty_info'] = this.warrantyInfo!.toJson();
    }
    return data;
  }
}

class WarrantyInfo {
  String? warranty;
  String? fromDate;
  String? toDate;

  WarrantyInfo({this.warranty, this.fromDate, this.toDate});

  WarrantyInfo.fromJson(Map<String, dynamic> json) {
    warranty = json['warranty'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warranty'] = this.warranty;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    return data;
  }
}
