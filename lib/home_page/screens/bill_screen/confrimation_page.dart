
// //   import 'package:flutter/material.dart';

// // void _showPaymentMethodDialog(BuildContext context) {
// //     final TextEditingController _cashController = TextEditingController();
// //     final TextEditingController _bankController = TextEditingController();

// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return StatefulBuilder(
// //           builder: (BuildContext context, StateSetter setState) {
// //             return Dialog(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(15),
// //               ),
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   gradient: LinearGradient(
// //                     colors: [AppColors.bottomclr, Colors.blue.shade400],
// //                     begin: Alignment.topLeft,
// //                     end: Alignment.bottomRight,
// //                   ),
// //                   borderRadius: BorderRadius.circular(15),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black26,
// //                       blurRadius: 15,
// //                       offset: Offset(0, 5),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(20),
// //                   child: Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: [
// //                       Text(
// //                         'Enter Payment Details',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 18,
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //                       SizedBox(height: 15),
// //                       TextField(
// //                         controller: _cashController,
// //                         keyboardType: TextInputType.number,
// //                         decoration: InputDecoration(
// //                           labelText: 'Cash Amount',
// //                           labelStyle: TextStyle(color: Colors.white),
// //                           filled: true,
// //                           fillColor: Colors.white.withOpacity(0.2),
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                           focusedBorder: OutlineInputBorder(
// //                             borderSide: BorderSide(color: Colors.white),
// //                           ),
// //                         ),
// //                         style: TextStyle(color: Colors.white),
// //                         onChanged: (value) {
// //                           setState(() {}); // Recalculate total amount on change
// //                         },
// //                       ),
// //                       SizedBox(height: 10),
// //                       TextField(
// //                         controller: _bankController,
// //                         keyboardType: TextInputType.number,
// //                         // coration: InputDecoration(
// //                           labelText: 'Bank Amount',
// //                           labelStyle: TextStyle(color: Colors.white),
// //                           filled: true,
// //                           fillColor: Colors.white.withOpacity(0.2),
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                           focusedBorder: OutlineInputBorder(
// //                             borderSide: BorderSide(color: Colors.white),
// //                           ),
// //                         ),
// //                         style: TextStyle(color: Colors.white),
// //                         onChanged: (value) {
// //                           setState(() {}); // Recalculate total amount on change
// //                         },
// //                       ),
// //                       SizedBox(height: 15),
                     
// //                       SizedBox(height: 15),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           TextButton(
// //                             onPressed: () => Navigator.pop(context),
// //                             child: Text(
// //                               'Cancel',
// //                               style: TextStyle(
// //                                   color: Colors.red,
// //                                   fontWeight: FontWeight.bold),
// //                             ),
// //                           ),
// //                           ElevatedButton(
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Colors.white,
// //                               foregroundColor: Colors.green.shade700,
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(10),
// //                               ),
// //                             ),
// //                             onPressed: () {
// //                               final String cashAmount =
// //                                   _cashController.text.trim();
// //                               final String bankAmount =
// //                                   _bankController.text.trim();

// //                               if (cashAmount.isEmpty && bankAmount.isEmpty) {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   SnackBar(
// //                                     content: Text(
// //                                         'Please enter at least one amount.'),
// //                                     backgroundColor: Colors.red,
// //                                     behavior: SnackBarBehavior.floating,
// //                                   ),
// //                                 );
// //                               } else if (bankAmount.isNotEmpty) {
// //                                 Navigator.pop(context);
// //                                 _showUPIQRCodeDialog(context);
// //                               } else {
// //                                 Navigator.pop(context);
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   SnackBar(
// //                                     content:
// //                                         Text('Payment saved successfully.'),
// //                                     backgroundColor: Colors.green,
// //                                     behavior: SnackBarBehavior.floating,
// //                                   ),
// //                                 );
// //                               }
// //                             },
// //                             child: Text(
// //                               'Save',
// //                               style: TextStyle(
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
//  Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Back Icon Button (on the left)
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context); // Go back to the previous screen
//                     },
//                     icon: Image.asset(
//                       AppImages
//                           .backbutton, // Replace with the actual path to your image
//                       height: 50, // Adjust the size as needed
//                       width: 60,
//                     ),
//                     iconSize:
//                         30, // IconButton size (optional, can be adjusted based on your image)
//                   ),
//                   // Other two icons (on the right)
//                   Row(
//                     // icons here
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           _showLocationUpdateDialog(context);
//                           // Add functionality for map icon
//                         },
//                         icon: Image.asset(
//                           AppImages
//                               .map, // Replace with the actual path to your image
//                           height: 50, // Adjust the size as needed
//                           width: 60,
//                         ),
//                         iconSize: 40,
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           // Add functionality for phone icon
//                         },
//                         icon: Image.asset(
//                           AppImages
//                               .phone, // Replace with the actual path to your image
//                           height: 50, // Adjust the size as needed
//                           width: 40,
//                         ),
//                         iconSize: 30,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),



      // appbar
  