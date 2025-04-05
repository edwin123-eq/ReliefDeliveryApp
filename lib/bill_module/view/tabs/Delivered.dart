import 'package:deliveryapp/app_confiq/Responsive.dart';
import 'package:deliveryapp/app_confiq/image.dart';
import 'package:deliveryapp/bill_module/bloc/bloc/bill_list_bloc.dart';
import 'package:deliveryapp/bill_module/model/bill_list_model.dart';
import 'package:deliveryapp/bill_details_module/view/bill_details.dart';
import 'package:deliveryapp/bill_module/view/tabs/Bill_status%20const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveredTab extends StatefulWidget {
  const DeliveredTab({super.key});

  @override
  State<DeliveredTab> createState() => _DeliveredTabState();
}

class _DeliveredTabState extends State<DeliveredTab> {
  @override
  void initState() {
    super.initState();
    // Load bills with delivered status
    final billBloc = BlocProvider.of<BillListBloc>(context);
    billBloc.add(
        BillTabClicked(index: 2)); // Assuming index 2 is for delivered status
  }

  Color getRibbonColor(int status) {
switch (status) {
  case 1:
      return Colors.green;
  case 3:
  return Colors.blue;
      default:
        return Colors.grey;  
}
 // Always green for delivered items
  }

  Future<void> makePhoneCall(String phoneNumber) async {
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error making phone call: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildBillCard(BillListModel bill, ResponsiveData responsiveData) {
     final status = getStatusString(bill.dlstatus);
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () async {
           SharedPreferences logindata = await SharedPreferences.getInstance();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BillDetailsPage(
                dlSaleId: bill.dlsaleid.toString(), dlEmpId: bill.dlempid.toString(),customerId: bill.customerID,riderName: logindata.getString("userName")!
                // bill: {
                //   'name': bill.customername,
                //   'address': bill.address,
                //   'status': 'Delivered',
                //   'numItems': bill.quantity.toString(),
                //   'amtReceived': bill.amountreceived.toString(),
                //   'cashReceived': bill.dlcashrcvd.toString(),
                //   'bankReceived': bill.dlbankrcvd.toString(),
                //   'remarks': bill.dlremarks,
                //   'assignedDate': bill.dlassignedat.toString(),
                // },
              ),
            ),
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: responsiveData.screenWidth,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: getRibbonColor(bill.dlstatus),
                      width: 7,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bill.customername,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Address:${bill.address}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${bill.quantity}/\u{20B9}${bill.amountreceived.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          // Text(
                          //   'Delivered: ${bill.dlassignedat.toString().split(' ')[0]}',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     color: Colors.grey[600],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        // IconButton(
                        //   icon: Image.asset(
                        //     AppImages.map,
                        //     width: 30,
                        //     height: 30,
                        //   ),
                        //   onPressed: () {
                        //     print('Opening map for: ${bill.customername}');
                        //   },
                        // ),
                        IconButton(
                          icon: Image.asset(
                            AppImages.phone,
                            width: 40,
                            height: 40,
                          ),
                          onPressed: () {
                            print('Calling: ${bill.customername}');
                               if (bill
                                                  .phoneNumber.isNotEmpty) {
                                            makePhoneCall(
                                                bill.phoneNumber);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'No phone number available'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Status ribbon
            Positioned(
              right: 4,
              top: 5,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: bill.dlstatus ==1?
                  Colors.green:Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$status',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsiveData = ResponsiveData.of(context);

    return BlocBuilder<BillListBloc, BillListState>(
      builder: (context, state) {
        if (state is BillListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BillListerror) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  state.error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          );
        } else if (state is BillListsucess) {
          // Filter for only delivered bills
          final deliveredBills = state.billlitmodel.where((bill) => 
    bill.dlstatus == BillStatus.DELIVERED || 
    bill.dlstatus == BillStatus.PARTIALLY_DELIVERED
).toList();

          if (deliveredBills.isEmpty) {
            return const Center(
              child: Text('No Delivered bills available'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<BillListBloc>(context)
                  .add(BillTabClicked(index: 2));
            },
            child: ListView.builder(
              itemCount: deliveredBills.length,
              itemBuilder: (context, index) {
                return _buildBillCard(
                  deliveredBills[index],
                  responsiveData,
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
   String getStatusString(int status) {
    switch (status) {
      case 0:
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
}
