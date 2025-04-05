import 'package:deliveryapp/api/login_api.dart';
import 'package:deliveryapp/app_confiq/auth_service.dart';
import 'package:deliveryapp/home_module/model/summary_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<SummaryModel> fetchSummaryDetails({
  required String employeeId,
  required String date,
}) async {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('MM-dd-yyyy').format(now);
  SharedPreferences logindata = await SharedPreferences.getInstance();
  print("TOKEN==========>${logindata.getString("token")}");
  try {
    AuthService authService = AuthService();
    // APIService().refreshToken();
    //int? userID = await authService.getUserId();
    await authService.getValidToken();
    String? token = await authService.getToken();
    final response = await http.get(
      Uri.parse(
          '${ApiService.baseUrl}DashBoard/GetSummaryDetails?employeeID=${logindata.getString("userId")}&date=${formattedDate}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    print(
        "URL=================>${ApiService.baseUrl}DashBoard/GetSummaryDetails?employeeID=${logindata.getString("userId")}&date=${formattedDate}");
    print("TOKEN===============>${logindata.getString("token")}");
    print("response222ss========>${response.statusCode}");
    if (response.statusCode == 200) {
      return SummaryModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load summary details');
    }
  } catch (e) {
    throw Exception('Error fetching summary 12333: ${e.toString()}');
  }
}
