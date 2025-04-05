import 'dart:io';

import 'package:deliveryapp/Get_c_loc/bloc/bloc/location_bloc_bloc.dart';
import 'package:deliveryapp/View/main_screen/main_screen.dart';
import 'package:deliveryapp/app_confiq/auth_service.dart';
import 'package:deliveryapp/app_confiq/global_Messenger_key.dart';
import 'package:deliveryapp/app_confiq/http_override.dart';
import 'package:deliveryapp/bill_details_module/bloc/bill_details_bloc.dart';
import 'package:deliveryapp/bill_details_module/controller/bill_details_repo.dart';
import 'package:deliveryapp/bill_module/bloc/bloc/bill_list_bloc.dart';
import 'package:deliveryapp/blocs/Whatsapp_bloc/bloc/whats_app_message_bloc_bloc.dart';
import 'package:deliveryapp/blocs/bloc/login%20bloc/login_bloc.dart';
import 'package:deliveryapp/blocs/section_timeout/bloc/session_time_out_bloc.dart';
import 'package:deliveryapp/blocs/summary_bloc.dart/summary_bloc.dart';
import 'package:deliveryapp/blocs/summary_bloc.dart/summary_event.dart';
import 'package:deliveryapp/login_module/view/login.dart';
import 'package:deliveryapp/report_module/bloc/closingreport_bloc.dart';
import 'package:flutter/material.dart';
import 'package:deliveryapp/app_confiq/Responsive.dart';
import 'package:deliveryapp/app_confiq/sizeConfiq.dart';
import 'package:deliveryapp/blocs/bloc/bottom%20bloc/bottom_navigation_bloc.dart';
import 'package:deliveryapp/blocs/bloc/bottom%20bloc/bottom_navigation_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  // AuthService authService = AuthService();
  // // APIService().refreshToken();
  // //int? userID = await authService.getUserId();
  // await authService.getValidToken();
  // String? token = await authService.getToken();
  MapboxOptions.setAccessToken(
      "pk.eyJ1IjoiZXFzb2Z0cG0iLCJhIjoiY2s2b3U1cmQ3MWRlbzNkbzdqYnQ4Z3JmZCJ9.QvwZK2vAxurhrdwZBCO8pw");
  SharedPreferences logindata = await SharedPreferences.getInstance();
  bool isLoggedIn = logindata.getBool('isLogin') ?? false;
  runApp(RelifeDeliveryApp(
    initialPage: isLoggedIn == true ? MainScreen() : SignInPage(),
  ));
}

class RelifeDeliveryApp extends StatelessWidget {
  final Widget initialPage;
  const RelifeDeliveryApp({super.key, required this.initialPage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              BottomNavigationBloc()..add(const SelectTab(0)),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              BillListBloc()..add(BillTabClicked(index: 0)),
        ),
        BlocProvider(create: (context) => ClosingreportBloc()),
        BlocProvider(create: (context) => LocationBlocBloc()),
        BlocProvider(create: (BuildContext context) => SessionTimeOutBloc()),
        BlocProvider(
            create: (context) => SummaryBloc()
              ..add(FetchSummaryDetails(
                  employeeId: '1001978158', date: '09%2F12%2F2024'))),
        BlocProvider(
            create: (context) =>
                BillDetailsBloc(repository: BillDetailsRepository())),
        BlocProvider(
          create: (BuildContext context) => WhatsAppMessageBlocBloc(),
        ),
      ],
      child: OrientationBuilder(builder: (context, orientation) {
        return LayoutBuilder(builder: (context, constraints) {
          SizeConfig().init(constraints, orientation);
          return ResponsiveData(
            screenWidth: constraints.maxWidth,
            screenHeight: constraints.maxHeight,
            orientation: orientation,
            textFactor:
                (MediaQuery.of(context).size.width / 100).clamp(0.5, 2.0),
            context: context,
            jwtToken: "",
            isConnected: true,
            child: MaterialApp(
              scaffoldMessengerKey: scaffoldMsgKey,
              title: 'Relief Delivery App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              // Remove the debug banner by setting this to false
              debugShowCheckedModeBanner: false,
              home: initialPage, // Initial page is LoginPage
            ),
          );
        });
      }),
    );
  }
}
