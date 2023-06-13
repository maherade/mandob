class ProductModel {

   String ?productAddress;
   String ?productPrice;
   String ?productWeight;
   String ?productNotes;
   String ?productFrom;
   String ?productTo;
   String ?productImage;
   String ?productGovernment;

   ProductModel(
      {
        required this.productAddress,
        required this.productPrice,
        required this.productWeight,
        required this.productNotes,
        required this.productFrom,
        required this.productTo,
        required this.productImage,
        required this.productGovernment,

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
    };
  }
}
