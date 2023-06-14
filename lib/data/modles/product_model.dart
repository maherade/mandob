class ProductModel {
  static const String collectionName = 'products';

  String? productAddress;
  String? productPrice;
  String? productWeight;
  String? productNotes;
  String? productFrom;
  String? productTo;
  String? productImage;
  String? productGovernment;
  String? userName;
  String ?userPhone;
  String ?userEmail;
  String ?userImage;
  String ?userUid;

  ProductModel({
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

  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : this(
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
  );

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}
