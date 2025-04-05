import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  //final String baseUrl = "https://192.168.1.38/api/api/";
  //final String baseUrl = "https://reliefapp.equallive.app/Api/api/";
   static String baseUrl = "https://test.equaleazy.com/reliefapi/api/";

  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiYWRtaW4iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBZG1pbmlzdHJhdG9yIiwiVXNlcklkIjoiMSIsImV4cCI6MTczNDYwNjMyNywiaXNzIjoibWUiLCJhdWQiOiJ5b3UifQ.RUrdqjb4hlOSRM-20FcS5nFmkUaVFD2b4BmLXT5UtCI";
  final String tokenurl = "${baseUrl}Home/RefreshToken";
  final String whastappurl = "${baseUrl}Home/SendWhatsappMessage";
  // Login Function
}
