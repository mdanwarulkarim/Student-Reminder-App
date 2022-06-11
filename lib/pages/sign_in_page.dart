import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_reminder/controllers/auth_controoller.dart';
import 'package:student_reminder/util/constants.dart';
import 'package:student_reminder/util/images.dart';
import 'package:student_reminder/util/routes.dart';
import 'package:student_reminder/util/styles.dart';
import 'package:student_reminder/widget/bg_widget.dart';
import 'package:student_reminder/widget/button_widget.dart';
import 'package:student_reminder/widget/custom_snackbar.dart';
import 'package:student_reminder/widget/text_field_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgWidget(
        child: SafeArea(
          child: Center(child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: GetBuilder<AuthController>(builder: (authController) {
              return Column(children: [

                Image.asset(Images.login, width: 250),
                const SizedBox(height: 30),

                Text('Welcome back \nto', style: poppinsRegular.copyWith(fontSize: 16), textAlign: TextAlign.center),
                const SizedBox(height: 5),
                Text(Constants.name.toUpperCase(), style: poppinsRegular.copyWith(fontSize: 24)),
                const SizedBox(height: 30),

                TextFieldWidget(
                  hintText: 'Email',
                  controller: _emailController,
                  focusNode: _emailNode,
                  nextFocus: _passNode,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                TextFieldWidget(
                  hintText: 'Password',
                  controller: _passController,
                  focusNode: _passNode,
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                ),

                InkWell(
                  onTap: () => Get.toNamed(Routes.getForgetRoute()),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('Forgot Password', style: poppinsMedium.copyWith(fontSize: 14)),
                  ),
                ),

                !authController.isLoading ? ButtonWidget(
                  buttonText: 'Sign In',
                  onPressed: () {
                    String _email = _emailController.text.trim();
                    String _password = _passController.text.trim();
                    if(_email.isEmpty) {
                      showCustomSnackBar('Enter email address');
                    }else if(!GetUtils.isEmail(_email)) {
                      showCustomSnackBar('Enter valid email address');
                    }else if(_password.isEmpty) {
                      showCustomSnackBar('Enter a password');
                    }else if(_password.length < 8) {
                      showCustomSnackBar('Minimum length of password is 8');
                    }else {
                      authController.loginUser(_email, _password);
                    }
                  },
                ) : Center(child: CircularProgressIndicator(color: Theme.of(context).secondaryHeaderColor)),
                const SizedBox(height: 10),

                InkWell(
                  onTap: () => Get.toNamed(Routes.getSignUpRoute()),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text('Don’t have an account?', style: poppinsRegular),
                      const SizedBox(width: 5),
                      Text('Register', style: poppinsRegular.copyWith(color: Colors.white)),
                    ]),
                  ),
                ),

              ]);
            }),
          )),
        ),
      ),
    );
  }
}
