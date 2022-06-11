import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_reminder/controllers/weather_controller.dart';
import 'package:student_reminder/util/styles.dart';
import 'package:student_reminder/util/time_formatter.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<WeatherController>(builder: (weatherController) {
          return weatherController.weatherModel != null ? Column(children: [

            AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(onPressed: () => Get.back(), icon: Icon(
                Icons.arrow_back_ios, color: Theme.of(context).textTheme.bodyText1!.color ?? Colors.black,
              )),
              title: Text('Weather', style: poppinsBold.copyWith(
                fontSize: 24, color: Theme.of(context).textTheme.bodyText1!.color ?? Colors.black,
              )),
              centerTitle: true, elevation: 0,
            ),

            Expanded(child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withOpacity(0.5)],
                      begin: Alignment.bottomCenter, end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      weatherController.weatherModel!.current!.condition!.text!,
                      style: poppinsRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      TimeFormatter.stringDateToDate(weatherController.weatherModel!.forecast!.forecastday![0].date),
                      style: poppinsBold.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5, mainAxisSpacing: 20, childAspectRatio: 1/2,
                      ),
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        index = index * 2;
                        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(
                            TimeFormatter.stringDateTimeToTime(weatherController.weatherModel!.forecast!.forecastday![0].hour![index].time),
                            style: poppinsRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5), fontSize: 12),
                          ),
                          const SizedBox(height: 10),
                          Image.network(
                            'https:${weatherController.weatherModel!.forecast!.forecastday![0].hour![index].condition!.icon}',
                            height: 30, width: 30,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${weatherController.weatherModel!.forecast!.forecastday![0].hour![index].tempC}°',
                            style: poppinsRegular.copyWith(fontSize: 14),
                          ),
                        ]);
                      },
                    ),
                  ]),
                ),
                const SizedBox(height: 20),

                Text('Forecast', style: poppinsMedium.copyWith(fontSize: 16)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withOpacity(0.5)],
                      begin: Alignment.bottomCenter, end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      weatherController.weatherModel!.current!.condition!.text!,
                      style: poppinsRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      TimeFormatter.stringDateToDate(weatherController.weatherModel!.forecast!.forecastday![0].date),
                      style: poppinsBold.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      itemCount: (weatherController.weatherModel!.forecast!.forecastday![0].hour!.length/2).ceil(),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        index = index * 2;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(children: [
                            SizedBox(width: 50, child: Text(
                              TimeFormatter.stringDateTimeToTime(weatherController.weatherModel!.forecast!.forecastday![0].hour![index].time),
                              style: poppinsRegular,
                            )),
                            const SizedBox(width: 10),
                            Image.network(
                              'https:${weatherController.weatherModel!.forecast!.forecastday![0].hour![index].condition!.icon}',
                              height: 35, width: 35,
                            ),
                            const SizedBox(width: 20),
                            Expanded(child: Text(
                              weatherController.weatherModel!.forecast!.forecastday![0].hour![index].condition!.text!,
                              style: poppinsRegular.copyWith(fontSize: 14),
                            )),
                            const SizedBox(width: 10),
                            Text(
                              '${weatherController.weatherModel!.forecast!.forecastday![0].hour![index].tempC}°',
                              style: poppinsRegular.copyWith(fontSize: 14),
                            ),
                          ]),
                        );
                      },
                    ),
                  ]),
                )

              ]),
            )),

          ]) : Center(child: CircularProgressIndicator(color: Theme.of(context).secondaryHeaderColor));
        }),
      ),
    );
  }
}
