import 'package:deliveryapp/login_module/view/login.dart';
import 'package:deliveryapp/app_confiq/app_colors.dart';
import 'package:deliveryapp/app_confiq/image.dart';
import 'package:deliveryapp/blocs/bloc/licence%20bloc/license_bloc.dart';
import 'package:deliveryapp/blocs/bloc/licence%20bloc/license_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.green.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocProvider(
              create: (context) => LicenseBloc(),
              child: LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _licenseController = TextEditingController();
  bool _isSubmitting = false;
  bool _isFailure = false;
  String _errorMessage = '';
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  // Helper method to get device ID
  String getDeviceId(dynamic deviceData) {
    if (deviceData is AndroidDeviceInfo) {
      return deviceData.id ?? deviceData.device ?? deviceData.model ?? '';
    } else if (deviceData is IosDeviceInfo) {
      return deviceData.identifierForVendor ??
          deviceData.name ??
          deviceData.systemName ??
          '';
    }
    return '';
  }

  Future<void> _checkLicense() async {
    setState(() {
      _isSubmitting = true;
      _isFailure = false;
    });

    final licenseCode = _licenseController.text.trim();

    if (licenseCode.isEmpty) {
      setState(() {
        _isSubmitting = false;
        _isFailure = true;
        _errorMessage = 'License code cannot be empty';
      });
      return;
    }

    // Get device information
    String deviceId = '';
    try {
      var deviceData = await deviceInfo.deviceInfo;
      deviceId = getDeviceId(deviceData);
    } catch (e) {
      setState(() {
        _isSubmitting = false;
        _isFailure = true;
        _errorMessage = 'Failed to get device info: $e';
      });
      return;
    }
    final url = Uri.parse(
      'http://test.equaleazy.com/App/Apiv1/RegisterDevice?DeviceCode=$licenseCode&MachineId=$deviceId',
    );

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Validate license code
        bool isLicenseValid = _validateLicenseCode(responseData, licenseCode);
        print(" f======>$isLicenseValid");

        if (isLicenseValid) {
          setState(() {
            _isSubmitting = false; // Reset submitting state
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()), // Next page
          );
        } else {
          setState(() {
            _isSubmitting = false;
            _isFailure = true;
            _errorMessage = 'Invalid License Code';
          });
        }
      } else {
        setState(() {
          _isSubmitting = false;
          _isFailure = true;
          _errorMessage = 'Failed to connect to the server';
        });
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false;
        _isFailure = true;
        _errorMessage = 'Error occurred: $e';
      });
    }
  }
  // Validate license code against response data
  bool _validateLicenseCode(
      Map<String, dynamic> responseData, String licenseCode) {
    if (responseData.containsKey('Company') &&
        responseData['Company'] != null &&
        responseData['Company']['Devices'] is List) {
      List devices = responseData['Company']['Devices'];

      return devices.any((device) =>
          device['DeviceCode'] == licenseCode &&
          device['IsRegistered'] == true);
    }
    return false; // Safeguard in case of missing keys
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LicenseBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SignInPage()), // Replace with your actual sign-in page
          );
        }
      },
      child: BlocBuilder<LicenseBloc, LoginState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Custom "AppBar" like container (Logo + Title)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.logo,
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Relief Medicals',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                // License Number Field
                TextField(
                  controller: _licenseController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: 'License Number',
                    prefixIcon: Icon(Icons.badge, color: Colors.blue),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.blue.shade50,
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isSubmitting
                      ? null
                      : () {
                          _checkLicense(); // Call API on button press
                        },
                  child: _isSubmitting
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                if (_isFailure)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
