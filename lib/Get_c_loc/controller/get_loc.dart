import 'dart:convert';

import 'package:deliveryapp/Get_c_loc/model/Loc_model.dart';
import 'package:deliveryapp/api/login_api.dart';
import 'package:deliveryapp/app_confiq/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
getCustomerLocation({
   required int customerid,
})async{
  try{
          AuthService authService = AuthService();
      // APIService().refreshToken();
      //int? userID = await authService.getUserId();
      await authService.getValidToken();
      String? token = await authService.getToken();
 SharedPreferences logindata = await SharedPreferences.getInstance();
      final response = await http.get(
        Uri.parse(
            '${ApiService.baseUrl}DashBoard/GetCustomerLocation?AccountID=$customerid'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
      );
      print("URL=============>${ApiService.baseUrl}DashBoard/GetCustomerLocation?AccountID=$customerid}");
      print("GET LOCATION STATUS CODE=============>${response.statusCode}");
      if(response.statusCode ==200){
        return CustomerLocation.fromJson(jsonDecode(response.body));
      }else {
    throw Exception('Failed to load response');
  }

  }catch(e){
     print("EROOR===================>${e.toString()}");
      throw Exception('Failed to load response');
  }

}