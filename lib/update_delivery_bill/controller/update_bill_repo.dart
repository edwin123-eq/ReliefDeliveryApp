import 'dart:convert';
import 'package:deliveryapp/api/login_api.dart';
import 'package:deliveryapp/bill_details_module/model/bill_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateDeliveryRepository {
  Future<void> updateDelivery(BillDetailsModel bill,double cashAmt, double onlineAmt,int status,String remarks) async {
    // print("update map${request}");
    try {
        SharedPreferences logindata = await SharedPreferences.getInstance();
      final body = {
                              "dlid": bill.deliveryID,
                              "dlsaleid": bill.saleId,
                              "dlassignedby": 0,
                              "dlassignedat": DateTime.now().toIso8601String(),
                              "dlempid": bill.empId,
                              "dlstatus": status, // Status for return
                              "dlon": DateTime.now().toIso8601String(),
                              "dlcashrcvd": cashAmt,
                              "dlbankrcvd": onlineAmt,
                              "dlremarks": remarks.isNotEmpty?remarks:"Test Rmarks",
                              "customername": bill.customerName,
                              "address":  bill.address.isNotEmpty
                                          ? bill.address
                                          : "No Addresss",
                              "quantity": bill.quantity,
                              "amountreceived": cashAmt+onlineAmt,
                              "netSaleAmount": bill.amtReceived,
                              "phoneNumber":bill.phoneNumber
                            };
       print("update map${body}");    
       print("URL---------->${ApiService.baseUrl}DashBoard/UpdateDelivery");
       print("TOKEN---------->${ApiService().token}");        
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}DashBoard/UpdateDelivery'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${logindata.getString("token")}',
        },
        body: jsonEncode(body),
      );
      print("update============>${response.statusCode}");
      if (response.statusCode != 200) {
        throw Exception('Failed to update delivery: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to update delivery: $e');
    }
  }
}
