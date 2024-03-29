class ProductModel {
  static const String collectionName = 'products';
  String? productId;
  String? productAddress;
  String? productPrice;
  String? productWeight;
  String? productNotes;
  String? productFrom;
  String? productTo;
  String? productImage;
  String? productGovernment;
  String? userName;
  String? userPhone;
  String? userEmail;
  String? userImage;
  String? userUid;
  String? date;
  bool? isAccepted;
  bool? isArrived;

  ProductModel({
    this.productId = "",
    required this.productAddress,
    required this.productPrice,
    required this.productWeight,
    required this.productNotes,
    required this.productFrom,
    required this.productTo,
    required this.productImage,
    required this.productGovernment,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    required this.userImage,
    required this.userUid,
    required this.date,
    this.isAccepted = false,
    this.isArrived = false,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : this(
          productId: json["productId"],
          productAddress: json["productAddress"],
          productPrice: json["productPrice"],
          productWeight: json["productWeight"],
          productNotes: json["productNotes"],
          productFrom: json["productFrom"],
          productTo: json["productTo"],
          productImage: json["productImage"],
          productGovernment: json["productGovernment"],
          userName: json["userName"],
          userPhone: json["userPhone"],
          userEmail: json["userEmail"],
          userImage: json["userImage"],
          userUid: json["userUid"],
          date: json["date"],
          isAccepted: json["isAccepted"],
          isArrived: json["isArrived"],
        );

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "productAddress": productAddress,
      "productPrice": productPrice,
      "productWeight": productWeight,
      "productNotes": productNotes,
      "productFrom": productFrom,
      "productTo": productTo,
      "productImage": productImage,
      "productGovernment": productGovernment,
      "userName": userName,
      "userPhone": userPhone,
      "userEmail": userEmail,
      "userImage": userImage,
      "userUid": userUid,
      "date": date,
      "isAccepted": isAccepted,
      "isArrived": isArrived,
    };
  }
}