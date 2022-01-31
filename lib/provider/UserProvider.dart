import 'package:apiwithprovider/models/User.dart';
import 'package:apiwithprovider/repo/ApiResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

enum ResponseState{
  INITIAL,LOADING,LOADED,ERROR
}

class UserProvider extends ChangeNotifier{
  ResponseState responseState = ResponseState.INITIAL;
  List<User> users;
  String message;

  UserProvider(){
    _getAllUser();
  }



  Future<void> _getAllUser() async {
    responseState = ResponseState.LOADING;
    try {
      var user = await ApiResponse.instance.getAllUser();
      users = user;
      responseState = ResponseState.LOADED;
    }  catch (e) {
      message = '$e';
      responseState= ResponseState.ERROR;
    }

    notifyListeners();


  }
}