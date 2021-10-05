

import 'package:myapp/models/user.dart';
import 'package:myapp/services/api_service.dart';

extension UserService on ApiService {
  Future getUsers({
    required Function(List<User>) onSuccess,
    required Function(String) onFailure,
  }) async {
     await apiService.request(
      path: "/api/user",
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
  Future getUserById({
    required int id,
    required Function(List<User>) onSuccess,
    required Function(String) onFailure,
  }) async {
    Map<String,String> header = {
      "id"     : id.toString(),
    };
    await apiService.request(
      path: "/api/user/findbyid",
      method: Method.get,
      headers: header,
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
          onSuccess("ok");
        },
        onFailure: (error){
          print(error);
        },
    );
  }

  Future updateUser({
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
      method: Method.put,
      parameters: params,
      onSuccess: (json){
        onSuccess("ok");
      },
      onFailure: (error){
        print(error);
      },
    );
  }

  Future deleteUser({
    required User user,
    required Function(String) onSuccess,
    required Function(String) onFailure,
  })async{
    Map<String,String> header = {
      "id"     : user.id.toString(),
    };
    await apiService.request(
      path: "/api/user/delete",
      method: Method.delete,
      headers: header,
      onSuccess: (json){
        onSuccess("ok");
      },
      onFailure: (error){
        print(error);
      },
    );
  }
}