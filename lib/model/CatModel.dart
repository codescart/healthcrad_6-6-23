import 'dart:convert';

class ApiResponse {
  final List<Prod> data;
  final String msg;
  final String error;

  ApiResponse({
    required this.data,
    required this.msg,
    required this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    List<Prod> productList = [];
    if (json['data'] != null) {
      productList = (json['data'] as List<dynamic>)
          .map((productJson) => Prod.fromJson(productJson))
          .toList();
    }
    return ApiResponse(
      data: productList,
      msg: json['msg'],
      error: json['error'],
    );
  }
}

class Prod {
  final String? id;
  final String? name;
  final String? category;
  final String? subcategory;
  final double? price;
  final double? discount;
  final int quantity;
  final List<String>? image;
  final String? description;
  final String? shopId;
  final String? discountedAmount;
  final String? status;
  final String? prescription;

  Prod({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.image,
    required this.description,
    required this.shopId,
    required this.discountedAmount,
    required this.status,
    required this.prescription,
  });

  factory Prod.fromJson(Map<String, dynamic> json) {
    final List<String> imageList = json['image'] != null
        ? List<String>.from(jsonDecode(json['image']))
        : [];

    return Prod(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      subcategory: json['subcategory'],
      price: double.parse(json['price']),
      discount: double.parse(json['discount']),
      quantity: int.parse(json['quantity']),
      image: imageList,
      description: json['description'],
      shopId: json['shopid'],
      discountedAmount: json['discounted_amount'],
      status: json['status'],
      prescription: json['prescription'],
    );
  }
}
