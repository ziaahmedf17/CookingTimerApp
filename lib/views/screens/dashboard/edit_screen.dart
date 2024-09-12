import 'package:cooking_app/utils/app_assets.dart';
import 'package:cooking_app/utils/app_strings.dart';
import 'package:cooking_app/utils/app_utils.dart';
import 'package:cooking_app/utils/text_style.dart';
import 'package:cooking_app/views/screens/dashboard/dish_detail_screen.dart';
import 'package:cooking_app/widgets/custom_button.dart';
import 'package:cooking_app/widgets/custom_row_field.dart';
import 'package:flutter/material.dart';

class EditDishScreen extends StatefulWidget {
  const EditDishScreen({
    super.key,
  });

  @override
  State<EditDishScreen> createState() => _EditDishScreenState();
}

class _EditDishScreenState extends State<EditDishScreen> {
  TextEditingController durationController = TextEditingController();
  TextEditingController reminderEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppAssets.dishMaker),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        AppStrings.editDish,
                        style: AppStyle.dishTitleTextStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const RowTextField(
                        labelText: AppStrings.dishName,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const RowTextField(
                        labelText: AppStrings.ovenTemp,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RowTextField(
                        labelText: AppStrings.cookDure,
                        controller: durationController,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? durationTime =
                              await AppUtils.timePicker(context);
                          if (durationTime != null) {
                            durationController.text =
                                durationTime.format(context);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const RowTextField(
                        labelText: AppStrings.reminder,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const RowTextField(
                        labelText: AppStrings.notes,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomButton(
                      textOfButton: AppStrings.updateBtn,
                      width: 85,
                    ),
                    CustomButton(
                      onTap: () => Nav.to(const TimeLineScreen()),
                      textOfButton: AppStrings.cancelBtn,
                      width: 85,
                    ),
                    const CustomButton(
                      textOfButton: AppStrings.deleteBtn,
                      width: 85,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
