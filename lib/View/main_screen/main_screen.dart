import 'package:deliveryapp/app_confiq/Responsive.dart';
import 'package:deliveryapp/app_confiq/app_colors.dart';
import 'package:deliveryapp/app_confiq/image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:deliveryapp/blocs/bloc/bottom%20bloc/bottom_navigation_bloc.dart';
import 'package:deliveryapp/blocs/bloc/bottom%20bloc/bottom_navigation_event.dart';
import 'package:deliveryapp/blocs/bloc/bottom%20bloc/bottom_navigation_state.dart';
import 'package:deliveryapp/home_module/view/home_screen.dart';
import 'package:deliveryapp/report_module/view/report_screen.dart';
import 'package:deliveryapp/home_page/screens/settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deliveryapp/blocs/summary_bloc.dart/summary_bloc.dart';
import 'package:deliveryapp/blocs/summary_bloc.dart/summary_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../blocs/summary_bloc.dart/summary_event.dart';
import '../../home_module/controller/summary_repo.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    HomeScreen(),
    ReportScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final responsiveData = ResponsiveData.of(context);

    // Get the current date
    String currentDate =
        "Date: " + DateFormat('dd-MM-yyyy').format(DateTime.now());

    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        final int currentIndex = state is TabSelected ? state.index : 0;

        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child:
               
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    flexibleSpace: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: SizedBox(
                          width: responsiveData.screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 0, 3),
                                    child: Image.asset(
                                      AppImages.logo,
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Relief Medicals',
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Delivery App',
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 60, 20, 0),
                                    child: Text(
                                      currentDate,
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 2,
                                  margin: EdgeInsets.zero,
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    child:
                                        BlocBuilder<SummaryBloc, SummaryState>(
                                      builder: (context, state) {
                                        if (state is SummaryLoaded) {
                                          return Text(
                                            'Delivery Rider: ${state.summaryModel.employeeName}',
                                            style: const TextStyle(
                                              color: AppColors.textname,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        }
                                        else if (state is SummaryError) {
                                          return Container();
                                        }
                                        else {
                                          return Container();
                                        }
                                      },
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
            ),
            body: _pages[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<BottomNavigationBloc>().add(SelectTab(index));
              },
              backgroundColor: AppColors.bottomclr,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                    color: AppColors.white,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list_alt_outlined,
                    size: 30,
                    color: AppColors.white,
                  ),
                  label: 'Report',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                    color: AppColors.white,
                  ),
                  label: 'Settings',
                ),
              ],
              selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
              unselectedItemColor: AppColors.bottomNavUnselectedItem,
            ),
          ),
        );
      },
    );
  }
}
