import 'dart:async';

import 'package:myapp/models/user.dart';
import 'package:myapp/services/api_service.dart';
import 'package:myapp/services/user_service.dart';

class UserBloc{
  final _userStreamCtrl = StreamController<List<User>>();
  final _isLoadMoreStreamCtrl = StreamController<bool>();

  Stream<List<User>> get userStream => _userStreamCtrl.stream;

  Stream<bool> get isLoadMoreStream => _isLoadMoreStreamCtrl.stream;

  var user =<User>[];
  UserBloc();

  void dispose(){
    _userStreamCtrl.close();
    _isLoadMoreStreamCtrl.close();
  }

  void getUser({bool isRefresh = false}) async{
    _isLoadMoreStreamCtrl.add(true);
    await apiService.getUsers(
        onSuccess: (data){
          if (isRefresh) {
            user.clear();
          }
          user.addAll(data);
          _userStreamCtrl.add(user);
        },
        onFailure: (error){
          _userStreamCtrl.addError(error);
        },
    );
    _isLoadMoreStreamCtrl.add(false);
  }

  void insert(User user) async{
    var listUser =<User>[];
    listUser.add(user);
    await apiService.insertUser(
        user: user,
        onSuccess: (json){
          _userStreamCtrl.add(listUser);
        },
        onFailure: (error){
          _userStreamCtrl.addError(error);
        }
    );
  }

}