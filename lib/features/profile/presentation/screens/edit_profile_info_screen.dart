import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/components/shared/app_form_field.dart';
import 'package:flutter_talk/core/enums/profile_field_type.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';
import 'package:flutter_talk/features/user/providers/current_user_provider.dart';

class EditProfileInfoPage extends ConsumerStatefulWidget {
  final ProfileFieldType fieldType;
  const EditProfileInfoPage({super.key, required this.fieldType});

  @override
  ConsumerState<EditProfileInfoPage> createState() =>
      _EditProfileInfoPageState();
}

class _EditProfileInfoPageState extends ConsumerState<EditProfileInfoPage> {
  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    // Delay provider read until after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUser = ref.read(currentUserDataProvider);
      if (currentUser == null) return;
      controller.text = widget.fieldType.getInitialValue(currentUser) ?? '';
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _onSave(
    String userId,
    ProfileFieldType fieldType,
    String newValue,
  ) async {
    _checkFormValid();
    if (!_isFormValid) return;
    await ref
        .read(currentUserProvider.notifier)
        .updateUserProfile(fieldType: fieldType, newValue: newValue);
    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("✔️ Info updated successfully")));
    // await Future.delayed(Duration(seconds: 1));
    // if (!mounted) return;
  }

  void _checkFormValid() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    setState(() => _isFormValid = isValid);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDataProvider);

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: Text(AppStrings.editInfo)),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.editInfo)),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.large),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: AppFormField(
                hintText: widget.fieldType.label,
                value: controller.text,
                controller: controller,
                validator: widget.fieldType.validator,
              ),
            ),
            SizedBox(height: AppSizes.small),
            Text(
              widget.fieldType.description,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),

            SizedBox(height: AppSizes.xl),
            ElevatedButton(
              onPressed: () =>
                  _onSave(currentUser.uid, widget.fieldType, controller.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.all(AppSizes.medium),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(AppSizes.radius),
                ),
                minimumSize: Size(double.infinity, AppSizes.medium),
              ),
              child: Text(
                AppStrings.save,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
