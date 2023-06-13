class MyUser {
  static const String collectionName = 'users';
  String? uId;
  String? name;
  String? phone;
  String? email;
  bool isCustomer = false;
  String pic = "assets/images/user.png";

  MyUser(
      {required this.uId,
      required this.name,
      required this.phone,
      required this.email,
      this.isCustomer = false,
      this.pic = "assets/images/user.png"});

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
          uId: json["uId"],
          name: json["name"],
          phone: json["phone"],
          email: json["email"],
        );

  Map<String, dynamic> toJson() {
    return {
      "uId": uId,
      "name": name,
      "phone": phone,
      "email": email,
    };
  }
}
