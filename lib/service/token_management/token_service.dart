// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;

// final storage = FlutterSecureStorage();

// Future<String?> getStoredToken() async {
//   return await storage.read(key: "access_token");
// }

// Future<DateTime?> getTokenExpiration() async {
//   final expiration = await storage.read(key: "token_expiration");
//   return expiration != null ? DateTime.parse(expiration) : null;
// }

// Future<void> storeToken(String token, DateTime expiration) async {
//   await storage.write(key: "access_token", value: token);
//   await storage.write(key: "token_expiration", value: expiration.toIso8601String());
// }

// bool isTokenExpired(DateTime? expiration) {
//   if (expiration == null) return true;
//   return DateTime.now().isAfter(expiration);
// }   
// Future<void> refreshToken() async {
//   final refreshToken = await storage.read(key: "refresh_token"); // Store this during login
//   if (refreshToken == null) {
//     throw Exception("No refresh token available");
//   }

//   final response = await http.post(
//     Uri.parse("https://yourapi.com/refresh"),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode({
//       "refresh_token": refreshToken,
//     }),
//   );

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     final newToken = data['access_token'];
//     final expiresIn = data['expires_in']; // seconds
//     final expiration = DateTime.now().add(Duration(seconds: expiresIn));

//     await storeToken(newToken, expiration);
//   } else {
//     throw Exception("Failed to refresh token");
//   }
// }