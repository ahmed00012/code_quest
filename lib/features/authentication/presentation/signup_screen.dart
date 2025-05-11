import 'package:code_quest/core/utils/constants.dart';
import 'package:code_quest/core/local_storage/storage_helper.dart';
import 'package:code_quest/core/theme/color_manager.dart';
import 'package:code_quest/core/theme/text_styles_manager.dart';
import 'package:code_quest/core/utils/validator.dart';
import 'package:code_quest/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/popup_dialogs.dart';
import '../../../shared_widgets/custom_button.dart';
import '../../../shared_widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                label: 'Username',
                hint: 'Enter username',
                validator: (value) => value!.validateName(context),
                controller: usernameController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                  label: 'Phone Number',
                  hint: 'Enter your phone number',
                  controller: phoneController,
                  validator: (value) => value!.validatePhoneNumber(context)),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                email: true,
                controller: emailController,
                validator: (value) => value!.validateEmail(context),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                hint: 'Enter your password',
                password: true,
                controller: passwordController,
                validator: (value) => value!.validatePassword(context),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Confirm Password',
                hint: 'Confirm password',
                password: true,
                controller: confirmPasswordController,
                validator: (value) => value!.validatePasswordConfirm(context,
                    pass: passwordController.text),
              ),
              const SizedBox(height: 50),
              DefaultButton(
                title: 'Sign Up',
                fontSize: 16,
                radius: 8,
                color: ColorManager.primary,
                textColor: Colors.white,
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    List<String> emails =
                        LocalStorage.getData(key: Constants.registeredEmails) ?? [];
                    emails.add('${emailController.text} / ${passwordController.text} / ${usernameController.text}');
                    LocalStorage.saveStringListData(
                        key: Constants.registeredEmails, value: emails);
                    Navigator.pop(context);
                    PopupDialogs.showToast(
                      'Account created successfully',
                    );
                  }
                },
              ),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do you have an account?',
                    style: getRegularStyle(),
                  ),
                  5.horizontalSpace,
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: getSemiBoldStyle(color: ColorManager.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
