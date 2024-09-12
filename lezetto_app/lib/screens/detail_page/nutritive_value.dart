import 'package:flutter/material.dart';
import 'detail_page_manager.dart';

class NutritionInfo extends StatelessWidget {
  final DetailPageManager manager;

  NutritionInfo({required this.manager});

  @override
  Widget build(BuildContext context) {
    final nutrition = manager.recipe!.nutrition.toMap();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Besin Değerleri',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          SizedBox(height: 16.0),
          ...nutrition.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(width: 10),
                  Text(
                    entry.value,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
