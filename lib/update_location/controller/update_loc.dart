import 'package:deliveryapp/api/login_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepository {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<bool> updateCustomerLocation({
    required int customerid,
    required double latitude,
    required double longitude,
  }) async {
    try {
      print("CUSTOMER ID====================>$customerid");
      SharedPreferences logindata = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse(
            '${ApiService.baseUrl}DashBoard/UpdateCustomerLocation?AccountID=$customerid&Longitude=${longitude.toString()}&Latitude=${latitude.toString()}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${logindata.getString("token")}'
        },

        // queryParameters: {
        //   'AccountID': '122',
        //   'Longitude': longitude.toString(),
        //   'Latitude': latitude.toString(),
        // },
      );
      print("longitude====================>$longitude");
      print("latitude====================>$latitude");
      print(
          "URL ID====================>${ApiService.baseUrl}DashBoard/UpdateCustomerLocation?AccountID=$customerid&Longitude=$longitude&Latitude=$latitude");
      print("TOKEN______>${logindata.getString("token")}");
      print("location_response______>${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception('Failed to update location: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error updating location: $e');
    }
  }
}
