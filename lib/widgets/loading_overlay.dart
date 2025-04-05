import 'package:deliveryapp/app_confiq/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverlay {
  OverlayEntry? _overlay;

  LoadingOverlay();

  void hide() {
    if (_overlay != null) {
      _overlay!.remove();
      _overlay = null;
    }
  }

  void show(BuildContext context) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        // replace with your own layout
        builder: (context) => const ColoredBox(
          color: Color(0x80000000),
          child: Center(
              child: SpinKitFadingCircle(
            color: AppColors.bottomclr,
            size: 70.0,
            duration: Duration(milliseconds: 1200),
          )),
        ),
      );
      Overlay.of(context).insert(_overlay!);
    }
  }
}