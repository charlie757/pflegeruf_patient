class ViewServiceModel {
  dynamic status;
  dynamic code;
  dynamic authStatus;
  dynamic message;
  Data? data;

  ViewServiceModel(
      {this.status, this.code, this.authStatus, this.message, this.data});

  ViewServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    authStatus = json['authStatus'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['code'] = code;
    data['authStatus'] = authStatus;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Category? category;

  Data({this.category});

  Data.fromJson(Map<String, dynamic> json) {
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Category {
  dynamic categoryId;
  dynamic categoryNameDe;
  dynamic categoryImage;
  dynamic categoryStatus;
  dynamic categoryDisplayHome;
  dynamic categoryCreatedAt;
  dynamic categoryUpdatedAt;
  dynamic categorySorting;
  dynamic categoryNameEs;
  dynamic categoryName;
  dynamic description;
  dynamic descriptionDe;
  String? categoryPath;

  Category(
      {this.categoryId,
      this.categoryNameDe,
      this.categoryImage,
      this.categoryStatus,
      this.categoryDisplayHome,
      this.categoryCreatedAt,
      this.categoryUpdatedAt,
      this.categorySorting,
      this.categoryNameEs,
      this.categoryName,
      this.description,
      this.descriptionDe,
      this.categoryPath});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryNameDe = json['category_name_de'];
    categoryImage = json['category_image'];
    categoryStatus = json['category_status'];
    categoryDisplayHome = json['category_display_home'];
    categoryCreatedAt = json['category_created_at'];
    categoryUpdatedAt = json['category_updated_at'];
    categorySorting = json['category_sorting'];
    categoryNameEs = json['category_name_es'];
    categoryName = json['category_name'];
    description = json['description'];
    descriptionDe = json['description_de'];
    categoryPath = json['CategoryPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category_id'] = categoryId;
    data['category_name_de'] = categoryNameDe;
    data['category_image'] = categoryImage;
    data['category_status'] = categoryStatus;
    data['category_display_home'] = categoryDisplayHome;
    data['category_created_at'] = categoryCreatedAt;
    data['category_updated_at'] = categoryUpdatedAt;
    data['category_sorting'] = categorySorting;
    data['category_name_es'] = categoryNameEs;
    data['category_name'] = categoryName;
    data['description'] = description;
    data['description_de'] = descriptionDe;
    data['CategoryPath'] = categoryPath;
    return data;
  }
}
