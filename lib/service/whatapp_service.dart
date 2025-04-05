import 'package:deliveryapp/api/login_api.dart';
import 'package:deliveryapp/app_confiq/auth_service.dart';
import 'package:deliveryapp/models/whatApp_Msg_Model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<WhatsappMsgModel> WhatsappMsgRepo(
    {required String mobileNo, required String message}) async {
  try {
    AuthService authService = AuthService();
    await authService.getValidToken();
    String? token = await authService.getToken();
    final response = await http.post(
      Uri.parse(
          '${ApiService().whastappurl}?mobileNo=$mobileNo&message=$message'), // Add parameters to the URL
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
      // body: json.encode({
      //   'mobileNo': 8129690147, // Use the mobileNo parameter
      //   'message': message,
      // }),
    );
    print("URL CODE=============>${ApiService().whastappurl}");

    print("STATUS CODE=============>${response.statusCode}");
    if (response.statusCode == 200) {
      print("wpppppppppppp msg=============>${response.body}");
      return WhatsappMsgModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Send Message:');
    }
  } catch (e) {
    throw Exception('Failed to send message: $e');
  }
}
