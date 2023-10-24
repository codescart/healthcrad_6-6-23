class Product {

  final String? id;
  final String? name;
  final String? category;
  final String? subcategory;
  final String? price;
  final String? discount;
  final String? quantity;
  final String? description;
  final List<String> imageUrls;
  final String? discount_price;
  final String? status;
  final String? prescription;
  final String? shopid;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.description,
    required this.imageUrls,
    required this.discount_price,
    required this.status,
    required this.prescription,
    required this.shopid,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      subcategory: json['subcategory'],
      price: json['price'],
      discount: json['discount'],
      quantity: json['quantity'],
      description: json['discription'],
      imageUrls: List<String>.from(json['image']),
      discount_price: json['discounted_amount'],
      status: json['status'],
      prescription: json['prescription'],
      shopid: json['shopid'],
    );
  }
}