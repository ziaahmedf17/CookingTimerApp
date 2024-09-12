import 'package:cooking_app/utils/app_Strings.dart';
import 'package:cooking_app/utils/app_assets.dart';
import 'package:cooking_app/utils/app_utils.dart';
import 'package:cooking_app/utils/text_style.dart';
import 'package:cooking_app/widgets/custom_button.dart';
import 'package:cooking_app/widgets/custom_row_field.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _validateFields(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  TextEditingController cookTimeController = TextEditingController();
  TextEditingController serveTimeController = TextEditingController();
  TextEditingController saveTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.preBake1,
              height: MediaQuery.sizeOf(context).height * .44,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      AppStrings.settings,
                      style: AppStyle.bakeTitleTextStyle,
                    ),
                    const SizedBox(height: 20),
                    RowTextField(
                        labelText: AppStrings.timeZone,
                        keyboardType: TextInputType.text,
                        validator: _validateFields),
                    const SizedBox(height: 20),
                    RowTextField(
                      labelText: AppStrings.cookAt,
                      controller: cookTimeController,
                      readOnly: true,
                      validator: _validateFields,
                      onTap: () async {
                        TimeOfDay? cookAtSameTime =
                            await AppUtils.timePicker(context);
                        if (cookAtSameTime != null) {
                          cookTimeController.text =
                              cookAtSameTime.format(context);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    RowTextField(
                        labelText: AppStrings.temperature,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: _validateFields),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // _onItemTapped(1);
                        }
                      },
                      child: const CustomButton(
                        textOfButton: AppStrings.letsGobtn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
