import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_reminder/controllers/auth_controoller.dart';
import 'package:student_reminder/util/styles.dart';
import 'package:student_reminder/widget/bg_widget.dart';
import 'package:student_reminder/widget/button_widget.dart';
import 'package:student_reminder/widget/custom_snackbar.dart';
import 'package:student_reminder/widget/text_field_widget.dart';

class ForgetPage extends StatefulWidget {
  const ForgetPage({Key? key}) : super(key: key);

  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgWidget(child: Column(children: [

        AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: () => Get.back(), icon: Icon(
            Icons.arrow_back_ios, color: Theme.of(context).textTheme.bodyText1!.color ?? Colors.black,
          )),
          title: Text('Forget Password', style: poppinsBold.copyWith(
            fontSize: 24, color: Theme.of(context).textTheme.bodyText1!.color ?? Colors.black,
          )),
          centerTitle: true, elevation: 0,
        ),

        Expanded(child: Center(child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

            const Text(
              'Enter your email address to get password reset mail',
              style: poppinsMedium, textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            TextFieldWidget(
              hintText: 'Email',
              controller: _emailController,
              inputAction: TextInputAction.done,
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),

            GetBuilder<AuthController>(builder: (authController) {
              return !authController.isLoading ? ButtonWidget(
                buttonText: 'Send Mail',
                onPressed: () {
                  String _email = _emailController.text.trim();
                  if(_email.isEmpty) {
                    showCustomSnackBar('Enter email address');
                  }else if(!GetUtils.isEmail(_email)) {
                    showCustomSnackBar('Enter valid email address');
                  }else {
                    authController.resetPassword(_email);
                  }
                },
              ) : Center(child: CircularProgressIndicator(color: Theme.of(context).secondaryHeaderColor));
            }),

          ]),
        ))),

      ])),
    );
  }
}
