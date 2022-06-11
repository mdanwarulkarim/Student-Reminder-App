import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_reminder/model/weather_model.dart';
import 'package:student_reminder/widget/custom_snackbar.dart';

class WeatherController extends GetxController implements GetxService {

  WeatherModel? _weatherModel;
  WeatherModel? get weatherModel => _weatherModel;

  Future<void> getWeatherData() async {
    try {
      GetConnect _connect = GetConnect(timeout: const Duration(seconds: 30));
      Response _response = await _connect.get('https://api.weatherapi.com/v1/forecast.json?key=6eb9a4e894c24c7894f155052220206&q=Malaysia&days=1&aqi=no&alerts=no');
      if(_response.statusCode == 200) {
        _weatherModel = WeatherModel.fromJson(_response.body);
        debugPrint('---------Printed data: ${_weatherModel!.toJson()}');
      }else {
        showCustomSnackBar('Failed to fetch data');
      }
    }catch(e) {
      showCustomSnackBar('Failed to fetch data');
    }
    update();
  }

}