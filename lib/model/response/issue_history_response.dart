class IssueHistoryResponse {
  bool? status;
  String? message;
  String? totalCount;
  List<Data>? data;

  IssueHistoryResponse({this.status, this.message, this.totalCount, this.data});

  IssueHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalCount = json['total_count'];
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
    data['message'] = this.message;
    data['total_count'] = this.totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? replaceId;
  String? mechanicId;
  String? userId;
  String? barcodeId;
  String? description;
  String? replecementDate;
  String? requestStatus;
  String? roleId;

  Data(
      {this.replaceId,
      this.mechanicId,
      this.userId,
      this.barcodeId,
      this.description,
      this.replecementDate,
      this.requestStatus,
      this.roleId});

  Data.fromJson(Map<String, dynamic> json) {
    replaceId = json['replace_id'];
    mechanicId = json['mechanic_id'];
    userId = json['user_id'];
    barcodeId = json['barcode_id'];
    description = json['description'];
    replecementDate = json['replecement_date'];
    requestStatus = json['request_status'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replace_id'] = this.replaceId;
    data['mechanic_id'] = this.mechanicId;
    data['user_id'] = this.userId;
    data['barcode_id'] = this.barcodeId;
    data['description'] = this.description;
    data['replecement_date'] = this.replecementDate;
    data['request_status'] = this.requestStatus;
    data['role_id'] = this.roleId;
    return data;
  }
}
