import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_reminder/util/constants.dart';
import 'package:student_reminder/util/images.dart';
import 'package:student_reminder/util/routes.dart';
import 'package:student_reminder/util/styles.dart';
import 'package:student_reminder/widget/bg_widget.dart';
import 'package:student_reminder/widget/button_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgWidget(
        child: SafeArea(child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            
            Image.asset(Images.welcome, width: 250),
            const SizedBox(height: 50),

            Text(
              'Welcome to\n${Constants.name}',
              style: poppinsMedium.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'This appliaction helps the students to keep plan their daily activites and see the weather update and time',
                style: poppinsRegular.copyWith(fontSize: 12), textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 70),

            ButtonWidget(
              buttonText: 'Get Start',
              onPressed: () => Get.toNamed(Routes.getSignUpRoute()),
            ),

          ]),
        )),
      ),
    );
  }
}
