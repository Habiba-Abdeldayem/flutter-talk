import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/app_sizes.dart';
import 'package:flutter_talk/core/utils/app_strings.dart';

class AuthFooter extends StatelessWidget {
  final void Function()? onButtonPressed;
  final void Function()? onTogglePagePressed;
  final bool isLoginPage;
  const AuthFooter({super.key, required this.onButtonPressed, required this.isLoginPage, required this.onTogglePagePressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
                      onPressed: onButtonPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        // backgroundColor: _isFormValid
                        //     ? Theme.of(context).colorScheme.primary
                        //     : Theme.of(context).colorScheme.tertiary,
                        padding: EdgeInsets.all(AppSizes.medium),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(
                            AppSizes.radius,
                          ),
                        ),
                        minimumSize: Size(double.infinity, AppSizes.medium),
                      ),
                      child: Text(
                        isLoginPage
                            ? AppStrings.login
                            : AppStrings.signUp,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: AppSizes.small),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isLoginPage
                              ? AppStrings.dontHaveAnAccount
                              : AppStrings.alreadyHaveAnAccount,
                        ),
                        const SizedBox(width: AppSizes.xs),
                        GestureDetector(
                          onTap: onTogglePagePressed,
                          child: Text(
                            isLoginPage
                                ? AppStrings.signUp
                                : AppStrings.login,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
      ],
    );
  }
}
