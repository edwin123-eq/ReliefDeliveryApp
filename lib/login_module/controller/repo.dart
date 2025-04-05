import 'dart:convert';
import 'package:deliveryapp/api/login_api.dart';
import 'package:deliveryapp/app_confiq/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:deliveryapp/login_module/model/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';


  

  Future<LoginResponse> login(String username, String password) async {
    
    try {
      
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}Home/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
       print("URL CODE=============>${ApiService.baseUrl}Home/login");
       
    print("STATUS CODE=============>${response.statusCode}");
      if (response.statusCode == 200) {
       
        return LoginResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to login:');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

