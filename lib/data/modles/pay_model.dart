class PayModel {
  String? uId;
  String? name;
  String? phone;
  String? pic;
  int? num;
  int? count;
  bool? isVerified;
  bool? isRefuse;
  String? screen;

  PayModel(
      {required this.uId,
        required this.name,
        required this.phone,
        required this.screen,
        required this.num,
        required this.count,
        required this.isVerified,
        required this.isRefuse,
        required this.pic
      });

  PayModel.fromJson(Map<String, dynamic> json)
      : this(
    uId: json["uId"],
    name: json["name"],
    phone: json["phone"],
    screen: json["screen"],
    num: json["num"],
    count: json["count"],
    isVerified: json["isVerified"],
    isRefuse: json["isRefuse"],
    pic: json["pic"],
  );

  Map<String, dynamic> toJson() {
    return {
      "uId": uId,
      "name": name,
      "phone": phone,
      "num": num,
      "count": count,
      "screen": screen,
      "isRefuse": isRefuse,
      "isVerified": isVerified,
      "pic": pic,
    };
  }
}
