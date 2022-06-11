import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_reminder/controllers/auth_controoller.dart';
import 'package:student_reminder/util/images.dart';
import 'package:student_reminder/util/routes.dart';
import 'package:student_reminder/util/styles.dart';
import 'package:student_reminder/widget/bg_widget.dart';
import 'package:student_reminder/widget/button_widget.dart';
import 'package:student_reminder/widget/custom_snackbar.dart';
import 'package:student_reminder/widget/text_field_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passNode = FocusNode();
  final FocusNode _confirmPassNode = FocusNode();
  String _gender = 'Choose Gender';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: BgWidget(
        child: SafeArea(
          child: Center(child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: GetBuilder<AuthController>(builder: (authController) {
              return Column(children: [

                Image.asset(Images.registration, width: 250),
                const SizedBox(height: 20),

                Text(
                  'Get’s things done\n with TODO', style: poppinsRegular.copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text('Let’s help you meet up your tasks', style: poppinsRegular.copyWith(fontSize: 12)),
                const SizedBox(height: 20),

                TextFieldWidget(
                  hintText: 'Full Name',
                  controller: _nameController,
                  focusNode: _nameNode,
                  nextFocus: _emailNode,
                  inputType: TextInputType.name,
                  capitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 20),

                TextFieldWidget(
                  hintText: 'Email',
                  controller: _emailController,
                  focusNode: _emailNode,
                  nextFocus: _passNode,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).cardColor,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    Image.asset(Images.gender, height: 20, width: 20),
                    const SizedBox(width: 10),
                    Expanded(child: DropdownButton<String>(
                      value: _gender,
                      isExpanded: true,
                      items: <String>['Choose Gender', 'Male', 'Female'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      underline: const SizedBox(),
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    )),
                  ]),
                ),
                const SizedBox(height: 20),

                TextFieldWidget(
                  hintText: 'Password',
                  controller: _passController,
                  focusNode: _passNode,
                  nextFocus: _confirmPassNode,
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                ),
                const SizedBox(height: 20),

                TextFieldWidget(
                  hintText: 'Confirm Password',
                  controller: _confirmPassController,
                  focusNode: _confirmPassNode,
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                ),
                const SizedBox(height: 30),

                !authController.isLoading ? ButtonWidget(
                  buttonText: 'Register',
                  onPressed: () {
                    String _name = _nameController.text.trim();
                    String _email = _emailController.text.trim();
                    String _password = _passController.text.trim();
                    String _confirmPassword = _confirmPassController.text.trim();
                    if(_name.isEmpty) {
                      showCustomSnackBar('Enter your full name');
                    }else if(_gender == 'Choose Gender') {
                      showCustomSnackBar('Choose your gender');
                    }else if(_email.isEmpty) {
                      showCustomSnackBar('Enter email address');
                    }else if(!GetUtils.isEmail(_email)) {
                      showCustomSnackBar('Enter valid email address');
                    }else if(_password.isEmpty) {
                      showCustomSnackBar('Enter a password');
                    }else if(_password.length < 8) {
                      showCustomSnackBar('Minimum length of password is 8');
                    }else if(_password != _confirmPassword) {
                      showCustomSnackBar('Confirm password does not matched');
                    }else {
                      authController.registerUser(_email, _password, _name, _gender);
                    }
                  },
                ) : Center(child: CircularProgressIndicator(color: Theme.of(context).secondaryHeaderColor)),
                const SizedBox(height: 10),

                InkWell(
                  onTap: () => Get.toNamed(Routes.getSignInRoute()),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text('Already have an account?', style: poppinsRegular),
                      const SizedBox(width: 5),
                      Text('Sign In', style: poppinsRegular.copyWith(color: Colors.white)),
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
