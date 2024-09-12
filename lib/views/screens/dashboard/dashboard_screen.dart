import 'package:cooking_app/models/dish_model.dart';
import 'package:cooking_app/provider/dashboard_provider.dart';
import 'package:cooking_app/utils/app_assets.dart';
import 'package:cooking_app/views/screens/dashboard/add_dish_screen.dart';
import 'package:cooking_app/views/screens/dashboard/dish_detail_screen.dart';
import 'package:cooking_app/views/screens/dashboard/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  late DashboardProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<DashboardProvider>(context, listen: false);
  }

  @override
  void dispose() {
    provider.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: provider.pageController,
          onPageChanged: (index) {
            provider.onPageChanged(index);
          },
          children: [
            const AddDishScreen(),
            const SettingsScreen(),
            const TimeLineScreen(),
            AddDishScreen(
              dish: Dish(
                name: '',
                cookDuration: 0,
                ovenTem: 0,
                reminder: '',
                serveTime: '',
                notes: '',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Stack(
          children: [
            Image.asset(
              AppAssets.bottombar,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Consumer<DashboardProvider>(builder: (context, value, snapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => _buildNavItem(provider.bottomItems[index].image,
                      provider.bottomItems[index].label, index),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          provider.onBottomChange(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 30,
              height: 30,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: provider.index == index ? Colors.black : Colors.black,
                fontWeight: provider.index == index
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
