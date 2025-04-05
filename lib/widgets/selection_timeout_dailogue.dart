import 'package:deliveryapp/View/first%20logins/license_page.dart';
import 'package:deliveryapp/login_module/view/login.dart';
import 'package:flutter/material.dart';

void showSessionTimeoutDialog(BuildContext context) {
  showDialog(
    //barrierColor: Colors.red,
    context: context,
    barrierDismissible:
        false, // Prevent dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            const Text(
              'Session Timeout',
              style: TextStyle(color: Color.fromARGB(255, 220, 5, 66)),
            ),
          ],
        ),
        content: const Text(
          'Your session has expired. Please log in again.',
          style: TextStyle(
              color: Color.fromARGB(255, 220, 5, 66),
              fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              // Redirect to the login page or perform other actions
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            child: const Text(
              'LogIn',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
