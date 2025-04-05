import 'package:deliveryapp/api/login_api.dart';
import 'package:deliveryapp/app_confiq/auth_service.dart';
import 'package:deliveryapp/bill_details_module/model/bill_details_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BillDetailsRepository {
  // Fetch bill details
  Future<BillDetailsModel> fetchBillDetails(
      String dlSaleId, String dlEmpId) async {
    try {
      // SharedPreferences logindata = await SharedPreferences.getInstance();
      // final token = logindata.getString("token");
       AuthService authService = AuthService();
  // APIService().refreshToken();
  //int? userID = await authService.getUserId();
  await authService.getValidToken();
  String? token = await authService.getToken();
      
      print("Token=================>$token");
      print("SALE ID==========>$dlSaleId");
      print("EMP ID==========>$dlEmpId");

      final response = await http.get(
        Uri.parse(
            '${ApiService.baseUrl}DashBoard/GetSalesDetails?DLSALEID=$dlSaleId&DLEMPID=$dlEmpId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      print("GET BILL LIST BY ID========>${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return BillDetailsModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load bill details: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching bill details: $e");
      throw Exception('Failed to load bill details: $e');
    }
  }

  // Fetch UPI details
  Future<UPIDetailsModel> fetchUPIDetails() async {
    try {
      SharedPreferences logindata = await SharedPreferences.getInstance();
      final token = logindata.getString("token");

      print("Token=================>$token");

      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}DashBoard/GetUPIdetails'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      print("GET UPI DETAILS STATUS CODE========>${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return UPIDetailsModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load UPI details: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching UPI details: $e");
      throw Exception('Failed to load UPI details: $e');
    }
  }

  // Helper method to get auth token
  Future<String?> getAuthToken() async {
    try {
      SharedPreferences logindata = await SharedPreferences.getInstance();
      return logindata.getString("token");
    } catch (e) {
      print("Error getting auth token: $e");
      return null;
    }
  }
}