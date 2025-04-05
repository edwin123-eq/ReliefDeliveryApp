// Add this to a new file like bill_status_constants.dart
import 'dart:ui';

import 'package:flutter/material.dart';

class BillStatus {
  static const int PENDING = 0;
  static const int DELIVERED = 1;
  static const int PARTIALLY_DELIVERED = 3;
  static const int RETURNED = 2;

  static String getStatusString(int status) {
    switch (status) {
      case PENDING:
        return 'Pending';
      case DELIVERED:
        return 'Delivered';
      case PARTIALLY_DELIVERED:
        return 'Partially Delivered';
      case RETURNED:
        return 'Returned';
      default:
        return 'Unknown';
    }
  }

  static Color getStatusColor(int status) {
    switch (status) {
      case DELIVERED:
        return Colors.green;
      case PARTIALLY_DELIVERED:
        return Colors.blue;
      case PENDING:
        return Colors.red;
      case RETURNED:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}