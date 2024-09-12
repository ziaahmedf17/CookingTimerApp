import 'package:cooking_app/utils/app_colors.dart';
import 'package:cooking_app/utils/text_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.height = 40,
      this.width = 170,
      required this.textOfButton,
      this.onTap,
      this.color = AppColors.primaryColor});
  final double height;
  final double width;
  final String textOfButton;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Center(
          child: Text(
            textOfButton,
            style: AppStyle.buttonTextStyle,
          ),
        ),
      ),
    );
  }
}
