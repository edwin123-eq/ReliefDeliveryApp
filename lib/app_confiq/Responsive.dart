import 'package:flutter/material.dart';

class ResponsiveData extends InheritedWidget {
  final double screenWidth;
  final double screenHeight;
  final double textFactor;
  final Orientation orientation;
  final String jwtToken;
  final BuildContext context;
  final bool isConnected;

  const ResponsiveData({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.textFactor,
    required this.orientation,
    required this.context,
    required this.jwtToken,
    required this.isConnected,
    required super.child,
  });

  bool isTablet() {
    return screenHeight >= 900 && screenWidth >= 600;
  }

  @override
  bool updateShouldNotify(covariant ResponsiveData oldWidget) {
    double baseFontSize = 16;
    double screenFactor = MediaQuery.of(context).size.width * 0.005;
    double? screenWidthAdjusted = 0.0;
    double? screenHeightAdjusted = 0.0;
    double? textFactorcalculated = 0.0;
    double safeAreaHorizontal;
    bool? isNetworkConnected;

    if (screenWidth > 600) {
      // e.g., for tablets or larger devices
      baseFontSize = 20;
    }

    if (orientation == Orientation.portrait) {
      screenWidthAdjusted =
          isTablet() ? screenWidth.clamp(3.5, 4.5) : screenWidth.clamp(3, 4);
      screenHeightAdjusted = screenHeight;
    } else {
      screenHeightAdjusted = screenWidth;
      screenWidthAdjusted =
          isTablet() ? screenHeight.clamp(3.5, 4.5) : screenHeight.clamp(3, 4);
    }

    if (isTablet()) {
      textFactorcalculated = (baseFontSize + screenFactor) *
          MediaQuery.of(context).textScaler.scale(10) /
          10;
    } else {
      textFactorcalculated = (baseFontSize + screenFactor) *
          MediaQuery.of(context).textScaler.scale(10) /
          10;
    }

    safeAreaHorizontal = MediaQuery.paddingOf(context).left +
        MediaQuery.paddingOf(context).right;

    // Connectivity().onConnectivityChanged.listen((result) {
    //   isNetworkConnected = result != ConnectivityResult.none;
    // });

    // Check if any of the properties that affect the layout have changed.
    return (screenWidthAdjusted - safeAreaHorizontal) / 100 !=
            oldWidget.screenWidth ||
        screenHeightAdjusted != oldWidget.screenHeight ||
        textFactorcalculated != oldWidget.textFactor ||
        orientation != oldWidget.orientation ||
        jwtToken != oldWidget.jwtToken ||
        isNetworkConnected != oldWidget.isConnected;
  }

  static ResponsiveData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ResponsiveData>()!;
  }
}