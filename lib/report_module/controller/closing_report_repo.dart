import 'dart:convert';

import 'package:deliveryapp/api/login_api.dart';
import 'package:deliveryapp/app_confiq/app_url.dart';
import 'package:deliveryapp/report_module/model/closing_report_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ClosingReport> fetchclosingreport() async {
    try{
       DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM-dd-yyyy').format(now);
       SharedPreferences logindata = await SharedPreferences.getInstance();
 final response = await http.get(
    Uri.parse("${ApiService.baseUrl}DashBoard/GetClosingReport?employeeID=${logindata.getString("userId")}&date=$formattedDate"),
    headers: {
      'Content-type': 'application/json',
      'Authorization': "Bearer ${logindata.getString("token")}"
    },
  );
  
  print("RESPONSE===========>${response.statusCode}");
  if(response.statusCode ==200){
    return ClosingReport.fromJson(jsonDecode(response.body));
  }else {
    throw Exception('Failed to load response');
  }
    }catch(e){
      print("EROOR===================>${e.toString()}");
      throw Exception('Failed to load response');
    }
  
}