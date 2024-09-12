import 'package:cooking_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class ShowTimePicker extends StatefulWidget {
  const ShowTimePicker({super.key});

  @override
  State<ShowTimePicker> createState() => _ShowTimePickerState();
}

class _ShowTimePickerState extends State<ShowTimePicker> {
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              TextFormField(
                controller: timeController,
                decoration: const InputDecoration(
                    hintText: 'select time',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                onTap: () async {
                  TimeOfDay? time = await AppUtils.timePicker(context);
                  timeController.text = time.toString();
                  timeController.text = time!.format(context);
                  print('time out put$time');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}



