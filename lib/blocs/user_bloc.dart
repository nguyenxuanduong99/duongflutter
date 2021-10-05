import 'dart:async';

import 'package:myapp/models/user.dart';
import 'package:myapp/services/api_service.dart';
import 'package:myapp/services/user_service.dart';

class UserBloc{
  final _userStreamCtrl = StreamController<List<User>>();
  final _isLoadMoreStreamCtrl = StreamController<bool>();

  Stream<List<User>> get userStream => _userStreamCtrl.stream;

  Stream<bool> get isLoadMoreStream => _isLoadMoreStreamCtrl.stream;

  var users =<User>[];
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
            users.clear();
          }
          users.addAll(data);
          _userStreamCtrl.add(users);
        },
        onFailure: (error){
          _userStreamCtrl.addError(error);
        },
    );
    _isLoadMoreStreamCtrl.add(false);
  }
  void getUserById(int id) async{
    await apiService.getUserById(
      id: id,
      onSuccess: (data){
        users.clear();
        users.addAll(data);
        _userStreamCtrl.add(users);
      },
      onFailure: (error){
        _userStreamCtrl.addError(error);
      },
    );
  }

  void insert(User user) async{
    await apiService.insertUser(
        user: user,
        onSuccess: (json){
          users.add(user);
          _userStreamCtrl.sink.add(users);
        },
        onFailure: (error){
          _userStreamCtrl.addError(error);
        }
    );
  }
  void update(User user) async{
    await apiService.updateUser(
        user: user,
        onSuccess: (json){
          for(int i=0;i<users.length;i++){
            if(users[i].id == user.id){
              users[i] = user;
            }
          }
          _userStreamCtrl.sink.add(users);
        },
        onFailure: (error){
          _userStreamCtrl.addError(error);
        }
    );
  }
  void delete(User user) async{
    await apiService.deleteUser(
        user: user,
        onSuccess: (json){
          users.remove(user);
          _userStreamCtrl.sink.add(users);
        },
        onFailure: (error){
          _userStreamCtrl.addError(error);
        }
    );
  }

}