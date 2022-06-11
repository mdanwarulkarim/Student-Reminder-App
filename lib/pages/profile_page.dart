import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_reminder/controllers/auth_controoller.dart';
import 'package:student_reminder/util/images.dart';
import 'package:student_reminder/util/routes.dart';
import 'package:student_reminder/util/styles.dart';
import 'package:student_reminder/widget/bg_widget.dart';
import 'package:student_reminder/widget/profile_button.dart';

class ProfilePage extends StatefulWidget {
  final Function onTap;
  const ProfilePage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgWidget(child: Column(children: [

        AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF1E3637),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Text('Profile', style: poppinsRegular.copyWith(color: Colors.white)),
          ),
          centerTitle: true, elevation: 0,
        ),
        const SizedBox(height: 20),

        GetBuilder<AuthController>(builder: (authController) {
          return InkWell(
            onTap: () => authController.updateProfileImage(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              padding: const EdgeInsets.all(5),
              child: ClipOval(child: authController.getUserData()!.image != null ? FadeInImage.assetNetwork(
                placeholder: Images.profile, image: authController.getUserData()!.image!, height: 100, width: 100, fit: BoxFit.cover,
              ) : Image.asset(Images.profile, height: 100, width: 100)),
            ),
          );
        }),
        const SizedBox(height: 10),

        Text(Get.find<AuthController>().getUserData()!.name!, style: poppinsMedium.copyWith(fontSize: 16)),
        Text(Get.find<AuthController>().getUserData()!.gender!, style: poppinsRegular),
        const SizedBox(height: 20),
        Container(height: 25, width: context.width, color: Theme.of(context).secondaryHeaderColor),

        Expanded(child: Container(
          color: Theme.of(context).cardColor,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              const SizedBox(height: 50),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor,
                  boxShadow: boxShadow,
                ),
                padding: const EdgeInsets.all(20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  Text('Other', style: poppinsSemiBold.copyWith(fontSize: 16)),
                  const SizedBox(height: 20),

                  ProfileButton(icon: Images.task, title: 'List All Task', onTap: widget.onTap),
                  ProfileButton(icon: Images.privacy, title: 'Privacy Policy', onTap: () => Get.toNamed(Routes.getPrivacyPolicyRoute())),
                  ProfileButton(icon: Images.settings, title: 'Settings', onTap: () => Get.toNamed(Routes.getSettingsRoute())),
                  ProfileButton(icon: Images.logout, title: 'Logout', onTap: () {
                    FirebaseAuth.instance.signOut();
                    Get.toNamed(Routes.getSignUpRoute());
                  }),

                ]),
              ),

            ]),
          ),
        )),
      ])),
    );
  }

  String getAge(DateTime dob) {
    return '${DateTime.now().difference(dob).inDays~/365}yo';
  }
}
