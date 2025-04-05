import 'package:deliveryapp/app_confiq/Responsive.dart';
import 'package:deliveryapp/app_confiq/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveData = ResponsiveData.of(context);
    return SizedBox(
      width: responsiveData.screenWidth,
      height: responsiveData.screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCircle(
            color: AppColors.bottomclr,
            size: responsiveData.screenWidth * 70.0,
            duration: const Duration(milliseconds: 1200),
          )
        ],
      ),
    );
  }
}