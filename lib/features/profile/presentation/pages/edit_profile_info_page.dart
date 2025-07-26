import 'package:flutter/material.dart';
import 'package:flutter_talk/core/components/shared/app_form_field.dart';
import 'package:flutter_talk/core/enums/profile_field_type.dart';
import 'package:flutter_talk/core/models/user_model.dart';
import 'package:flutter_talk/core/constants/app_strings.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';
import 'package:flutter_talk/features/profile/data/profile_service.dart';

class EditProfileInfoPage extends StatefulWidget {
  final ProfileFieldType fieldType;
  final UserModel currentUser;
  const EditProfileInfoPage({
    super.key,

    required this.currentUser,
    required this.fieldType,
  });

  @override
  State<EditProfileInfoPage> createState() => _EditProfileInfoPageState();
}

class _EditProfileInfoPageState extends State<EditProfileInfoPage> {
  final TextEditingController controller = TextEditingController();
  final ProfileService _profileService = ProfileService();
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _onSave(String userId, ProfileFieldType fieldType, String newValue) {
    _profileService.updateUserField(
      userId: userId,
      fieldType: fieldType,
      newValue: newValue,
    );
    _checkFormValid();
    //TODO update info in firestore
  }

  void _checkFormValid() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    setState(() => _isFormValid = isValid);
  }

  @override
  Widget build(BuildContext context) {
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
                value: widget.fieldType.getInitialValue(widget.currentUser),
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
              onPressed: () => _onSave(
                widget.currentUser.uid,
                widget.fieldType,
                controller.text,
              ),
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
