import 'dart:convert';
import 'dart:io';

import 'package:chat_app/common/environment.dart';
import 'package:chat_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AuthService extends ChangeNotifier{

  late User user;
  bool _authenticating = false;
  final _storage = const FlutterSecureStorage();

  bool get authenticating => _authenticating;
  set authenticating(bool value){
    _authenticating = value;
    notifyListeners();
  }

  static Future<String> getToken()async{
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token ?? '';
  }

  static Future<void> deleteToken()async{
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }
  
  Future<bool> login( String email, String password ) async {

    final data = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse('${Environment.apiUrl}/auth/login'), 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    _authenticating = false;
    print(resp.body);

    if(resp.statusCode == 201){
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.user;
      await _storeToken(loginResponse.token);
      return true;
    }else{
      return false;
    }

  }

  Future<String> register( String name,String email, String password ) async {

    String errors = '';

    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse('${Environment.apiUrl}/auth/user'), 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      },
    );

    _authenticating = false;
    print(resp.body);

    if(resp.statusCode == 201){
      await login(email, password);
      return '';
    }else{
      for (String error in jsonDecode(resp.body)['message'] as List<dynamic>) {
        errors += "$error\n";
      }
      return errors;
    }

  }


  Future<bool> isLogged() async {
    final token = await _storage.read(key: 'token');

    final resp = await http.get(
      Uri.parse('${Environment.apiUrl}/auth/renew'), 
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if(resp.statusCode == 200){
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.user;
      await _storeToken(loginResponse.token);
      return true;
    }else{
      logOut();
      return false;
    }
  }


  Future _storeToken( String token ) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logOut() async {
    await _storage.delete(key: 'token');
  }

  Future<void> uploadProfilePicture( String imagePath ) async {

    final imageFile = File.fromUri( Uri(path: imagePath) );
    final token = await _storage.read(key: 'token');
    final fileName = imageFile.path.split('/').last;

    final uri = Uri.parse("${Environment.apiUrl}/files/user");
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Authorization': 'Bearer $token'
    });
    final httpImage = await http.MultipartFile.fromPath(
      'file', 
      imageFile.path,
      filename: fileName,
      contentType: MediaType('image','jpeg') //REALLY IMPORTANT LINE
    );
    request.files.add(httpImage);
    final streamResponse = await request.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode == 201){
      final userResponse = User.fromJson(resp.body);
      user = userResponse;
      notifyListeners();
    }
   
  }

  Future<void> deleteProfilePicture() async {

    final token = await _storage.read(key: 'token');

    final resp = await http.delete(
      Uri.parse('${Environment.apiUrl}/files/user'), 
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if(resp.statusCode == 200){
      final userResponse = User.fromJson(resp.body);
      user = userResponse;
      notifyListeners();
    }

  //   FormData formData = FormData.fromMap({
  //     "file": await MultipartFile.fromFile(imageProfile.path, filename:fileName),
  //   });

  //  Dio dio = Dio();

  //   await dio.post("${Environment.apiUrl}/files/user", 
  //     data: formData,
  //     options: Options(headers: {
  //       // "Content-Type": "application/json",
  //       "Authorization":
  //           "Bearer $token",
  //     })
  //   )
  //   .then((response) => print(response))
  //   .catchError((error) => print(error));

   
  }

}