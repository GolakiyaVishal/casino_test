import 'dart:io';

import 'package:flutter/material.dart';

class InternetConnection {
  static Future<bool> check(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}