import 'package:code_quest/core/theme/color_manager.dart';
import 'package:code_quest/core/theme/text_styles_manager.dart';
import 'package:code_quest/core/utils/validator.dart';
import 'package:code_quest/features/authentication/presentation/signup_screen.dart';
import 'package:code_quest/home.dart';
import 'package:code_quest/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/constants.dart';
import '../../../core/local_storage/storage_helper.dart';
import '../../../shared_widgets/custom_button.dart';
import '../../../shared_widgets/custom_text_field.dart';
import '../../providers_screen/presentation/specialist_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                email: true,
                validator: (value) => value!.validateEmail(context),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                hint: 'Enter your password',
                controller: passwordController,
                validator: (value) => value!.validatePassword(context),
              ),
              const SizedBox(height: 50),
              DefaultButton(
                title: 'Login',
                fontSize: 16,
                radius: 8,
                color: ColorManager.primary,
                textColor: Colors.white,
                onTap: () {

                  if (formKey.currentState?.validate() ?? false) {

                    bool isRegistered = false;
                   String userName = '';
                    List<String>? emails =
                        LocalStorage.getData(key: Constants.registeredEmails);

                    emails?.forEach((e) {
                      List<String> text = e.replaceAll(' ', '').split('/');
                      if (text[0] == emailController.text ||
                          text[1] == passwordController.text) {
                        userName = text[2];
                        isRegistered = true;
                      }
                    });
                    if (isRegistered) {
                      LocalStorage.saveData(
                          key: Constants.loggedInEmail,
                          value: emailController.text);
                      LocalStorage.saveData(
                          key: Constants.loggedInUser,
                          value: userName);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomeScreen()),
                          (Route<dynamic> route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Invalid email or password'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
              ),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do not have an account?',
                    style: getRegularStyle(),
                  ),
                  5.horizontalSpace,
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignUpScreen()));
                      },
                      child: Text(
                        'Sign up',
                        style: getSemiBoldStyle(color: ColorManager.primary),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
