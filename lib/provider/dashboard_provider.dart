// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cooking_app/utils/app_Strings.dart';
import 'package:cooking_app/utils/app_assets.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int _index = 0;
  late PageController pageController;
  DashboardProvider() {
    pageController = PageController(initialPage: _index);
  }

  int get index => _index;
  void onBottomChange(int index) {
    _index = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    notifyListeners();
  }

  void onPageChanged(int index) {
    _index = index;
    notifyListeners();
  }

  List<BottomItem> bottomItems = [
    BottomItem(AppAssets.addDish, AppStrings.addDishIcon),
    BottomItem(AppAssets.spoon, AppStrings.settings),
    BottomItem(AppAssets.timeLine, AppStrings.timeLineIcon),
    BottomItem(AppAssets.about, AppStrings.about),
  ];
}

class BottomItem {
  String image;
  String label;
  BottomItem(this.image, this.label);
}
