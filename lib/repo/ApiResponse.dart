import 'package:http/http.dart' as http;
import 'package:apiwithprovider/models/User.dart';
class ApiResponse{

  static ApiResponse _instance;
  String _BASEURL = "https://jsonplaceholder.typicode.com/users/";


  ApiResponse._();

  static ApiResponse get instance {

    if(_instance == null){
      _instance = ApiResponse._();
    }
    return _instance;
  }

  Future<List<User>> getAllUser() async {
    final api = await http.get(_BASEURL, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    var response = api.body;
    return User().userFromJson(response);
  }
}