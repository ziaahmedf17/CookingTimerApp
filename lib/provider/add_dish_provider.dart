import 'package:cooking_app/models/dish_model.dart';
import 'package:cooking_app/services/database_service.dart';
import 'package:flutter/material.dart';

class AddDishProvider extends ChangeNotifier {
  List<Dish> items = [];
  List<String?> dishesNames = [];
  Dish? selectedDish;
  bool isEmpty = false;
  String? selectedItem;
  List<String> drdItems = [
    '1 minute',
    '3 minutes',
    '5 minutes',
  ];

  void setDishesNames(List<String?> names) {
    dishesNames = names;
  }

  void onDishDropDownChanged(String? value) {
    selectedItem = value;

    notifyListeners();
  }

  AddDishProvider();

  Future<int> addDish(String name, int ovenTem, int cookDur, String remainder,
      String serveTime, String notes) async {
    final res = await DatabaseHelper.instance.insertDish(
      Dish(
        name: name,
        ovenTem: ovenTem,
        cookDuration: cookDur,
        reminder: remainder,
        serveTime: serveTime,
        notes: notes,
      ),
    );
    notifyListeners();
    return res;
  }

  Future<void> getDishes() async {
    await Future.delayed(const Duration(microseconds: 1));
    isEmpty = true;
    notifyListeners();
    List<Map<String, dynamic>> data = await DatabaseHelper.instance.getDishes();
    print(data);
    try {
      items = data.map((item) => Dish.fromMap(item)).toList();
    } catch (e) {
      print('exception $e');
    }
    isEmpty = false;
    notifyListeners();
  }

  Future<int> updateDish(Dish dish) async {
    int res = await DatabaseHelper.instance.updateDish(dish);
    print('update response in provider=====>  $res');
    getDishes();
    return res;
  }

Future<int> deleteDish(int id) async {
  final dishIndex = items.indexWhere((dish) => dish.id == id);

  if (dishIndex >= 0) {
    final deletedDish = items[dishIndex];

    // Remove the dish from the list and dishesNames first
    items.removeAt(dishIndex);
    dishesNames.remove(deletedDish.name);

    // Debugging: Print list and selected item before updating
    print('Updated dishesNames: $dishesNames');
    print('Current selectedItem before update: $selectedItem');

    // Update selectedItem only if the deleted dish was the selected one
    if (selectedItem == deletedDish.name) {
      // If there are more dishes, select another one
      if (items.isNotEmpty) {
        // If deleting the first item, select the next one; otherwise, select the previous one
        selectedDish = (dishIndex == 0) ? items[0] : items[dishIndex - 1];
        selectedItem = selectedDish?.name;
      } else {
        // No other items left, reset the selection
        selectedDish = null;
        selectedItem = null;
      }
    }

    // Debugging: Print list and selected item after updating
    print('Updated selectedItem: $selectedItem');
    notifyListeners();  // Notify listeners after updating the selection
  }

  int res = await DatabaseHelper.instance.deleteDish(id);

  // Fetch the updated list of dishes after deletion
  await getDishes();

  return res;
}

  // Future<int> deletDish(int id) async {
  //   final dishIndex = items.indexWhere((selectedDish) => selectedDish.id == id);
  //   if (dishIndex >= 0) {
  //     selectedItem = null;
  //     final deletedDish = items[dishIndex];
  //     items.removeAt(dishIndex);
  //     dishesNames.remove(deletedDish.name);
  //   }
  //   int res = await DatabaseHelper.instance.deleteDish(id);
  //   getDishes();
  //   notifyListeners();

  //   return res;
  // }

  // Dish getSelectedDishData() {
  //   selectedDish = items.firstWhere((e) => e.name == selectedItem);
  //   selectedItem = selectedDish!.reminder;
  //   notifyListeners();
  //   return selectedDish!;
  // }
  Dish? getSelectedDishData() {
  try {
    selectedDish = items.firstWhere((e) => e.name == selectedItem);
    selectedItem = selectedDish!.reminder;
  } catch (e) {
    print("Error in getSelectedDishData: $e");
    selectedDish = null;  // handle it as per your logic
  }
  notifyListeners();
  return selectedDish!;
}

}
