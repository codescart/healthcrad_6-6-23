class OrderCardModel {
  final String image;
  final String storeName;
  final String status;
  final String date;
  final String totalPrice;
  final String paymentType;
  final List<String> medicines;

  OrderCardModel(
    this.image,
    this.storeName,
    this.status,
    this.date,
    this.totalPrice,
    this.paymentType,
    this.medicines,
  );
}
