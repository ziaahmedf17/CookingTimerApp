import 'package:cooking_app/models/dish_model.dart';
import 'package:cooking_app/provider/add_dish_provider.dart';
import 'package:cooking_app/views/screens/dashboard/add_dish_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeLineScreen extends StatelessWidget {
  const TimeLineScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Provider.of<AddDishProvider>(context, listen: false).getDishes();
    return Scaffold(
      appBar: AppBar(title: const Text('Dish Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AddDishProvider>(
          builder: (context, provider, child) {
            if (provider.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            List<Dish> dishItems = provider.items;
            if (dishItems.isEmpty) {
              return const Center(child: Text('No dishes available.'));
            }
            return ListView.builder(
              itemCount: dishItems.length,
              itemBuilder: (context, index) {
                final dish = dishItems[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name:${dish.id} ${dish.name}'),
                          const SizedBox(height: 8),
                          Text('Oven Temperature: ${dish.ovenTem}°C'),
                          const SizedBox(height: 8),
                          Text('Cook Duration: ${dish.cookDuration} mins'),
                          const SizedBox(height: 8),
                          Text('Reminder: ${dish.reminder}'),
                          const SizedBox(height: 8),
                          Text('Serve Time: ${dish.serveTime}'),
                          const SizedBox(height: 8),
                          Text('Notes: ${dish.notes}'),
                          const Divider(
                            height: 20,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddDishScreen(
                                              dish: dish,
                                            )));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.purple,
                              )),
                          IconButton(
                            onPressed: () {
                              provider.deleteDish(dish.id!);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
