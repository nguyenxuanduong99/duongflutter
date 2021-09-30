import 'dart:convert';

import 'package:myapp/models/user.dart';
import 'package:myapp/services/api_service.dart';

extension UserService on ApiService {
  Future getUsers({
    required Function(List<User>) onSuccess,
    required Function(String) onFailure,
  }) async {
     await apiService.request(
      path: "/api/user",
      // headers: {'Content-Type': 'application/json'},
      method: Method.get,
      onSuccess: (json) {
        final users = List<User>.from(json.map((e) => User.fromJson(e)));
        onSuccess(users);
      },
      onFailure: (error) {
        print(error);
      },
    );
  }
  Future insertUser({
    required User user,
    required Function(String) onSuccess,
    required Function(String) onFailure,
  })async{
    Map<String,String> params = {
      "id"     : user.id.toString(),
      "name"   : user.name ??"",
      "address": user.address ??"",
      "phone"  : user.phone ??"",
      "mail"   : user.mail ??"",

    };
    await apiService.request(
        path: "/api/user",
        method: Method.post,
        parameters: params,
        onSuccess: (json){
          print(json);
        },
        onFailure: (error){
          print(error);
        },
    );
  }
}