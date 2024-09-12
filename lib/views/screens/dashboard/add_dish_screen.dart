import 'package:cooking_app/models/dish_model.dart';
import 'package:cooking_app/provider/add_dish_provider.dart';
import 'package:cooking_app/provider/dashboard_provider.dart';
import 'package:cooking_app/utils/app_Strings.dart';
import 'package:cooking_app/utils/app_assets.dart';
import 'package:cooking_app/utils/app_utils.dart';
import 'package:cooking_app/utils/text_style.dart';
import 'package:cooking_app/views/screens/dashboard/dish_detail_screen.dart';
import 'package:cooking_app/widgets/custom_button.dart';
import 'package:cooking_app/widgets/custom_row_field.dart';
import 'package:cooking_app/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDishScreen extends StatefulWidget {
  final Dish? dish;

  const AddDishScreen({super.key, this.dish});

  @override
  State<AddDishScreen> createState() => _AddDishScreenState();
}

class _AddDishScreenState extends State<AddDishScreen> {
  final _formKey = GlobalKey<FormState>();
  late AddDishProvider provider;
  // late List<Dish> sDish;
  late TextEditingController cookdurationController;
  late TextEditingController nameController;
  late TextEditingController ovenTemController;
  late TextEditingController serveTimeController;
  late TextEditingController notesController;

  @override
  void initState() {
    provider = Provider.of<AddDishProvider>(context, listen: false);
    cookdurationController = TextEditingController();
    nameController = TextEditingController();
    ovenTemController = TextEditingController();
    serveTimeController = TextEditingController();
    notesController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    cookdurationController.dispose();
    nameController.dispose();
    ovenTemController.dispose();
    serveTimeController.dispose();
    notesController.dispose();
  }

  void clearTextFields() {
    nameController.clear();
    ovenTemController.clear();
    cookdurationController.clear();
    serveTimeController.clear();
    notesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    provider.getDishes();
    List<String?> dishesNames = provider.items.map((e) => e.name).toList();
    // provider.selectedItem = null;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.dishMaker,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            widget.dish == null
                                ? Text(
                                    AppStrings.addDishTitle,
                                    style: AppStyle.dishTitleTextStyle,
                                  )
                                : Text(
                                    AppStrings.editDish,
                                    style: AppStyle.dishTitleTextStyle,
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            widget.dish == null
                                ? RowTextField(
                                    controller: nameController,
                                    labelText: AppStrings.dishName,
                                    keyboardType: TextInputType.text,
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                          flex: 2,
                                          child: Text(AppStrings.dishName)),
                                      Expanded(
                                        flex: 4,
                                        child: Consumer<AddDishProvider>(
                                            builder: (context, val, child) {
                                          print(
                                              'build again drop down ${val.selectedItem}');
                                          return CustomDropDownWidget(
                                            selected: null,
                                            title: 'Select a Dish',
                                            list: dishesNames,
                                            onChanged: (value) {
                                              val.selectedItem = value;

                                              final dish =
                                                  val.getSelectedDishData();
                                              print(dish);
                                              ovenTemController.text =
                                                  dish!.ovenTem.toString();
                                              cookdurationController.text =
                                                  dish.cookDuration.toString();
                                              serveTimeController.text =
                                                  dish.serveTime!;
                                              notesController.text =
                                                  dish.notes!;
                                              // provider.selectedItem =
                                              //     dish.reminder;
                                            },
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            RowTextField(
                                controller: ovenTemController,
                                labelText: AppStrings.ovenTemp,
                                isRequired: true,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value!.length > 3) {
                                    return 'No more than 3 digits';
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            RowTextField(
                              labelText: AppStrings.cookDure,
                              controller: cookdurationController,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                    flex: 2, child: Text(AppStrings.reminder)),
                                Expanded(
                                  flex: 4,
                                  child: Consumer<AddDishProvider>(
                                      builder: (context, val, snapshot) {
                                    return CustomDropDownWidget(
                                      selected: val.selectedItem,
                                      title: AppStrings.reminder,
                                      list: provider.drdItems,
                                      onChanged: (value) {
                                        provider.selectedItem = value;
                                        print(
                                            'selected dish===> {$provider.selectedItem}');
                                      },
                                    );
                                  }),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            RowTextField(
                              labelText: AppStrings.serveTimeField,
                              controller: serveTimeController,
                              readOnly: true,
                              onTap: () async {
                                TimeOfDay? serveTime =
                                    await AppUtils.timePicker(context);
                                if (serveTime != null) {
                                  serveTimeController.text =
                                      serveTime.format(context);
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RowTextField(
                              controller: notesController,
                              labelText: AppStrings.notes,
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            widget.dish == null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          // provider.getDishNames();
                                        },
                                        child: const CustomButton(
                                          textOfButton: AppStrings.addBtn,
                                          width: 120,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            int res = await provider.addDish(
                                                nameController.text,
                                                int.parse(
                                                    ovenTemController.text),
                                                int.parse(
                                                  cookdurationController.text,
                                                ),
                                                provider.selectedItem
                                                    .toString(),
                                                serveTimeController.text,
                                                notesController.text);
                                            clearTextFields();
                                            // Nav.to(const TimeLineScreen());
                                            print(res);
                                          }
                                        },
                                        child: const CustomButton(
                                          textOfButton: AppStrings.nextBtn,
                                          width: 120,
                                        ),
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomButton(
                                        textOfButton: AppStrings.updateBtn,
                                        width: 80,
                                        onTap: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            int result =
                                                await provider.updateDish(
                                              Dish(
                                                  id: provider.selectedDish!.id,
                                                  cookDuration: int.parse(
                                                      cookdurationController
                                                          .text),
                                                  name: provider
                                                      .selectedDish!.name,
                                                  ovenTem: int.parse(
                                                      ovenTemController.text),
                                                  reminder:
                                                      provider.selectedItem,
                                                  serveTime:
                                                      serveTimeController.text,
                                                  notes: notesController.text),
                                            );
                                            print(
                                                'responce of updateDish is ============> $result');
                                            Nav.to(const TimeLineScreen());
                                          }
                                        },
                                      ),
                                      CustomButton(
                                        textOfButton: AppStrings.cancelBtn,
                                        width: 80,
                                        onTap: () =>
                                            Provider.of<DashboardProvider>(
                                                    context,
                                                    listen: false)
                                                .onBottomChange(2),
                                      ),
                                      CustomButton(
                                        textOfButton: AppStrings.deleteBtn,
                                        width: 80,
                                        onTap: () {
                                          provider.setDishesNames(dishesNames);
                                          final result = provider. deleteDish(
                                            provider.selectedDish!.id!,
                                          );
                                             setState(() {});
                                          clearTextFields();
                                          // provider.selectedItem = null;
                                       
                                          print('result of del $result');
                                          Nav.to(const TimeLineScreen());
                                        },
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
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
