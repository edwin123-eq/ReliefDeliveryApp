import 'dart:convert';
import 'dart:developer';

import 'package:deliveryapp/api/login_api.dart';
import 'package:deliveryapp/models/token_Model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'token';
  static const String _refreshKey = 'refresh_token';

  Future<String?> getDbName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("dbName") ?? "";
  }

  Future<String?> getDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("apiUrl") ?? "";

    //await prefs.setString("apiUrl", apiUrl);
  }

  Future<bool> getIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isloggedIn") ?? false;
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshKey);
  }

  // Get JWT token from shared preferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userId") ?? "";
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userName") ?? "";
  }

  // Get a valid token, refreshing if necessary
  Future<String?> getValidToken() async {
    String? token = await getToken();
    TokenModel tokenData;
    if (token != null && await isTokenExpired(token)) {
      // token = await refreshToken();

      tokenData = await refreshToken();
      // if (kDebugMode) {
      //   print("TOKEN ${tokenData.data.first.authToken}");
      //   print("Ref TOKEN ${tokenData.data.first.refreshToken}");
      //   print("Id ${tokenData.data.first.userId}");
      // }
      // await saveToken(
      //     tokenData.data.first.authToken, tokenData.data.first.refreshToken);
      // token = tokenData.data.first.authToken;
    } else {
      //tokenData = await refreshToken();
    }

    return token;
  }

  // Check if the token is expired
  Future<bool> isTokenExpired(String token) async {
    return JwtDecoder.isExpired(token);
  }

  // Refresh the token if expired
  Future<TokenModel> refreshToken() async {
    String userToken = (await getToken()).toString();
    String refreshToken = (await getRefreshToken()).toString();
    log("$refreshToken}");
    final response = await http.post(
      Uri.parse(ApiService().tokenurl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "token": userToken,
        'reftoken': refreshToken, // Use actual refresh token if needed
      }),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 401) {
      // final data = jsonDecode(response.body);
      var tokendetails = TokenModel.fromJson(jsonDecode(response.body));

      // Adjust based on your API response structure

      if (tokendetails.accessToken.isNotEmpty) {
        String refreshToken = tokendetails.refreshToken;
        String newToken = tokendetails.accessToken;
        if (kDebugMode) {
          print(newToken);
        }
        await saveToken(newToken, refreshToken);
      } // Save the new token
      return tokendetails;
    } else {
      // Handle token refresh failure
      throw "refresh_token_failure";
    }
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey); // Remove the specific key
  }

  Future<void> saveDbDetails(
      {required String dbname,
      required String apiUrl,
      required String company}) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("dbName", dbname);
    await prefs.setString("apiUrl", apiUrl);
    await prefs.setString("company", company);
  }

// Save JWT token to shared preferences
  Future<void> saveToken(String token, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_refreshKey, refreshToken);
  }

  Future<void> saveUserCounter({required String counter}) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("counter", counter);
  }

  Future<void> saveUserData(
      {required int userId, required String email}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("userId", userId);
    await prefs.setString("email", email);
    await prefs.setBool("isloggedIn", true);
  }

  Future<void> saveUserNameAndCompany(
      {required String userName,
      required String dbname,
      required String apiUrl,
      required String company}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", apiUrl);
    await prefs.setString("dbName", dbname);
    await prefs.setString("apiUrl", apiUrl);
    await prefs.setString("company", company);
  }
}
