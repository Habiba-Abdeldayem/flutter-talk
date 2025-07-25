import 'package:flutter/material.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/features/auth/data/auth_repository.dart';
import 'package:flutter_talk/features/auth/presentation/widgets/auth_fields.dart';
import 'package:flutter_talk/features/auth/presentation/widgets/auth_footer.dart';
import 'package:flutter_talk/features/auth/presentation/widgets/auth_header.dart';

class AuthForm extends StatefulWidget {
  final bool isLoginPage;
  final void Function()? onTogglePage;
  const AuthForm({
    super.key,
    required this.onTogglePage,
    required this.isLoginPage,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _authRepository = AuthRepository();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  // If you use await (like waiting for Firebase), and after that you use context, you must check if the widget is still mounted.
  //  After await, the user might leave the screen → context becomes invalid → it crashes.
  void _onFormSubmit() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _isFormValid = isValid;
    });
    if (_isFormValid) {
      try {
        if (widget.isLoginPage) {
          await _authRepository.signIn(
            _emailController.text,
            _passwordController.text,
          );
        } else {
          await _authRepository.signUp(
            _emailController.text,
            _passwordController.text,
            _usernameController.text,
          );
        }
      } catch (e) {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(content: Text(e.toString())),
        );
      }
    }

    // formKey.currentState!.validate() checks all form fields by calling their validator functions.
    // If any field is invalid, it:
    // Returns false
    // Automatically updates the UI and shows error messages under the fields.
    // ✅ No need to call setState() — Flutter handles it for you.
  }

  void checkFormValid() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _isFormValid = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(AppSizes.xxl),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.xl),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthHeader(
                      title: widget.isLoginPage
                          ? AppStrings.login
                          : AppStrings.signUp,
                      imagePath: "lib/core/images/user_avatar.png",
                    ),

                    const SizedBox(height: AppSizes.xl),
                    AuthFields(
                      formKey: _formKey,
                      emailController: _emailController,
                      usernameController: _usernameController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      isLoginPage: widget.isLoginPage,
                    ),

                    const SizedBox(height: AppSizes.xl),
                    AuthFooter(
                      isLoginPage: widget.isLoginPage,
                      onButtonPressed: _onFormSubmit,
                      onTogglePagePressed: widget.onTogglePage,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
