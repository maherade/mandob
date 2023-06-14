class MyUser {
  static const String collectionName = 'users';
  String? uId;
  String? name;
  String? phone;
  String? email;
  bool? isCustomer;
  String? pic;

  MyUser(
      {required this.uId,
      required this.name,
      required this.phone,
      required this.email,
      this.isCustomer = false,
      required this.pic
      });

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
    uId: json["uId"],
          name: json["name"],
          phone: json["phone"],
          email: json["email"],
          isCustomer: json["isCustomer"],
          pic: json["pic"],
        );

  Map<String, dynamic> toJson() {
    return {
      "uId": uId,
      "name": name,
      "phone": phone,
      "email": email,
      "isCustomer": isCustomer,
      "pic": pic,
    };
  }
}
