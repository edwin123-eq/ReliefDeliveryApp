import 'package:deliveryapp/View/main_screen/main_screen.dart';
import 'package:deliveryapp/app_confiq/image.dart';
// import 'package:deliveryapp/home_page/screens/home_screen.dart';
// import 'package:deliveryapp/main.dart';
import 'package:flutter/material.dart';
import 'package:deliveryapp/app_confiq/app_colors.dart';

class BillPaymentPage extends StatelessWidget {
  final Map<String, String> bill;

  BillPaymentPage({Key? key, required this.bill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true,
          //  To allow scrolling when keyboard appears
          // appbar
    
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.fromLTRB(30, 0, 30, 0), // Adjust padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Icon Button (on the left)
                        IconButton(
                          onPressed: () {
                            Navigator.pop(
                                context); // Go back to the previous screen
                          },
                          icon: Image.asset(
                            AppImages
                                .backbutton, // Replace with the actual path to your image
                            height: 50, // Adjust the size as needed
                            width: 60,
                          ),
                          iconSize:
                              30, // IconButton size (optional, can be adjusted based on your image)
                        ),

                        // Other two icons (on the right)
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Add functionality for map icon
                              },
                              icon: Image.asset(
                                AppImages
                                    .upi, // Replace with the actual path to your image
                                height: 40, // Adjust the size as needed
                                width: 100,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${bill['name']}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.titleclr,
                    ),
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bill No: ${bill['billNo']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Address: ${bill['address']}',
                        style: TextStyle(fontSize: 18, color: AppColors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Phone: ${bill['phone']}',
                        style: TextStyle(fontSize: 18, color: AppColors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Number of Items: ${bill['numItems']}',
                        style: TextStyle(fontSize: 18, color: AppColors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Status: ${bill['status']}',
                        style: TextStyle(fontSize: 18, color: AppColors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Amt Received: ${bill['amtReceived']}',
                        style: TextStyle(fontSize: 18, color: AppColors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Mode: ${bill['mode']}',
                        style: TextStyle(fontSize: 18, color: AppColors.black),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                  SizedBox(height: 32), // Added space before payment details
                  // Blue Payment Box with title
                  Container(
                    color: AppColors.primary, // Light blue background
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Payment Details',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Cash',
                            hintText: 'Enter Cash Amount',
                            labelStyle: TextStyle(color: AppColors.black),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Bank',
                            hintText: 'Enter amount',
                            labelStyle: TextStyle(color: AppColors.black),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MainScreen()), // Replace with HomePage
                              );
                            },
                            child: Text('Save'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
