import 'package:flutter/material.dart';
import 'package:get/get.dart';

const poppinsRegular = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

const poppinsMedium = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 14,
);

const poppinsSemiBold = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  fontSize: 14,
);

const poppinsBold = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  fontSize: 14,
);

const poppinsBlack = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w900,
  fontSize: 14,
);

List<BoxShadow> boxShadow = [BoxShadow(
  color: Colors.grey[Get.isDarkMode ? 700 : 300] ?? Colors.grey, blurRadius: 5, spreadRadius: 1,
)];