class User{
  late int id;
  late String  name;
  late String  address;
  late String  phone;
  late String  mail;

  User({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.mail,
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