import 'dart:async';
import 'package:deliveryapp/app_confiq/app_colors.dart';
import 'package:deliveryapp/app_confiq/global_Messenger_key.dart';
import 'package:deliveryapp/app_confiq/sizeConfiq.dart';
import 'package:flutter/material.dart';

Future<void> snackBarWidget({
  required BuildContext context,
  required String msg,
  required IconData icons,
  required Color iconcolor,
  required Color texcolor,
  required Color backgeroundColor,
}) async {
  final completer = Completer<void>();

  final snackbar = SnackBar(
    shape: const StadiumBorder(),
    behavior: SnackBarBehavior.floating,
    backgroundColor: AppColors.textPrimary,
    margin: EdgeInsets.only(
        bottom: SizeConfig.screenheight * .85 - kToolbarHeight,
        left: SizeConfig.screenwidth * .035,
        right: SizeConfig.screenwidth * .035),
    duration: const Duration(seconds: 2),
    content: Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: SizeConfig.screenwidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: SizeConfig.screenwidth * .75,
              child: Text(
                msg,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: texcolor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              icons,
              color: iconcolor,
            )
          ],
        ),
      ),
    ),
  );
  scaffoldMsgKey.currentState?.showSnackBar(snackbar).closed.then((reason) {
    if (!completer.isCompleted) {
      completer.complete();
    }
  });

  return completer.future;
}
