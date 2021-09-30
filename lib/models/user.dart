class User{
  late int id;
  String ? name;
  String ? address;
  String ? phone;
  String ? mail;

  User({
    required this.id,
    this.name,
    this.address,
    this.phone,
    this.mail,
  });

  User.fromJson(dynamic json){
    id = json["id"];
    name = json["name"];
    address = json["address"];
    phone = json["phone"];
    mail = json["mail"];
  }

  Map<String, dynamic> toJson(){
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["address"] = address;
    map["phone"] = phone;
    map["mail"] = mail;
    return map;
  }
}