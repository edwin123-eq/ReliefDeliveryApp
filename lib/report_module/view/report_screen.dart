import 'package:deliveryapp/View/main_screen/main_screen.dart';
import 'package:deliveryapp/app_confiq/app_colors.dart';

import 'package:deliveryapp/main.dart';
import 'package:deliveryapp/report_module/bloc/closingreport_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc/bottom bloc/bottom_navigation_bloc.dart';
import '../../blocs/bloc/bottom bloc/bottom_navigation_event.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}
  
class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    
    final loginBloc = BlocProvider.of<ClosingreportBloc>(context);
    loginBloc.add(GetClosingReport());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Closing Report',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.titleclr,
          ),
        ),
      ),
      body: BlocBuilder<ClosingreportBloc, ClosingreportState>(
        builder: (context, state) {
          if(state is ClosingreportLoading){
            return Center(child: CircularProgressIndicator());

          }
        else  if(state is ClosingreportSuccessState){
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wrap details in a container with decoration
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Bills Details
                      _buildDetailRow('Total Bills:', '${state.closingReport.totalBills}'),
                      _buildDetailRow('Delivered:', '${state.closingReport.deliveredCount}'),
                      _buildDetailRow('Returned:', '${state.closingReport.returnedCount}'),

                      Divider(height: 30, color: Colors.grey),

                      // Amount Details
                      _buildDetailRow('Total Amount:', '${state.closingReport.totalAmount}'),
                      _buildDetailRow('Cash Collected:', '${state.closingReport.totalCashReceived}'),
                      _buildDetailRow('Card/UPI:', '${state.closingReport.totalBankReceived}'),
                    ],
                  ),
                ),

                SizedBox(height: 32),

                // Close Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Show confirmation dialog
                      _showConfirmationDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Close'),
                  ),
                ),
              ],
            ),
          );
        
          }else{
            return Container(
              child: Center(child: Text("NO Data Found..."),),
            );
          }
        
        },
      ),
    );
  }

  // Helper method to create consistent detail rows
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  // Method to show confirmation dialog
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Closing'),
          content: Text('Are you sure you want to close this report?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              child: Text(
                'Confirm',
                style: TextStyle(color: AppColors.Bottomnav),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to MainScreen with Home tab selected
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<BottomNavigationBloc>(
                      create: (_) => BottomNavigationBloc()
                        ..add(SelectTab(0)), // Select Home tab
                      child: MainScreen(),
                    ),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
// Placeholder for HomePage - replace with your actual homepage widget
