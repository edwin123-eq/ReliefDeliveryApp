import 'package:deliveryapp/blocs/section_timeout/bloc/session_time_out_bloc.dart';
import 'package:deliveryapp/widgets/selection_timeout_dailogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deliveryapp/app_confiq/Responsive.dart';
import 'package:deliveryapp/app_confiq/app_colors.dart';
import 'package:deliveryapp/app_confiq/image.dart';
import 'package:deliveryapp/bill_module/view/Bill_Screen.dart';
import 'package:intl/intl.dart';
import '../../blocs/summary_bloc.dart/summary_bloc.dart';
import '../../blocs/summary_bloc.dart/summary_event.dart';
import '../../blocs/summary_bloc.dart/summary_state.dart';
import '../controller/summary_repo.dart';
import '../model/summary_model.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return HomeScreenContent();
  }
}

class HomeScreenContent extends StatefulWidget {
  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  void initState() {
    final sessionTimeOutBloc = BlocProvider.of<SessionTimeOutBloc>(context);
    sessionTimeOutBloc.add(const SessionTimeOutUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveData = ResponsiveData.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<SessionTimeOutBloc, SessionTimeOutState>(
        listener: (context, state) {
          if (state is SessionTimeOut) {
            if (state.status) {
              showSessionTimeoutDialog(context);
            }
          }
        },
        child: BlocConsumer<SummaryBloc, SummaryState>(
          listener: (context, state) {
            // if (state is SummaryError) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text(state.errorMessage)),
            //   );
            // }
          },
          builder: (context, state) {
            SummaryModel summaryModel = SummaryModel(); // Default empty model

            if (state is SummaryLoaded) {
              summaryModel = state.summaryModel;
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    _buildHeaderRow(context, summaryModel, responsiveData),

                    SizedBox(height: 16),

                    // Grid Items
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        height: responsiveData.screenHeight * 0.30,
                        child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: _buildGridItems(context, summaryModel),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // Existing BillScreen
                    _buildBillScreenStack(responsiveData, state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context, SummaryModel summaryModel,
      ResponsiveData responsiveData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Text(
                'Summary',
                style: TextStyle(
                  fontSize: responsiveData.screenWidth * .055,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
          child: ElevatedButton(
            onPressed: () {
              context.read<SummaryBloc>().add(FetchSummaryDetails(
                  employeeId: '1001978158', date: '09%2F12%2F2024'));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh, size: 20, color: Colors.white),
                SizedBox(width: 4),
                Text(
                  'Refresh',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildGridItems(
      BuildContext context, SummaryModel summaryModel) {
    return [
      _buildGridItem(
        Image.asset('assets/icons/bill.png', width: 36, height: 36),
        'All Bills',
        '${summaryModel.getTotalBills()}',
        0,
        context,
      ),
      _buildGridItem(
        Image.asset(AppImages.delivered, width: 40, height: 40),
        'Delivered',
        '${summaryModel.deliveredCount}',
        2,
        context,
      ),
      _buildGridItem(
        Image.asset(AppImages.returned, width: 40, height: 40),
        'Returned',
        '${summaryModel.returnedCount}',
        3,
        context,
      ),
      _buildGridItem(
        Image.asset(AppImages.pending, width: 40, height: 40),
        'Pending',
        '${summaryModel.pendingCount}',
        1,
        context,
      ),
      _buildGridItem(
        Image.asset(AppImages.cash, width: 36, height: 36),
        'Cash',
        '${summaryModel.totalCashReceived}',
        4,
        context,
      ),
      _buildGridItem(
        Image.asset(AppImages.bank, width: 36, height: 36),
        'Bank',
        '${summaryModel.totalBankReceived}',
        5,
        context,
      ),
    ];
  }

  Widget _buildGridItem(Widget iconWidget, String label, String number,
      int tabIndex, BuildContext context) {
    bool isFinancialItem = label == 'Cash' || label == 'Bank';

    return InkWell(
      onTap: isFinancialItem
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BillScreen(initialTabIndex: tabIndex),
                ),
              );
            },
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [AppColors.lightBlue, AppColors.primary],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(4, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillScreenStack(
      ResponsiveData responsiveData, SummaryState state) {
    return Stack(
      children: [
        SizedBox(
          height: responsiveData.screenHeight * 0.6,
          child: BillScreen(),
        ),
        if (state is SummaryLoading) _buildBlurredBackground(),
      ],
    );
  }

  Widget _buildBlurredBackground() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
        ),
      ),
    );
  }
}
