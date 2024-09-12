import 'dart:async';

import 'package:cooking_app/utils/app_Strings.dart';
import 'package:cooking_app/utils/app_assets.dart';
import 'package:cooking_app/utils/text_style.dart';
import 'package:cooking_app/views/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const DashboardScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              AppAssets.roof,
              // width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  AppStrings.appTitle,
                  style: AppStyle.titleStyle,
                ),
                Text(
                  AppStrings.appSubTitle,
                  style: AppStyle.subTitleStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppStrings.description,
                  style: AppStyle.descriptionStyle,
                ),
                Image.asset(
                  AppAssets.cook,
                  width: 270,
                  height: 270,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
