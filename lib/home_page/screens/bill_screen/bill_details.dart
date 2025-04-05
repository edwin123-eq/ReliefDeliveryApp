// import 'package:deliveryapp/View/main_screen/main_screen.dart';
// import 'package:deliveryapp/home_module/view/home_screen.dart';
// import 'package:deliveryapp/main.dart';
// import 'package:flutter/material.dart';
// import 'package:deliveryapp/app_confiq/app_colors.dart';
// import 'package:deliveryapp/app_confiq/image.dart';

// class BillDetailsPage extends StatefulWidget {
  
//   final Map<String, String> bill;
//   BillDetailsPage({Key? key, required this.bill}) : super(key: key);
//   @override
//   State<BillDetailsPage> createState() => _BillDetailsPageState();
// }

// class _BillDetailsPageState extends State<BillDetailsPage> {
//   bool _isPartialReasonVisible = false;
//   bool _isreturnReasonVisible = false;
//   bool isPaymentSaved = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset:
//           true, // Ensure resizing when the keyboard appears
//       // APP BAR Start

//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(200),
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               color: AppColors.primary,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(16.0),
//                 bottomRight: Radius.circular(16.0),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 40),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
//                         child: Image.asset(
//                           AppImages.logo,
//                           height: 60,
//                           width: 60,
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Relief Medicals',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             'Delivery App',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.white70,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
//                     child: Card(
//                       color: Colors.white,
//                       elevation: 2,
//                       margin: EdgeInsets.zero,
//                       child: Container(
//                         height: 60,
//                         alignment: Alignment.center,
//                         child: Text(
//                           'Delivery Rider: Sreesh K Suresh',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.textname,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       // Bill Details
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 30), // Padding for the sides
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // row icons
//               Row(
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

//               // person name
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 20),
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color.fromARGB(255, 59, 59, 59)
//                           .withOpacity(0.5),
//                       spreadRadius: 3,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('${widget.bill['name']}',
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.primary,
//                         )),
//                     SizedBox(height: 10),
//                     _buildDetailRow('Bill No:', widget.bill['billNo'],
//                         isBold: true),
//                     SizedBox(height: 5),
//                     _buildDetailRow('Address:', widget.bill['address']),
//                     SizedBox(height: 5),
//                     _buildDetailRow('Phone:', widget.bill['phone']),
//                     SizedBox(height: 5),
//                     _buildDetailRow(
//                         'Number of Items:', widget.bill['numItems']),
//                     SizedBox(height: 5),
//                     _buildDetailRow('Status:', widget.bill['status']),
//                     SizedBox(height: 5),
//                     _buildDetailRow(
//                         'Amt Received:', '\u20B9 ${widget.bill['amtReceived']}',
//                         isBold: true),
//                     SizedBox(height: 5),
//                     _buildDetailRow('Payment Mode:', widget.bill['mode']),
//                   ],
//                 ),
//               ),
//               // Person's Name

//               SizedBox(height: 16),

//               // Only show buttons if the status is not 'Delivered'
//               if (widget.bill['status'] != 'Delivered' &&
//                   widget.bill['status'] != 'Partially Delivered') ...[
//                 // Delivered Button
//                 Center(
//                   child: Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage(AppImages.button),
//                             fit: BoxFit.cover,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: const Color.fromARGB(255, 127, 129, 122)
//                                   .withOpacity(0.5),
//                               spreadRadius: 3,
//                               blurRadius: 5,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () => _showConfirmationDialog(context),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 40, vertical: 15),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: Text(
//                             'Delivered',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       // Partially Delivered and Returned Buttons
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Container(
//                               margin: EdgeInsets.only(right: 10),
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image: AssetImage(AppImages.button),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color:
//                                         const Color.fromARGB(255, 127, 129, 122)
//                                             .withOpacity(0.5),
//                                     spreadRadius: 3,
//                                     blurRadius: 5,
//                                     offset: Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                               child: ElevatedButton(
//                                 onPressed: () =>
//                                     _showPartiallyDeliveredDialog(context),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   shadowColor: Colors.transparent,
//                                   padding: EdgeInsets.symmetric(vertical: 15),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   'Partially Delivered',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               margin: EdgeInsets.only(left: 10),
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image: AssetImage(AppImages.button),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color:
//                                         const Color.fromARGB(255, 127, 129, 122)
//                                             .withOpacity(0.5),
//                                     spreadRadius: 3,
//                                     blurRadius: 5,
//                                     offset: Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   _showReturnDialog(context);
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   shadowColor: Colors.transparent,
//                                   padding: EdgeInsets.symmetric(vertical: 15),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   'Returned',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ] // End of condition
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // location

// // Partially Delivered Dialog
//   void _showPartiallyDeliveredDialog(BuildContext context) {
//     TextEditingController reasonController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white, // Plain white background
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2), // Subtle shadow
//                   blurRadius: 8,
//                   offset: Offset(2, 4),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min, // Adjust size based on content
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(Icons.delivery_dining,
//                           color: Colors.green, size: 40),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           'Confirm that the order has been partially delivered.',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 15),
//                   TextField(
//                     controller: reasonController,
//                     decoration: InputDecoration(
//                       hintText: 'Enter reason',
//                       filled: true,
//                       fillColor:
//                           Colors.grey[100], // Slightly off-white for input
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.green),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   // Only show these buttons if the reason is not entered
//                   if (reasonController.text.isEmpty)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         // Cancel Button
//                         TextButton(
//                           onPressed: () =>
//                               Navigator.pop(context), // Close dialog
//                           child: Text(
//                             'Cancel',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         // Submit Button (only shows when reason is not entered)
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           onPressed: () {
//                             if (reasonController.text.isNotEmpty) {
//                               // If there's a reason, proceed to next step
//                               Navigator.pop(
//                                   context); // Close the current dialog

//                               // Update the status to "Partially Delivered"
//                               setState(() {
//                                 widget.bill['status'] =
//                                     "Partially Delivered"; // Update the status
//                               });

//                               _showPaymentMethodDialog_inPD(
//                                   context); // Show next dialog
//                             } else {
//                               // If no reason entered, show a message
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                       'Please enter a reason before confirming.'),
//                                   backgroundColor: Colors.red,
//                                   behavior: SnackBarBehavior.floating,
//                                 ),
//                               );
//                             }
//                           },
//                           child: Text(
//                             'Submit',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                   // If a reason is entered, only show the Submit button to proceed
//                   if (reasonController.text.isNotEmpty)
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () {
//                         // Once reason is entered, proceed with payment flow
//                         Navigator.pop(context); // Close dialog

//                         // Update the status to "Partially Delivered"
//                         setState(() {
//                           widget.bill['status'] =
//                               "Partially Delivered"; // Update the status
//                         });

//                         _showPaymentMethodDialog_inPD(
//                             context); // Show next dialog
//                       },
//                       child: Text(
//                         'Proceed to Payment',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

// // return dailoge here
//   Widget _buildReasonInput(BuildContext context) {
//     final TextEditingController _controller = TextEditingController();
//     bool _isTextEntered = false;

//     return StatefulBuilder(
//       builder: (BuildContext context, StateSetter setState) {
//         return Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Enter reason here...',
//                       hintStyle: TextStyle(color: Colors.grey),
//                       border: InputBorder.none,
//                     ),
//                     onChanged: (text) {
//                       setState(() {
//                         _isTextEntered = text.isNotEmpty;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8),
//               if (_isTextEntered)
//                 IconButton(
//                   onPressed: () {
//                     // Add functionality for tick button
//                     print("Reason entered: ${_controller.text}");
//                   },
//                   icon: Image.asset(
//                     AppImages.tik,
//                     height: 20,
//                     width: 20,
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Method to build the action button for Partially Delivered and Returned
//   Widget _buildActionButton(String label, VoidCallback onPressed) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.green, Colors.yellow],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         ),
//         child: Text(label, style: TextStyle(color: Colors.white)),
//       ),
//     );
//   }

// // reason here

//   // Method to build the reason input field with a green tick button

//   void _showConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm the Delivery'),
//           content: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Icon(Icons.delivery_dining, color: Colors.green, size: 40),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Text('Confirm that the order has been delivered.'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context), // Close the dialog
//               child: Text('Cancel', style: TextStyle(color: Colors.red)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the confirmation dialog
//                 _showPaymentMethodDialog(
//                     context); // Show the payment method dialog
//               },
//               child: Text('Confirm', style: TextStyle(color: Colors.green)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showPaymentMethodDialog(BuildContext context) {
//     TextEditingController _cashController = TextEditingController();
//     TextEditingController _bankController = TextEditingController();
//     double totalAmount = 0.0;
//     final double Amount = double.tryParse(
//             widget.bill['amtReceived']?.replaceAll('Rs: ', '') ?? '0.0') ??
//         0.0;
//     // To track total payment amount

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 8,
//                       offset: Offset(2, 4),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.payment, color: Colors.green, size: 40),
//                           SizedBox(width: 10),
//                           Expanded(
//                             child: Text(
//                               'Enter Payment Details',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           Visibility(
//                             visible: !isPaymentSaved,
//                             child: IconButton(
//                               icon: Image.asset(
//                                 AppImages.upi,
//                                 width: 50,
//                                 height: 50,
//                               ),
//                               iconSize: 30,
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 _showUPIQRCodeDialog(context);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 15),
//                       TextField(
//                         controller: _cashController,
//                         decoration: InputDecoration(
//                           labelText: 'Cash Amount',
//                           filled: true,
//                           fillColor: Colors.grey[100],
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         keyboardType: TextInputType.number,
//                         onChanged: (value) {
//                           setState(() {
//                             double cashAmount = double.tryParse(value) ?? 0.0;
//                             double bankAmount =
//                                 double.tryParse(_bankController.text) ?? 0.0;
//                             totalAmount = cashAmount + bankAmount;
//                           });
//                         },
//                       ),
//                       SizedBox(height: 15),
//                       TextField(
//                         controller: _bankController,
//                         decoration: InputDecoration(
//                           labelText: 'Bank Amount',
//                           filled: true,
//                           fillColor: Colors.grey[100],
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         keyboardType: TextInputType.number,
//                         onChanged: (value) {
//                           setState(() {
//                             double cashAmount =
//                                 double.tryParse(_cashController.text) ?? 0.0;
//                             double bankAmount = double.tryParse(value) ?? 0.0;
//                             totalAmount = cashAmount + bankAmount;
//                           });
//                         },
//                       ),
//                       SizedBox(height: 15),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Total Amount :',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             totalAmount.toStringAsFixed(2),
//                             style: TextStyle(
//                               color: Colors.green,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         'Amount: ₹${Amount.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: Text(
//                               'Cancel',
//                               style: TextStyle(
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               final double cashAmount = double.tryParse(
//                                       _cashController.text.trim()) ??
//                                   0.0;
//                               final double bankAmount = double.tryParse(
//                                       _bankController.text.trim()) ??
//                                   0.0;
//                               double totalPayment = cashAmount + bankAmount;

//                               if (totalPayment.toStringAsFixed(0) ==
//                                   widget.bill['amtReceived']) {
//                                 if (bankAmount > 0) {
//                                   Navigator.pop(context);
//                                   _showUPIQRCodeDialog(context);
//                                 } else {
//                                   Navigator.pop(context);
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content:
//                                           Text('Payment saved successfully.'),
//                                       backgroundColor: Colors.green,
//                                       behavior: SnackBarBehavior.floating,
//                                     ),
//                                   );
//                                 }

//                                 setState(() {
//                                   widget.bill['mode'] = (cashAmount > 0 &&
//                                           bankAmount > 0)
//                                       ? 'C:${cashAmount.toStringAsFixed(2)}, B:${bankAmount.toStringAsFixed(2)}'
//                                       : (cashAmount > 0
//                                           ? 'C:${cashAmount.toStringAsFixed(2)}'
//                                           : 'B:${bankAmount.toStringAsFixed(2)}');
//                                   widget.bill['status'] = "Delivered";
//                                   isPaymentSaved = true;
//                                 });

//                                 // Navigate to the Home Page
//                                 Navigator.pop(context);
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => MainScreen()),
//                                 );
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text(
//                                         'Total payment does not match the received amount.'),
//                                     backgroundColor: Colors.red,
//                                     behavior: SnackBarBehavior.floating,
//                                   ),
//                                 );
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green,
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: Text(
//                               'Save Payment',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   void _showPaymentMethodDialog_inPD(BuildContext context) {
//     TextEditingController _cashController = TextEditingController();
//     TextEditingController _bankController = TextEditingController();
//     final double totalAmount = double.tryParse(
//             widget.bill['amtReceived']?.replaceAll('Rs: ', '') ?? '0.0') ??
//         0.0;

//     // Example total amount
//     ValueNotifier<double> amountToPay =
//         ValueNotifier<double>(0.0); // For real-time updates

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2), // Subtle shadow
//                   blurRadius: 8,
//                   offset: Offset(2, 4),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Header with UPI icon
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(Icons.payment, color: Colors.green, size: 40),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           'Enter Payment Details',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Image.asset(
//                           AppImages.upi,
//                           width: 50,
//                           height: 50,
//                         ),
//                         onPressed: () {
//                           Navigator.pop(context);
//                           _showUPIQRCodeDialog_inPD(context); // Show QR Code
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 15),

//                   // Cash Input
//                   TextField(
//                     controller: _cashController,
//                     decoration: InputDecoration(
//                       labelText: 'Cash Amount',
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     keyboardType: TextInputType.number,
//                     onChanged: (value) {
//                       final cashAmount =
//                           double.tryParse(value.trim()) ?? 0.0; // Parse cash
//                       final bankAmount =
//                           double.tryParse(_bankController.text.trim()) ??
//                               0.0; // Parse bank
//                       amountToPay.value =
//                           cashAmount + bankAmount; // Update total paid
//                     },
//                   ),
//                   SizedBox(height: 15),

//                   // Bank Input
//                   TextField(
//                     controller: _bankController,
//                     decoration: InputDecoration(
//                       labelText: 'Bank Amount',
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     keyboardType: TextInputType.number,
//                     onChanged: (value) {
//                       final bankAmount =
//                           double.tryParse(value.trim()) ?? 0.0; // Parse bank
//                       final cashAmount =
//                           double.tryParse(_cashController.text.trim()) ??
//                               0.0; // Parse cash
//                       amountToPay.value =
//                           cashAmount + bankAmount; // Update total paid
//                     },
//                   ),
//                   SizedBox(height: 20),

//                   // Total Amount and Amount to Pay
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Total Amount: ₹${totalAmount.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       ValueListenableBuilder<double>(
//                         valueListenable: amountToPay,
//                         builder: (context, value, child) {
//                           return Text(
//                             'Amount to Pay: ₹${value.toStringAsFixed(2)}',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.blue,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),

//                   // Action Buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       // Cancel Button
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: Text(
//                           'Cancel',
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),

//                       // Save Button
//                       ElevatedButton(
//                         onPressed: () {
//                           final double cashAmount =
//                               double.tryParse(_cashController.text.trim()) ??
//                                   0.0;
//                           final double bankAmount =
//                               double.tryParse(_bankController.text.trim()) ??
//                                   0.0;

//                           if (cashAmount == 0 && bankAmount == 0) {
//                             // Show error if no amounts are entered
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   'Please enter at least one amount.',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 backgroundColor: Colors.red,
//                                 behavior: SnackBarBehavior.floating,
//                               ),
//                             );
//                           } else {
//                             // Update payment mode with formatted string
//                             setState(() {
//                               widget.bill['mode'] = (cashAmount > 0 &&
//                                       bankAmount > 0)
//                                   ? 'C:${cashAmount.toStringAsFixed(2)}, B:${bankAmount.toStringAsFixed(2)}'
//                                   : (cashAmount > 0
//                                       ? 'C:${cashAmount.toStringAsFixed(2)}'
//                                       : 'B:${bankAmount.toStringAsFixed(2)}');

//                               widget.bill['status'] = "Partially Delivered";
//                               isPaymentSaved = true;
//                             });

//                             // Show success message
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   'Payment saved successfully.',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 backgroundColor: Colors.green,
//                                 behavior: SnackBarBehavior.floating,
//                               ),
//                             );

//                             // Navigate to Home Page
//                             Navigator.pop(context); // Close dialog
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => MainScreen(),
//                               ),
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Text(
//                           'Save Payment',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showReturnDialog(BuildContext context) {
//     TextEditingController reasonController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           backgroundColor: Colors.white, // Dialog background color
//           title: Text(
//             'Confirm Return',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.black54,
//             ),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min, // Adjust the size based on content
//             children: [
//               Text(
//                 'Are you sure you want to return this item?',
//                 style: TextStyle(color: Colors.black45),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: reasonController,
//                 decoration: InputDecoration(
//                   hintText: 'Enter reason for return',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue.shade400),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             // Cancel Button
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               // Close the dialog
//               child: Text(
//                 'Cancel',
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Confirm Button
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.green.shade700,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               onPressed: () {
//                 // Update bill status to 'Returned' and add the reason

//                 if (reasonController.text.isNotEmpty) {
//                   // Proceed with the return confirmation
//                   Navigator.pop(context); // Close the dialog
//                   Navigator.pop(context); // Navigate back to the main screen
//                 } else {
//                   // Show a message if no reason was provided
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Please provide a reason for the return'),
//                       backgroundColor: Colors.red,
//                       behavior: SnackBarBehavior.floating,
//                     ),
//                   );
//                 }
//               },
//               child: Text(
//                 'Confirm',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showUPIQRCodeDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           backgroundColor: Colors.transparent, // Make the dialog transparent
//           content: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.green.shade400, Colors.blue.shade400],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 15,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Scan UPI QR Code',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     'Please scan the QR code to complete the payment.',
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     height: 200,
//                     width: 200,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 10,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         'QR Code Placeholder',
//                         style: TextStyle(color: Colors.white70),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the QR code dialog
//                 _showPaymentMethodDialog(
//                     context); // Reopen the payment details dialog
//               },
//               child: Text(
//                 'Back',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue.shade700,
//                 ),
//               ),
//             ),
//             // ElevatedButton(
//             //   style: ElevatedButton.styleFrom(
//             //     backgroundColor: Colors.white,
//             //     foregroundColor: Colors.green.shade700,
//             //     shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(10),
//             //     ),
//             //   ),
//             //   onPressed: () => Navigator.pop(context), // Close the dialog
//             //   child: Text(
//             //     'Payment Saved',
//             //     style: TextStyle(fontWeight: FontWeight.bold),
//             //   ),
//             // ),
//           ],
//         );
//       },
//     );
//   }

//   void _showUPIQRCodeDialog_inPD(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           backgroundColor: Colors.transparent, // Make the dialog transparent
//           content: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.green.shade400, Colors.blue.shade400],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 15,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Scan UPI QR Code',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     'Please scan the QR code to complete the payment.',
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     height: 200,
//                     width: 200,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 10,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         'QR Code Placeholder',
//                         style: TextStyle(color: Colors.white70),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the QR code dialog
//                 _showPaymentMethodDialog_inPD(
//                     context); // Reopen the payment details dialog
//               },
//               child: Text(
//                 'Back',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                   color: AppColors.white,
//                 ),
//               ),
//             ),
//             // ElevatedButton(
//             //   style: ElevatedButton.styleFrom(
//             //     backgroundColor: Colors.white,
//             //     foregroundColor: Colors.green.shade700,
//             //     shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(10),
//             //     ),
//             //   ),
//             //   onPressed: () => Navigator.pop(context), // Close the dialog
//             //   child: Text(
//             //     'Payment Saved',
//             //     style: TextStyle(fontWeight: FontWeight.bold),
//             //   ),
//             // ),
//           ],
//         );
//       },
//     );
//   }

//   void _showLocationUpdateDialog(BuildContext context) {
//     // This is the function that shows the location update dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Update Your Location'),
//           content:
//               Text('Would you like to update your location to this place?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context), // Close the dialog
//               child: Text('Cancel', style: TextStyle(color: Colors.red)),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Here you can set the logic to update the location
//                 // For now, it just closes the dialog and shows a message
//                 Navigator.pop(context); // Close the dialog
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Location updated!')),
//                 );
//               },
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//               child: Text('Update Location',
//                   style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   _buildDetailRow(String label, String? value, {bool isBold = false}) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: AppColors.black,
//           ),
//         ),
//         SizedBox(width: 5), // Space between label and value
//         Expanded(
//           child: Text(
//             value ?? '',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//               color: AppColors.black,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
