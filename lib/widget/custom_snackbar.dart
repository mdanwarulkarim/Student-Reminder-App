import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String? message, {bool isError = true}) {
  if(message != null && message.isNotEmpty) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      message: message,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}