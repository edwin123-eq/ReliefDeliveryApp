import 'package:deliveryapp/app_confiq/Responsive.dart';
import 'package:deliveryapp/app_confiq/image.dart';
import 'package:deliveryapp/bill_module/bloc/bloc/bill_list_bloc.dart';
import 'package:deliveryapp/bill_module/view/tabs/all_list_tab.dart';
import 'package:deliveryapp/bill_module/view/tabs/Delivered.dart';
import 'package:deliveryapp/bill_module/view/tabs/Pending.dart';
import 'package:deliveryapp/bill_module/view/tabs/returned.dart';
import 'package:deliveryapp/bill_details_module/view/bill_details.dart';
import 'package:flutter/material.dart';
import 'package:deliveryapp/app_confiq/app_colors.dart';
import 'package:deliveryapp/home_page/screens/bill_screen/bill_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class BillScreen extends StatefulWidget {
  final int initialTabIndex;

  BillScreen({this.initialTabIndex = 0}); // Default tab index is 0

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4, // Number of tabs
      vsync: this,
      initialIndex: widget.initialTabIndex, // Set the initial tab
    );
  }

  // Filtering bills based on selected filter
  List<Map<String, String>> getFilteredBills(String filter) {
    if (filter == 'Pending') {
      return data_Bills.where((bill) => bill['status'] == 'Pending').toList();
    } else if (filter == 'Delivered') {
      // Combine "Delivered" and "Partially Delivered" statuses
      return data_Bills
          .where((bill) =>
              bill['status'] == 'Delivered' ||
              bill['status'] == 'Partially Delivered')
          .toList();
    } else if (filter == 'Returned') {
      return data_Bills.where((bill) => bill['status'] == 'Returned').toList();
    } else {
      return data_Bills; // Show all bills for "All"
    }
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

  Widget _buildBillsList(String filter) {
    final responsiveData = ResponsiveData.of(context);

    // Determine ribbon color based on status
    Color getRibbonColor(String status) {
      if (status == 'Delivered') {
        return Colors.green;
      } else if (status == 'Partially Delivered') {
        return Colors.blue;
      } else if (status == 'Pending') {
        return Colors.red;
      } else if (status == 'Returned') {
        return Colors.orange;
      } else {
        return Colors.grey;
      }
    }

    final filteredBills = getFilteredBills(filter);
    return BlocBuilder<BillListBloc, BillListState>(
      builder: (context, state) {
        if (state is BillListsucess) {
          return state.billListModelFilerList.isNotEmpty?
          ListView.builder(
            itemCount: state.billListModelFilerList.length,
            itemBuilder: (context, index) {
              final bill = filteredBills[index];
               final billData = state.billListModelFilerList[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => BillDetailsPage(bill: bill),
                      //   ),
                      // );
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Card content
                        Card(
                          clipBehavior: Clip.hardEdge,
                          child: SizedBox(
                            width: responsiveData.screenWidth,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: bill['status'] == 'Delivered'
                                        ? Colors.green
                                        : bill['status'] ==
                                                'Partially Delivered'
                                            ? Colors.blue
                                            : bill['status'] == 'Pending'
                                                ? Colors.red
                                                : bill['status'] == 'Returned'
                                                    ? Colors.orange
                                                    : Colors.yellow,
                                    width: 7,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.billListModelFilerList[index]
                                              .customername,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          bill['address']!,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 18,
                                            ),
                                            Text(
                                              '${state.billListModelFilerList[index].quantity}/${state.billListModelFilerList[index].amountreceived}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Image.asset(
                                          AppImages.map,
                                          width: 30,
                                          height: 30,
                                        ),
                                        onPressed: () {
                                          print('Open map for ${bill['name']}');
                                        },
                                      ),
                                      IconButton(
                                        icon: Image.asset(
                                          AppImages.phone,
                                          width: 40,
                                          height: 40,
                                        ),
                                        onPressed: () {
                                          print('Call ${bill['name']}');
                                            if (billData
                                                  .phoneNumber.isNotEmpty) {
                                            makePhoneCall(
                                                billData.phoneNumber);
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
                        ),
                        // Ribbon in the top-right corner
                        Positioned(
                          right: 4,
                          top: 5,
                          child: Transform.rotate(
                            angle: 0.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: getRibbonColor(bill['status']!),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                bill['status']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ): Text("No data Found");
       
        } else if (state is BillListLoading) {
          return Container();
        } else if(state is BillListerror){
          return Text("No data Found..");
        }
        else {
          return Container();
        }
      },
    );
  }

  Widget _buildBillItem(Map<String, String> bill) {
    final responsiveData = ResponsiveData.of(context);

    // Determine ribbon color based on status
    Color getRibbonColor(String status) {
      if (status == 'Delivered') {
        return Colors.green;
      } else if (status == 'Partially Delivered') {
        return Colors.blue;
      } else if (status == 'Pending') {
        return Colors.red;
      } else if (status == 'Returned') {
        return Colors.orange;
      } else {
        return Colors.grey;
      }
    }

    return BlocBuilder<BillListBloc, BillListState>(
      builder: (context, state) {
        if (state is BillListsucess) {}
        return Column(
          children: [
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => BillDetailsPage(dlSaleId:1001978166 ,),
                //   ),
                // );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Card content
                  Card(
                    clipBehavior: Clip.hardEdge,
                    child: SizedBox(
                      width: responsiveData.screenWidth,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: bill['status'] == 'Delivered'
                                  ? Colors.green
                                  : bill['status'] == 'Partially Delivered'
                                      ? Colors.blue
                                      : bill['status'] == 'Pending'
                                          ? Colors.red
                                          : bill['status'] == 'Returned'
                                              ? Colors.orange
                                              : Colors.yellow,
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
                                    bill['name']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    bill['address']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                      Text(
                                        '${bill['numItems']} / ${bill['amtReceived']}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Image.asset(
                                    AppImages.map,
                                    width: 30,
                                    height: 30,
                                  ),
                                  onPressed: () {
                                    print('Open map for ${bill['name']}');
                                  },
                                ),
                                IconButton(
                                  icon: Image.asset(
                                    AppImages.phone,
                                    width: 40,
                                    height: 40,
                                  ),
                                  onPressed: () {
                                    print('Call ${bill['name']}');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Ribbon in the top-right corner
                  Positioned(
                    right: 4,
                    top: 5,
                    child: Transform.rotate(
                      angle: 0.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: getRibbonColor(bill['status']!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          bill['status']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bills",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.bottomNavUnselectedItem,
          labelPadding: const EdgeInsets.symmetric(horizontal: 6.0),
          tabs: [
            Tab(text: "All"),
            Tab(text: "Pending"),
            Tab(text: "Delivered"),
            Tab(text: "Returned"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AllListPage(),
          PendingListPage(),
          DeliveredTab(),
          ReturnedTab()
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
