import 'package:ann_shop_flutter/core/core.dart';
import 'package:ann_shop_flutter/core/utility.dart';

class Product {
  int productID;
  String sku;
  String name;
  String slug;
  String materials;
  List<ProductColors> colors;
  List<ProductSize> sizes;
  int badge;
  bool availability;
  List<ProductThumbnails> thumbnails;
  double regularPrice;
  double oldPrice;
  double retailPrice;
  String content;

  String get getCover {
    if(Utility.isNullOrEmpty(thumbnails)){
      return '';
    }else{
      return thumbnails[0].url;
    }
  }

  Product(
      {this.productID,
        this.sku,
        this.name,
        this.slug,
        this.materials,
        this.colors,
        this.sizes,
        this.badge,
        this.availability,
        this.thumbnails,
        this.regularPrice,
        this.oldPrice,
        this.retailPrice,
        this.content});

  Product.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    sku = json['sku'];
    name = json['name'];
    slug = json['slug'];
    materials = json['materials'];
    if (json['colors'] != null) {
      colors = new List<ProductColors>();
      json['colors'].forEach((v) {
        colors.add(new ProductColors.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = new List<ProductSize>();
      json['sizes'].forEach((v) {
        sizes.add(new ProductSize.fromJson(v));
      });
    }
    badge = json['badge'];
    availability = json['availability'];
    if (json['thumbnails'] != null) {
      thumbnails = new List<ProductThumbnails>();
      json['thumbnails'].forEach((v) {
        thumbnails.add(new ProductThumbnails.fromJson(v));
      });
    }
    regularPrice = json['regularPrice'];
    oldPrice = json['oldPrice'];
    retailPrice = json['retailPrice'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['materials'] = this.materials;
    if (this.colors != null) {
      data['colors'] = this.colors.map((v) => v.toJson()).toList();
    }
    if (this.sizes != null) {
      data['sizes'] = this.sizes.map((v) => v.toJson()).toList();
    }
    data['badge'] = this.badge;
    data['availability'] = this.availability;
    if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails.map((v) => v.toJson()).toList();
    }
    data['regularPrice'] = this.regularPrice;
    data['oldPrice'] = this.oldPrice;
    data['retailPrice'] = this.retailPrice;
    data['content'] = this.content;
    return data;
  }
}

class ProductColors {
  int productID;
  int id;
  String name;

  ProductColors({this.productID, this.id, this.name});

  ProductColors.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ProductThumbnails {
  String size;
  String url;

  ProductThumbnails({this.size, this.url});

  ProductThumbnails.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['url'] = this.url;
    return data;
  }
}
class ProductSize {
  int productID;
  int id;
  String name;

  ProductSize({this.productID, this.id, this.name});

  ProductSize.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}