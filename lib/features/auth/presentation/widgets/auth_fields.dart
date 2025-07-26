import 'package:flutter/material.dart';
import 'package:flutter_talk/core/components/shared/app_form_field.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/core/utils/validators.dart';

class AuthFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoginPage;

  const AuthFields({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoginPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isLoginPage)
          AppFormField(
            controller: usernameController,
            validator: (value) => validateName(value),
            hintText: AppStrings.username,
          ),
        const SizedBox(height: AppSizes.small),

        AppFormField(
          controller: emailController,
          validator: (value) => validateEmail(value),
          hintText: AppStrings.email,
        ),
        const SizedBox(height: AppSizes.small),

        AppFormField(
          controller: passwordController,
          validator: (value) => validatePassword(value),
          hintText: AppStrings.password,
          isPassword: true,
        ),

        if (!isLoginPage) ...[
          const SizedBox(height: AppSizes.small),

          AppFormField(
            controller: confirmPasswordController,
            validator: validateConfirmPassword(passwordController.text),
            hintText: AppStrings.password,
            isPassword: true,
          ),
          const SizedBox(height: AppSizes.small),
        ],
      ],
    );
  }
}
