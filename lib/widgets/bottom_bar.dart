import 'package:cooking_app/utils/text_style.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {super.key,
      required this.asset,
      required this.text,
      this.width = 50,
      this.onTap,
      this.height = 50});
  final String asset;
  final String text;
  final double width;
  final double height;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Image.asset(
              asset,
              width: width,
              height: height,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: AppStyle.underImageTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
