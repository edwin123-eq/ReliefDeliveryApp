import 'package:deliveryapp/Get_c_loc/bloc/bloc/location_bloc_bloc.dart';
import 'package:deliveryapp/Get_c_loc/view/simple_map.dart';
import 'package:deliveryapp/app_confiq/permission_handler.dart';
import 'package:deliveryapp/bill_details_module/bloc/bill_details_bloc.dart';
import 'package:deliveryapp/bill_details_module/bloc/bill_details_event.dart';
import 'package:deliveryapp/bill_details_module/controller/bill_details_repo.dart';
import 'package:deliveryapp/bill_details_module/upi%20bloc/bloc/upi_bloc_bloc.dart';
import 'package:deliveryapp/bill_details_module/upi%20bloc/bloc/upi_bloc_event.dart';
import 'package:deliveryapp/bill_details_module/upi%20bloc/bloc/upi_bloc_state.dart';
import 'package:deliveryapp/blocs/Whatsapp_bloc/bloc/whats_app_message_bloc_bloc.dart';
import 'package:deliveryapp/update_delivery_bill/bloc/update_bill_bloc.dart';
import 'package:deliveryapp/update_delivery_bill/bloc/update_bill_event.dart';
import 'package:deliveryapp/update_delivery_bill/bloc/update_bill_state.dart';
import 'package:deliveryapp/update_delivery_bill/controller/update_bill_repo.dart';
import 'package:deliveryapp/update_delivery_bill/model/update_bill.dart';
import 'package:deliveryapp/update_location/bloc/bloc/update_cs_location_event.dart';
import 'package:deliveryapp/update_location/bloc/bloc/update_cs_location_state.dart';
import 'package:deliveryapp/update_location/controller/update_loc.dart';
import 'package:deliveryapp/Get_c_loc/view/customer_location_map.dart';
import 'package:deliveryapp/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:deliveryapp/app_confiq/app_colors.dart';
import 'package:deliveryapp/app_confiq/image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../View/main_screen/main_screen.dart';
import '../../blocs/section_timeout/bloc/session_time_out_bloc.dart';
import '../../update_location/bloc/bloc/update_cs_location_bloc.dart';
import '../bloc/bill_details_state.dart';
import '../model/bill_details_model.dart';

class BillDetailsPage extends StatefulWidget {
  final int customerId;
  final String dlSaleId;
  final String dlEmpId;
  final String riderName;

  BillDetailsPage(
      {Key? key,
      required this.customerId,
      required this.dlSaleId,
      required this.dlEmpId,
      required this.riderName})
      : super(key: key);

  @override
  State<BillDetailsPage> createState() => _BillDetailsPageState();
}

class _BillDetailsPageState extends State<BillDetailsPage> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch $phoneNumber';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error making phone call: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool _isPartialReasonVisible = false;
  bool _isreturnReasonVisible = false;
  bool isPaymentSaved = false;
  final LocationPermissionService _locationPermissionService =
      LocationPermissionService();
  bool _locationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    final locationBloc = BlocProvider.of<LocationBlocBloc>(context);
    locationBloc.add(GetLocation(customerId: widget.customerId));
    final sessionTimeOutBloc = BlocProvider.of<BillDetailsBloc>(context);
    sessionTimeOutBloc.add(
        FetchBillDetails(dlSaleId: widget.dlSaleId, dlEmpId: widget.dlEmpId));
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      // Request permission
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      print('Location permission granted');
    } else if (status.isPermanentlyDenied) {
      print('Permission permanently denied, please enable it from settings.');
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: Image.asset(
                          AppImages.logo,
                          height: 60,
                          width: 60,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Relief Medicals',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Delivery App',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      margin: EdgeInsets.zero,
                      child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'Delivery Rider: ${widget.riderName}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textname,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<BillDetailsBloc, BillDetailsState>(
        builder: (context, state) {
          if (state is BillDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BillDetailsLoaded) {
            return _buildBillDetails(
              state.billDetails,
            );
          } else if (state is BillDetailsError) {
            return Center(child: Text('Something went wrong'));
          }
          return Center(child: Text('No data available'));
        },
      ),
    );
  }

  Widget _buildBillDetails(BillDetailsModel bill) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIconRow(bill),
            _buildBillInfoCard(bill),
            SizedBox(height: 16),
            if (bill.status != 1 && bill.status != 3 && bill.status != 2) ...[
              _buildActionButtons(bill.amtReceived, bill),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildIconRow(BillDetailsModel bill) {
    return BlocBuilder<LocationBlocBloc, LocationBlocState>(
      builder: (context, state) {
        if (state is CustomerLocationSuccessState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(AppImages.backbutton, height: 50, width: 60),
                iconSize: 30,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      LocationPermission permission =
                          await Geolocator.checkPermission();
                      // _showLocationUpdateDialog(context);
                      if (state.locdetails.latitude != "" &&
                          state.locdetails.longitude != "") {
                        if (state.locdetails.latitude != null &&
                            state.locdetails.longitude != null) {
                          //        Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => CustomerLocationMap(
                          //           cusLatitude: state.locdetails.latitude!,
                          //           cusLongitude: state.locdetails.longitude!, deliverPartner: widget.riderName,)),
                          // );
                          //    Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => LocationExample()
                          //       ),
                          // );
                          if (permission == LocationPermission.denied) {
                            permission = await Geolocator.requestPermission();
                            if (permission ==
                                LocationPermission.deniedForever) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Location permissions are permanently denied.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                          }

                          // Get current location
                          Position position =
                              await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high);

                          double latitude = position.latitude;
                          double longitude = position.longitude;

                          String googleMapsUrl =
                              "https://maps.google.com/maps?saddr=$latitude,$longitude&daddr=${state.locdetails.latitude},${state.locdetails.longitude}";

                          Uri url = Uri.parse(googleMapsUrl);

                          // Launch Google Maps
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode
                                    .externalApplication); // Opens in the Google Maps app
                          } else {
                            throw "Could not open the map.";
                          }
                        } else {
                          print("Location Is null=================>1");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Customer Location is not available'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        print("Location Is null=================>");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Customer Location is not available'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: Image.asset(AppImages.map, height: 50, width: 60),
                    iconSize: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      if (bill.phoneNumber != null &&
                          bill.phoneNumber!.isNotEmpty) {
                        _makePhoneCall(bill.phoneNumber!);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('No phone number available'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: Image.asset(AppImages.phone, height: 50, width: 40),
                    iconSize: 30,
                  ),
                ],
              ),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(AppImages.backbutton, height: 50, width: 60),
                iconSize: 30,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (bill.phoneNumber != null &&
                          bill.phoneNumber!.isNotEmpty) {
                        _makePhoneCall(bill.phoneNumber!);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('No phone number available'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: Image.asset(AppImages.phone, height: 50, width: 40),
                    iconSize: 30,
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildBillInfoCard(BillDetailsModel bill) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 59, 59, 59).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display customer name in bold
          Text(bill.customerName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              )),
          SizedBox(height: 10),
          // Bill details
          _buildDetailRow('Bill No:', bill.docNum, isBold: true),
          SizedBox(height: 5),
          _buildDetailRow('Address:', bill.address),
          SizedBox(height: 5),
          _buildDetailRow('Phone:', bill.phoneNumber),
          SizedBox(height: 5),
          _buildDetailRow('Number of Items:', bill.quantity.toString()),
          SizedBox(height: 5),
          _buildDetailRow('Status:', _getStatusString(bill.status)),
          SizedBox(height: 5),
          _buildDetailRow(
              'Amt Received:', '\u20B9 ${bill.amtReceived.toStringAsFixed(2)}',
              isBold: true),
          // Conditionally display payment mode details
          if (bill.totalCashReceived > 0 || bill.totalBankReceived > 0)
            _buildDetailRow(
              'Payment Mode:',
              '${bill.totalCashReceived > 0 ? 'C: \u20B9 ${bill.totalCashReceived.toStringAsFixed(2)}' : ''}'
                  '${bill.totalCashReceived > 0 && bill.totalBankReceived > 0 ? ', ' : ''}'
                  '${bill.totalBankReceived > 0 ? 'B: \u20B9 ${bill.totalBankReceived.toStringAsFixed(2)}' : ''}',
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        Text(
          value ?? 'N/A',
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(double amount, BillDetailsModel bill) {
    return Center(
      child: Column(
        children: [
          _buildButton('Delivered',
              () => _showConfirmationDialog(context, amount, bill)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildButton('Partial Delivery',
                    () => _showPartiallyDeliveredDialog(context, amount, bill),
                    isSmall: true),
              ),
              SizedBox(width: 20),
              Expanded(
                child: _buildButton(
                    'Returned', () => _showReturnDialog(context, bill),
                    isSmall: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed,
      {bool isSmall = false}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.button),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 127, 129, 122).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding:
              EdgeInsets.symmetric(horizontal: isSmall ? 20 : 40, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: isSmall ? 14 : 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String _getStatusString(int status) {
    switch (status) {
      case 4:
        return 'Pending';
      case 1:
        return 'Delivered';
      case 3:
        return 'Partially Delivered';
      case 2:
        return 'Returned';
      default:
        return 'Unknown';
    }
  }

  // location

// Partially Delivered Dialog
  // Partially Delivered Dialog
  void _showPartiallyDeliveredDialog(
      BuildContext context, double amount, BillDetailsModel bill) {
    TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.delivery_dining,
                            color: Colors.green,
                            size: 40,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Confirm Partial Delivery',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Please provide a reason for partial delivery:',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: reasonController,
                        onChanged: (value) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Enter reason',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: reasonController.text.isNotEmpty
                                ? () {
                                    String remarks = reasonController.text;
                                    _showPaymentMethodDialog_inPD(
                                        context, amount, bill, remarks);

                                    // print(
                                    //     'Reason Submitted: ${reasonController.text}');
                                    // Navigator.pop(context);
                                  }
                                : null, // Disable if reason is empty
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              disabledBackgroundColor: Colors.grey[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

// return dailoge here
  Widget _buildReasonInput(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    bool _isTextEntered = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter reason here...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      setState(() {
                        _isTextEntered = text.isNotEmpty;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(width: 8),
              if (_isTextEntered)
                IconButton(
                  onPressed: () {
                    // Add functionality for tick button
                    print("Reason entered: ${_controller.text}");
                  },
                  icon: Image.asset(
                    AppImages.tik,
                    height: 20,
                    width: 20,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Method to build the action button for Partially Delivered and Returned
  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.yellow],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(label, style: TextStyle(color: Colors.white)),
      ),
    );
  }

// reason here

  // Method to build the reason input field with a green tick button
  void _showConfirmationDialog(
      BuildContext context, double amount, BillDetailsModel bill) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text('Confirm the Delivery'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.delivery_dining, color: Colors.green, size: 40),
              SizedBox(width: 10),
              Expanded(
                child: Text('Confirm that the order has been delivered.'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the confirmation dialog
                showPaymentMethodDialog(
                    context, amount, bill // Pass the amount parameter
                    );
              },
              child: Text('Confirm', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  void showPaymentMethodDialog(
      BuildContext context, double amount, BillDetailsModel bill) {
    final cashController = TextEditingController();
    final bankController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final dialogContext = context; // Ensure proper context usage
        return BlocProvider(
          create: (context) => UpdateDeliveryBloc(
            repository: UpdateDeliveryRepository(),
          ),
          child: BlocConsumer<UpdateDeliveryBloc, UpdateDeliveryState>(
            listener: (context, state) {
              if (state is UpdateDeliverySuccess) {
                final sessionTimeOutBloc =
                    BlocProvider.of<WhatsAppMessageBlocBloc>(context);

                sessionTimeOutBloc.add(WhatAppMsgSendingEvent(
                    mobileNo: bill.phoneNumber,
                    message:
                        "Your Order has been Delivered. Thank you for shopping with us."));
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Payment successful')),
                // );
                snackBarWidget(
                  msg: "Payment saved is successfully",
                  icons: Icons.verified,
                  iconcolor: Colors.green,
                  texcolor: Colors.green,
                  backgeroundColor: Colors.white,
                  context: context,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => MainScreen()),
                );
              } else if (state is UpdateDeliveryFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment failed: ${state.error}')),
                );
              }
            },
            builder: (context, state) {
              return StatefulBuilder(
                builder: (context, setState) {
                  final cashAmount =
                      double.tryParse(cashController.text) ?? 0.0;
                  final bankAmount =
                      double.tryParse(bankController.text) ?? 0.0;
                  final totalPayment = cashAmount + bankAmount;

                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header with UPI icon
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.payment,
                                    color: Colors.green, size: 40),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Enter Payment Details',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(dialogContext);
                                      _showUPIQRCodeDialog(
                                        dialogContext,
                                        bill,
                                        amount,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        AppImages.upi,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),

                            // Cash Input Field
                            TextField(
                              controller: cashController,
                              decoration: InputDecoration(
                                labelText: 'Cash Amount',
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon:
                                    Icon(Icons.money, color: Colors.green),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (_) => setState(() {}),
                            ),
                            SizedBox(height: 15),

                            // Bank Input Field
                            TextField(
                              controller: bankController,
                              decoration: InputDecoration(
                                labelText: 'Bank Amount',
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.account_balance,
                                    color: Colors.green),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (_) => setState(() {}),
                            ),
                            SizedBox(height: 20),

                            // Amount Display Section
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Amount:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      Text(
                                        '₹${amount.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Amount Entered:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      Text(
                                        '₹${totalPayment.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: totalPayment == amount
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),

                            if (state is UpdateDeliveryLoading)
                              CircularProgressIndicator()
                            else
                              // Action Buttons
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: totalPayment == amount
                                        ? () async {
                                            final locationBloc = LocationBloc(
                                              repository: LocationRepository(),
                                            );
                                            locationBloc.add(
                                                GetCurrentLocationRequested());

                                            locationBloc.stream.listen((state) {
                                              if (state
                                                  is LocationUpdateSuccess) {
                                                // bill.mode = (cashAmount > 0 &&
                                                //         bankAmount > 0)
                                                //     ? 'C:${cashAmount.toStringAsFixed(2)}, B:${bankAmount.toStringAsFixed(2)}'
                                                //     : (cashAmount > 0
                                                //         ? 'C:${cashAmount.toStringAsFixed(2)}'
                                                //         : 'B:${bankAmount.toStringAsFixed(2)}');

                                                context
                                                    .read<UpdateDeliveryBloc>()
                                                    .add(
                                                        UpdateDeliveryRequested(
                                                            bill,
                                                            cashAmount,
                                                            bankAmount,
                                                            1,
                                                            ""));
                                              } else if (state
                                                  is LocationUpdateFailure) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(state.error),
                                                ));
                                              }
                                            });
                                          }
                                        : null,
                                    child: const Text('Confirm Payment'),
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

void _showPaymentMethodDialog_inPD(BuildContext context, double amount,
    BillDetailsModel bill, String remarks) {
  final cashController = TextEditingController();
  final bankController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => UpdateDeliveryBloc(
          repository: UpdateDeliveryRepository(),
        ),
        child: BlocConsumer<UpdateDeliveryBloc, UpdateDeliveryState>(
          listener: (context, state) {
            if (state is UpdateDeliverySuccess) {
              final sessionTimeOutBloc =
                  BlocProvider.of<WhatsAppMessageBlocBloc>(context);

              sessionTimeOutBloc.add(WhatAppMsgSendingEvent(
                  mobileNo: bill.phoneNumber,
                  message:
                      "Your Order has been Partially Delivered. Thank you for shopping with us."));
              snackBarWidget(
                msg: "Payment saved successfully",
                icons: Icons.verified,
                iconcolor: Colors.green,
                texcolor: Colors.green,
                backgeroundColor: Colors.white,
                context: context,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MainScreen()),
              );
            } else if (state is UpdateDeliveryFailure) {
              snackBarWidget(
                msg: "Payment saved is failed",
                icons: Icons.error,
                iconcolor: Colors.red,
                texcolor: Colors.red,
                backgeroundColor: Colors.white,
                context: context,
              );
            }
          },
          builder: (context, state) {
            return StatefulBuilder(
              builder: (context, setState) {
                final cashAmount = double.tryParse(cashController.text) ?? 0.0;
                final bankAmount = double.tryParse(bankController.text) ?? 0.0;
                final totalPayment = cashAmount + bankAmount;

                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header with UPI icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.payment,
                                  color: Colors.green, size: 40),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Enter Payment Details',
                                  style: TextStyle(
                                    color: AppColors.textname,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _showUPIQRCodeDialog_inPD(
                                        context, bill, amount, remarks);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      AppImages.upi,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),

                          // Cash Input Field
                          TextField(
                            controller: cashController,
                            decoration: InputDecoration(
                              labelText: 'Cash Amount',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon:
                                  Icon(Icons.money, color: Colors.green),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                          ),
                          SizedBox(height: 15),

                          // Bank Input Field
                          TextField(
                            controller: bankController,
                            decoration: InputDecoration(
                              labelText: 'Bank Amount',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: Icon(Icons.account_balance,
                                  color: Colors.green),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                          ),
                          SizedBox(height: 20),

                          // Amount Display Section
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Amount:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      '₹${amount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Amount Entered:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      '₹${totalPayment.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: totalPayment == amount
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),

                          if (state is UpdateDeliveryLoading)
                            CircularProgressIndicator()
                          else
                            // Action Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: totalPayment == amount &&
                                          state is! UpdateDeliveryLoading
                                      ? () async {
                                          // Create and use LocationBloc
                                          final locationBloc = LocationBloc(
                                            repository: LocationRepository(),
                                          );

                                          // Get current location
                                          locationBloc.add(
                                              GetCurrentLocationRequested());

                                          // Listen for location updates
                                          await for (final state
                                              in locationBloc.stream) {
                                            if (state
                                                is LocationUpdateSuccess) {
                                              // Update location on server
                                              locationBloc
                                                  .add(UpdateLocationRequested(
                                                customerid: bill.customerID,
                                                latitude: state.latitude,
                                                longitude: state.longitude,
                                              ));
                                            } else if (state
                                                is LocationUpdateFailure) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(state.error)),
                                              );
                                              break;
                                            }

                                            // Once location is updated successfully, proceed with payment
                                            if (state
                                                is LocationUpdateSuccess) {
                                              context
                                                  .read<UpdateDeliveryBloc>()
                                                  .add(UpdateDeliveryRequested(
                                                      bill,
                                                      cashAmount,
                                                      bankAmount,
                                                      3,
                                                      remarks));
                                              break;
                                            }
                                          }
                                        }
                                      : null,
                                  child: const Text('Confirm Payment'),
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    },
  );
}

void _showReturnDialog(BuildContext context, BillDetailsModel bill) {
  TextEditingController reasonController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => UpdateDeliveryBloc(
          repository: UpdateDeliveryRepository(),
        ),
        child: BlocConsumer<UpdateDeliveryBloc, UpdateDeliveryState>(
          listener: (context, state) {
            if (state is UpdateDeliverySuccess) {
              final sessionTimeOutBloc =
                  BlocProvider.of<WhatsAppMessageBlocBloc>(context);

              sessionTimeOutBloc.add(WhatAppMsgSendingEvent(
                  mobileNo: bill.phoneNumber,
                  message: "Your Order has been returned."));

              snackBarWidget(
                msg: "Return processed successfully",
                icons: Icons.verified,
                iconcolor: Colors.green,
                texcolor: Colors.green,
                backgeroundColor: Colors.white,
                context: context,
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MainScreen()),
              );
            } else if (state is UpdateDeliveryFailure) {
              snackBarWidget(
                msg: "Return processing failed",
                icons: Icons.error,
                iconcolor: Colors.red,
                texcolor: Colors.red,
                backgeroundColor: Colors.white,
                context: context,
              );
            }
          },
          builder: (context, state) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Return Details',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),

                          // Reason Input Field
                          TextField(
                            controller: reasonController,
                            decoration: InputDecoration(
                              labelText: 'Enter a Reason',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: Icon(Icons.note_alt),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 20),

                          if (state is UpdateDeliveryLoading)
                            CircularProgressIndicator()
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.green.shade700,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: reasonController.text.isNotEmpty
                                      ? () async {
                                          final locationBloc = LocationBloc(
                                            repository: LocationRepository(),
                                          );
                                          locationBloc.add(
                                              GetCurrentLocationRequested());

                                          await for (final state
                                              in locationBloc.stream) {
                                            if (state
                                                is LocationUpdateSuccess) {
                                              locationBloc
                                                  .add(UpdateLocationRequested(
                                                customerid: bill.customerID,
                                                latitude: state.latitude,
                                                longitude: state.longitude,
                                              ));
                                            } else if (state
                                                is LocationUpdateFailure) {
                                              snackBarWidget(
                                                msg: state.error,
                                                icons: Icons.error,
                                                iconcolor: Colors.red,
                                                texcolor: Colors.red,
                                                backgeroundColor: Colors.white,
                                                context: context,
                                              );
                                              break;
                                            }

                                            if (state
                                                is LocationUpdateSuccess) {
                                              context
                                                  .read<UpdateDeliveryBloc>()
                                                  .add(UpdateDeliveryRequested(
                                                      bill,
                                                      0, // No cash amount
                                                      0, // No bank amount
                                                      2, // Return status
                                                      reasonController.text));
                                              break;
                                            }
                                          }
                                        }
                                      : null,
                                  child: Text(
                                    'Confirm Return',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    },
  );
}

void _showUPIQRCodeDialog_inPD(BuildContext context, BillDetailsModel bill,
    double amount, String remarks) {
  final upiBloc = UPIBloc(BillDetailsRepository());
  upiBloc.add(FetchUPIDetailsEvent());

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return BlocProvider<UPIBloc>(
        create: (context) => upiBloc,
        child: BlocBuilder<UPIBloc, UPIState>(
          builder: (context, state) {
            if (state is UPILoadingState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                  decoration: _dialogDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 15),
                        Text(
                          'Loading UPI Details...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            if (state is UPIErrorState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                  decoration: _dialogDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline,
                            color: Colors.white, size: 48),
                        SizedBox(height: 15),
                        Text(
                          'Failed to load UPI details',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Please try again later',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is UPILoadedState) {
              final upiDetails = state.upiDetails;
              final String upiLink =
                  'upi://pay?pa=${upiDetails.upIcode}&pn=${upiDetails.accountName}&cu=INR';
              print("upiLink: $upiLink");
              print("upiDetails: ${upiDetails.upIcode}");
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Colors.transparent,
                content: Container(
                  decoration: _dialogDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Scan UPI QR Code',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Please scan the QR code to complete the payment.',
                          style: TextStyle(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 200,
                          width: 200,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: QrImageView(
                            data: upiLink,
                            version: QrVersions.auto,
                            size: 180.0,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'UPI ID: ${upiDetails.upIcode}',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showPaymentMethodDialog_inPD(
                          context, amount, bill, remarks);
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            }
            return SizedBox.shrink(); // Fallback (shouldn't reach here)
          },
        ),
      );
    },
  );
}

void _showUPIQRCodeDialog(
    BuildContext context, BillDetailsModel bill, double amount) {
  final upiBloc = UPIBloc(BillDetailsRepository());
  upiBloc.add(FetchUPIDetailsEvent());

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return BlocProvider<UPIBloc>(
        create: (context) => upiBloc,
        child: BlocBuilder<UPIBloc, UPIState>(
          builder: (context, state) {
            if (state is UPILoadingState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                  decoration: _dialogDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 15),
                        Text(
                          'Loading UPI Details...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            if (state is UPIErrorState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                  decoration: _dialogDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline,
                            color: Colors.white, size: 48),
                        SizedBox(height: 15),
                        Text(
                          'Failed to load UPI details',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Please try again later',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is UPILoadedState) {
              final upiDetails = state.upiDetails;
              final String upiLink =
                  'upi://pay?pa=${upiDetails.upIcode}&pn=${upiDetails.accountName}&cu=INR';
              print("upiLink: $upiLink");
              print("upiDetails: ${upiDetails.upIcode}");
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Colors.transparent,
                content: Container(
                  decoration: _dialogDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Scan UPI QR Code',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Please scan the QR code to complete the payment.',
                          style: TextStyle(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 200,
                          width: 200,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: QrImageView(
                            data: upiLink,
                            version: QrVersions.auto,
                            size: 180.0,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'UPI ID: ${upiDetails.upIcode}',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showPaymentMethodDialog(context, amount, bill);
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            }
            return SizedBox.shrink(); // Fallback (shouldn't reach here)
          },
        ),
      );
    },
  );
}

void showPaymentMethodDialog(
    BuildContext context, double amount, BillDetailsModel bill) {
  final cashController = TextEditingController();
  final bankController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      final dialogContext = context; // Ensure proper context usage
      return BlocProvider(
        create: (context) => UpdateDeliveryBloc(
          repository: UpdateDeliveryRepository(),
        ),
        child: BlocConsumer<UpdateDeliveryBloc, UpdateDeliveryState>(
          listener: (context, state) {
            if (state is UpdateDeliverySuccess) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(content: Text('Payment successful')),
              // );
              snackBarWidget(
                msg: "Payment saved is successfully",
                icons: Icons.verified,
                iconcolor: Colors.green,
                texcolor: Colors.green,
                backgeroundColor: Colors.white,
                context: context,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MainScreen()),
              );
            } else if (state is UpdateDeliveryFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Payment failed: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            return StatefulBuilder(
              builder: (context, setState) {
                final cashAmount = double.tryParse(cashController.text) ?? 0.0;
                final bankAmount = double.tryParse(bankController.text) ?? 0.0;
                final totalPayment = cashAmount + bankAmount;

                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header with UPI icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.payment,
                                  color: Colors.green, size: 40),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Enter Payment Details',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(dialogContext);
                                    _showUPIQRCodeDialog(
                                      dialogContext,
                                      bill,
                                      amount,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      AppImages.upi,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),

                          // Cash Input Field
                          TextField(
                            controller: cashController,
                            decoration: InputDecoration(
                              labelText: 'Cash Amount',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon:
                                  Icon(Icons.money, color: Colors.green),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                          ),
                          SizedBox(height: 15),

                          // Bank Input Field
                          TextField(
                            controller: bankController,
                            decoration: InputDecoration(
                              labelText: 'Bank Amount',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: Icon(Icons.account_balance,
                                  color: Colors.green),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                          ),
                          SizedBox(height: 20),

                          // Amount Display Section
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Amount:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      '₹${amount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Amount Entered:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      '₹${totalPayment.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: totalPayment == amount
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),

                          if (state is UpdateDeliveryLoading)
                            CircularProgressIndicator()
                          else
                            // Action Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(dialogContext),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: totalPayment == amount
                                      ? () async {
                                          final locationBloc = LocationBloc(
                                            repository: LocationRepository(),
                                          );
                                          locationBloc.add(
                                              GetCurrentLocationRequested());

                                          locationBloc.stream.listen((state) {
                                            if (state
                                                is LocationUpdateSuccess) {
                                              // bill.mode = (cashAmount > 0 &&
                                              //         bankAmount > 0)
                                              //     ? 'C:${cashAmount.toStringAsFixed(2)}, B:${bankAmount.toStringAsFixed(2)}'
                                              //     : (cashAmount > 0
                                              //         ? 'C:${cashAmount.toStringAsFixed(2)}'
                                              //         : 'B:${bankAmount.toStringAsFixed(2)}');

                                              context
                                                  .read<UpdateDeliveryBloc>()
                                                  .add(UpdateDeliveryRequested(
                                                      bill,
                                                      cashAmount,
                                                      bankAmount,
                                                      1,
                                                      ""));
                                            } else if (state
                                                is LocationUpdateFailure) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(state.error),
                                              ));
                                            }
                                          });
                                        }
                                      : null,
                                  child: const Text('Confirm Payment'),
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    },
  );
}

BoxDecoration _dialogDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.green.shade400, Colors.blue.shade400],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 15,
        offset: Offset(0, 5),
      ),
    ],
  );
}
// void _showUPIQRCodeDialog_inPD(BuildContext contex,BillDetailsModel bill) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         backgroundColor: Colors.transparent, // Make the dialog transparent
//         content: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.green.shade400, Colors.blue.shade400],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 15,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Scan UPI QR Code',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontSize: 18,
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 Text(
//                   'Please scan the QR code to complete the payment.',
//                   style: TextStyle(color: Colors.white70),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   height: 200,
//                   width: 200,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 10,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       'QR Code Placeholder',
//                       style: TextStyle(color: Colors.white70),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context); // Close the QR code dialog
//               _showPaymentMethodDialog_inPD(
//                   context, 20); // Reopen the payment details dialog
//             },
//             child: Text(
//               'Back',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//                 color: AppColors.white,
//               ),
//             ),
//           ),
//           // ElevatedButton(
//           //   style: ElevatedButton.styleFrom(
//           //     backgroundColor: Colors.white,
//           //     foregroundColor: Colors.green.shade700,
//           //     shape: RoundedRectangleBorder(
//           //       borderRadius: BorderRadius.circular(10),
//           //     ),
//           //   ),
//           //   onPressed: () => Navigator.pop(context), // Close the dialog
//           //   child: Text(
//           //     'Payment Saved',
//           //     style: TextStyle(fontWeight: FontWeight.bold),
//           //   ),
//           // ),
//         ],
//       );
//     },
//   );
// }

void _showLocationUpdateDialog(BuildContext context) {
  // This is the function that shows the location update dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Your Location'),
        content: Text('Would you like to update your location to this place?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close the dialog
            child: Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              // Here you can set the logic to update the location
              // For now, it just closes the dialog and shows a message
              Navigator.pop(context); // Close the dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Location updated!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child:
                Text('Update Location', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

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
