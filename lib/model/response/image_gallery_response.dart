class ImageGalleryResponse {
  bool? status;
  String? message;
  List<Data>? data;
  String? basePath;

  ImageGalleryResponse({this.status, this.message, this.data, this.basePath});

  ImageGalleryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    basePath = json['base_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['base_path'] = this.basePath;
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? image;
  String? insertDate;

  Data({this.id, this.title, this.image, this.insertDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
    image = json['image'].toString();
    insertDate = json['insert_date'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['insert_date'] = this.insertDate;
    return data;
  }
}
