import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_reminder/controllers/auth_controoller.dart';
import 'package:student_reminder/controllers/weather_controller.dart';
import 'package:student_reminder/model/user_model.dart';
import 'package:student_reminder/util/images.dart';
import 'package:student_reminder/util/routes.dart';
import 'package:student_reminder/util/styles.dart';
import 'package:student_reminder/util/time_formatter.dart';
import 'package:student_reminder/widget/bg_widget.dart';
import 'package:student_reminder/widget/time_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    Get.find<WeatherController>().getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgWidget(
        alignment: Alignment.topLeft,
        child: Column(children: [

          AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [IconButton(
              onPressed: () => Get.toNamed(Routes.getNotificationRoute()),
              icon: Image.asset(Images.notification, width: 20, height: 20),
            )],
          ),

          Expanded(child: GetBuilder<WeatherController>(builder: (weatherController) {
            return weatherController.weatherModel != null ? SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              physics: const BouncingScrollPhysics(),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                Text('Today info', style: poppinsMedium.copyWith(fontSize: 16)),
                const SizedBox(height: 10),

                InkWell(
                  onTap: () => Get.toNamed(Routes.getWeatherRoute()),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 1)],
                    ),
                    alignment: Alignment.center,
                    child: Column(children: [

                      Text(
                        TimeFormatter.stringDateToDate(weatherController.weatherModel!.forecast!.forecastday![0].date),
                        style: poppinsBold.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 10),

                      // InkWell(
                      //   onTap: () => Get.toNamed(Routes.getWeatherRoute()),
                      //   child: GridView.builder(
                      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 5, mainAxisSpacing: 20, childAspectRatio: 1/2,
                      //     ),
                      //     itemCount: 5,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     shrinkWrap: true,
                      //     padding: EdgeInsets.zero,
                      //     itemBuilder: (context, index) {
                      //       index = index*2;
                      //       return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      //         Text(
                      //           TimeFormatter.stringDateTimeToTime(weatherController.weatherModel!.forecast!.forecastday![0].hour![index].time),
                      //           style: poppinsRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: 12),
                      //         ),
                      //         const SizedBox(height: 10),
                      //         Image.network(
                      //           'https:${weatherController.weatherModel!.forecast!.forecastday![0].hour![index].condition!.icon}',
                      //           height: 30, width: 30,
                      //         ),
                      //         const SizedBox(height: 10),
                      //         Text(
                      //           '${weatherController.weatherModel!.forecast!.forecastday![0].hour![index].tempC}°',
                      //           style: poppinsRegular.copyWith(fontSize: 14),
                      //         ),
                      //       ]);
                      //     },
                      //   ),
                      // ),

                      Row(children: [

                        Expanded(child: Text(
                          '${weatherController.weatherModel!.current!.tempC}°',
                          style: poppinsMedium.copyWith(fontSize: 50), textAlign: TextAlign.center,
                        )),

                        Container(height: 50, width: 2, color: Theme.of(context).disabledColor),

                        Expanded(child: Column(children: [

                          Text(
                            weatherController.weatherModel!.forecast!.forecastday![0].day!.condition!.text!,
                            style: poppinsMedium.copyWith(fontSize: 18), textAlign: TextAlign.center,
                          ),

                          Text(
                            '${weatherController.weatherModel!.forecast!.forecastday![0].day!.maxtempC}°'
                                '/${weatherController.weatherModel!.forecast!.forecastday![0].day!.mintempC}°',
                            style: poppinsRegular.copyWith(fontSize: 18), textAlign: TextAlign.center,
                          ),

                        ]))

                      ]),

                    ]),
                  ),
                ),
                const SizedBox(height: 20),

                Center(child: Text(
                  '${_timeMessage()} ${Get.find<AuthController>().getUserData()!.name}',
                  style: poppinsBold.copyWith(fontSize: 16),
                )),
                const SizedBox(height: 10),

                SizedBox(
                  height: 150,
                  child: Row(children: [
                    Expanded(flex: 2, child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFf1d7ba), Color(0xFFf3a95c)],
                          begin: Alignment.centerLeft, end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(
                          color: Colors.grey[600] ?? Colors.grey, blurRadius: 5,
                          spreadRadius: 0.5, offset: const Offset(3, 3),
                        )],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(children: [
                        TimeWidget(title: DateFormat('HH').format(DateTime.now())),
                        const SizedBox(width: 10),
                        TimeWidget(title: DateFormat('mm').format(DateTime.now())),
                      ]),
                    // )),
                    // const SizedBox(width: 10),
                    // Expanded(flex: 1, child: Container(
                    //   decoration: BoxDecoration(
                    //     gradient: const LinearGradient(
                    //       colors: [Color(0xFFf3a95c), Color(0xFFf1d7ba)],
                    //       begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    //     ),
                    //     borderRadius: BorderRadius.circular(20),
                    //     boxShadow: [BoxShadow(
                    //       color: Colors.grey[600] ?? Colors.grey, blurRadius: 5,
                    //       spreadRadius: 0.5, offset: const Offset(3, 3),
                    //     )],
                    //   ),
                    //   padding: const EdgeInsets.all(10),
                    //   child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    //     TimeWidget(title: weatherController.weatherModel!.forecast!.forecastday![0].day!.maxtempC.toString()),
                    //     const SizedBox(height: 10),
                    //     TimeWidget(title: weatherController.weatherModel!.forecast!.forecastday![0].day!.mintempC.toString()),
                    //   ]),
                    )),
                  ]),
                ),
                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: boxShadow,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    Text('Tasks List', style: poppinsBold.copyWith(color: const Color(0xFF588157))),
                    const SizedBox(height: 10),

                    GetBuilder<AuthController>(builder: (authController) {
                      return authController.getUserData()!.todoList!.isNotEmpty ? ListView.builder(
                        itemCount: authController.getUserData()!.todoList!.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Positioned(
                                top: 0, bottom: 0, left: 0, right: 0,
                                child: Container(
                                  color: Colors.red,
                                  child: const Icon(Icons.delete, color: Colors.white),
                                ),
                              ),
                              Dismissible(
                                key: UniqueKey(),
                                onDismissed: (DismissDirection direction) => authController.updateTodo(index, null, false),
                                child: InkWell(
                                  onTap: () => Get.dialog(Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        Center(child: Text(
                                          authController.getUserData()!.todoList![index].title!,
                                          style: poppinsMedium.copyWith(fontSize: 16),
                                        )),
                                        const SizedBox(height: 10),
                                        Row(children: [
                                          Text(
                                            'Task Time:',
                                            style: poppinsMedium.copyWith(fontSize: 12), maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            DateFormat('dd MMM yyyy - hh:mm a').format(authController.getUserData()!.todoList![index].date!),
                                            style: poppinsRegular.copyWith(fontSize: 12), maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ]),
                                        const SizedBox(height: 10),
                                        Text(
                                          authController.getUserData()!.todoList![index].details!,
                                          style: poppinsRegular.copyWith(fontSize: 12),
                                        ),
                                      ]),
                                    ),
                                  )),
                                  child: Container(
                                    color: Theme.of(context).cardColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(children: [
                                        Container(
                                          height: 10, width: 10,
                                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          authController.getUserData()!.todoList![index].title!,
                                          style: poppinsRegular.copyWith(fontSize: 12), maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ) : const Center(child: Text('No todo added'));
                    }),

                  ]),
                ),

              ]),
            ) : Center(child: CircularProgressIndicator(color: Theme.of(context).secondaryHeaderColor));
          })),

        ]),
      ),
    );
  }

  String _timeMessage() {
    String _message = '';
    DateTime _now = DateTime.now();
    if(_now.isAfter(_setTime(00, 00, 00)) && _now.isBefore(_setTime(04, 59, 59))) {
      _message = 'Happy Sleeping';
    }else if(_now.isAfter(_setTime(05, 00, 00)) && _now.isBefore(_setTime(11, 59, 59))) {
      _message = 'Good Morning';
    }else if(_now.isAfter(_setTime(12, 00, 00)) && _now.isBefore(_setTime(14, 59, 59))) {
      _message = 'Good Afternoon';
    }else if(_now.isAfter(_setTime(17, 00, 00)) && _now.isBefore(_setTime(20, 59, 59))) {
      _message = 'Good Evening';
    }else {
      _message = 'Good Night';
    }
    return _message;
  }

  DateTime _setTime(int hour, int minute, int second) {
    return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute, second);
  }

}
