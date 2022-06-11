import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:student_reminder/controllers/theme_controller.dart';
import 'package:student_reminder/util/constants.dart';
import 'package:student_reminder/util/styles.dart';
import 'package:student_reminder/widget/bg_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgWidget(child: Column(children: [

        AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: () => Get.back(), icon: Icon(
            Icons.arrow_back_ios, color: Theme.of(context).textTheme.bodyText1!.color ?? Colors.black,
          )),
          title: Text('Settings', style: poppinsBold.copyWith(
            fontSize: 24, color: Theme.of(context).textTheme.bodyText1!.color ?? Colors.black,
          )),
          centerTitle: true, elevation: 0,
        ),

        Expanded(child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            const SizedBox(height: 20),

            InkWell(
              onTap: () => Share.share(Constants.name),
              child: Row(children: [
                Container(height: 5, width: 5, decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyText1!.color,
                )),
                const SizedBox(width: 10),
                Text('Share with Friends', style: poppinsSemiBold.copyWith(fontSize: 16)),
              ]),
            ),
            const SizedBox(height: 20),

            Row(children: [
              Container(height: 5, width: 5, decoration: BoxDecoration(
                shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyText1!.color,
              )),
              const SizedBox(width: 10),
              Text('Theme Change:', style: poppinsSemiBold.copyWith(fontSize: 16)),
            ]),
            GetBuilder<ThemeController>(builder: (themeController) {
              return Row(children: [
                Expanded(child: InkWell(
                  onTap: () => themeController.setTheme(false),
                  child: Row(children: [
                    Radio(
                      value: false,
                      groupValue: themeController.darkTheme,
                      activeColor: Theme.of(context).secondaryHeaderColor,
                      onChanged: (bool? darkTheme) => themeController.setTheme(false),
                    ),
                    const Text('Light Mode', style: poppinsSemiBold),
                  ]),
                )),
                Expanded(child: InkWell(
                  onTap: () => themeController.setTheme(true),
                  child: Row(children: [
                    Radio(
                      value: true,
                      groupValue: themeController.darkTheme,
                      activeColor: Theme.of(context).secondaryHeaderColor,
                      onChanged: (bool? darkTheme) => themeController.setTheme(true),
                    ),
                    const Text('Dark Mode', style: poppinsSemiBold),
                  ]),
                )),
              ]);
            }),
            const SizedBox(height: 20),

            Row(children: [
              Container(height: 5, width: 5, decoration: BoxDecoration(
                shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyText1!.color,
              )),
              const SizedBox(width: 10),
              Text('Contact Us', style: poppinsSemiBold.copyWith(fontSize: 16)),
            ]),
            const SizedBox(height: 10),

            const Text(
              'It should be mentioned that sending us comments or bug reports is entirely up to your own free will and '
                  'discretion.\n\nKarim247live@gmail.com is the email address to contact if you have questions about our '
                  'privacy policies or concerns about how your personal information is being handled. We will do our best '
                  'to respond to your inquiries in a timely way.',
              style: poppinsRegular,
            ),

          ]),
        )),

      ])),
    );
  }
}
