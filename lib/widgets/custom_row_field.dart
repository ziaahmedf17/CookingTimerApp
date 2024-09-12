import 'package:cooking_app/utils/text_style.dart';
import 'package:flutter/material.dart';

class RowTextField extends StatelessWidget {
  const RowTextField(
      {super.key,
      required this.labelText,
      this.keyboardType,
      this.onTap,
      this.controller,
      this.readOnly = false,
      this.validator,
      this.isRequired = true,
      this.sufficIcon});
  final String labelText;
  final TextInputType? keyboardType;
  final void Function()? onTap;

  final TextEditingController? controller;
  final bool readOnly;
  final String? Function(String?)? validator;
  final bool isRequired;
  final Widget? sufficIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            labelText,
            style: AppStyle.labelTextStyle,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 4,
          child: TextFormField(
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: readOnly,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: sufficIcon,
              isDense: true,
              filled: true,
              fillColor: Colors.grey[100],
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            keyboardType: keyboardType,
            onTap: onTap,
            validator: isRequired
                ? (String? value) {
                    if (value!.isEmpty) {
                      return 'This Field is Required';
                    }
                    return validator == null ? null : validator!(value);
                  }
                : null,
          ),
        ),
      ],
    );
  }
}
