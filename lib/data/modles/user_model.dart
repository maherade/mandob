class MyUser {
  static const String collectionName = 'users';
  String? uId;
  String? name;
  String? phone;
  String? email;
  int? count;
  bool? isCustomer;
  String? pic;
  String? personalIdPic;
  String? carPic;

  MyUser({
    required this.uId,
    required this.name,
    required this.phone,
    required this.email,
    required this.count,
    this.isCustomer = false,
    required this.pic,
    required this.carPic,
    required this.personalIdPic,
  });

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
    uId: json["uId"],
          name: json["name"],
          phone: json["phone"],
          email: json["email"],
          count: json["count"],
          isCustomer: json["isCustomer"],
          pic: json["pic"],
          carPic: json["carPic"],
          personalIdPic: json["personalIdPic"],
        );

  Map<String, dynamic> toJson() {
    return {
      "uId": uId,
      "name": name,
      "phone": phone,
      "email": email,
      "count": count,
      "isCustomer": isCustomer,
      "pic": pic,
      "carPic": carPic,
      "personalIdPic": personalIdPic,
    };
  }
}
