import 'package:deliveryapp/api/login_api.dart';
import 'package:deliveryapp/app_confiq/auth_service.dart';
import 'package:deliveryapp/bill_module/model/bill_list_model.dart';
import 'package:deliveryapp/home_module/model/summary_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<BillListModel> fetchBillDetails({
  required String employeeId,
  required String date,
}) async {
  try {
    AuthService authService = AuthService();
    // APIService().refreshToken();
    //int? userID = await authService.getUserId();
    await authService.getValidToken();
    String? token = await authService.getToken();

    final response = await http.get(
      Uri.parse(
          '${ApiService.baseUrl}DashBoard/GetSummaryDetails?employeeID=1001978158&date=09-12-2024'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    print("Bill List response========>${response.statusCode}");
    if (response.statusCode == 200) {
      return BillListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load summary details');
    }
  } catch (e) {
    throw Exception('Error fetching summary: ${e.toString()}');
  }
}

class BillService {
  // Fetch data from the API
  Future<List<BillListModel>> fetchBillDetails(
      {required String employeeId, required String date}) async {
    try {
      AuthService authService = AuthService();
      // APIService().refreshToken();
      //int? userID = await authService.getUserId();
      await authService.getValidToken();
      String? token = await authService.getToken();
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('MM-dd-yyyy').format(now);
      print("=================>${formattedDate}");
      SharedPreferences logindata = await SharedPreferences.getInstance();
      // final response = await http.get(Uri.parse(apiUrl));
      print("USERID=================>${logindata.getString("userId")}");
      final response = await http.get(
        Uri.parse(
            '${ApiService.baseUrl}DashBoard/GetListOfDeliveries?employeeID=${logindata.getString("userId")}&date=${formattedDate}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
      );
      print(
          "URL========>${ApiService.baseUrl}DashBoard/GetListOfDeliveries?employeeID=${logindata.getString("userId")}&date=${formattedDate}");
      print("TOKEN========>${token}");
      print("Bill List response========>${response.statusCode}");
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<BillListModel> bills =
            jsonData.map((json) => BillListModel.fromJson(json)).toList();
        return bills;
      } else if (response.statusCode == 404) {
        List<BillListModel> bills = [];
        return bills;
      } else {
        throw Exception("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error occurred while fetching data: $e");
    }
  }

  // Filter the bills based on dlstatus
  Future<List<BillListModel>> fetchFilteredBills(int dlstatus) async {
    List<BillListModel> bills =
        await fetchBillDetails(employeeId: '', date: '');
    return bills.where((bill) => bill.dlstatus == dlstatus).toList();
  }
}
