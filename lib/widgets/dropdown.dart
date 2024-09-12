import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget(
      {required this.list,
      required this.title,
      this.selected,
      super.key,
      required this.onChanged,
      this.onTap});
  final List<String?> list;
  final String title;
  final String? selected;
  final void Function(String?) onChanged;
  final void Function()? onTap;
  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  String? newValue;
  @override
  void initState() {
    newValue = widget.selected;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomDropDownWidget oldWidget) {
    if (widget.selected != oldWidget.selected) {
      setState(() {
        newValue =
            widget.selected; // Update the bpmValue with the new initial value
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          items: widget.list
              .map((String? item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item!,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: newValue,
          onChanged: (value) {
            setState(() {
              newValue = value!;
            });
            widget.onChanged(value);
          },
          dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              elevation: 4),
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(0)),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 48,
            width: 167.7,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    );
  }
}
