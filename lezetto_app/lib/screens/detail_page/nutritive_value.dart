import 'package:flutter/material.dart';
import 'detail_page_manager.dart';

class NutritionInfo extends StatelessWidget {
  final DetailPageManager manager;

  NutritionInfo({required this.manager});

  @override
  Widget build(BuildContext context) {
    final nutrition = manager.recipe!.nutrition.toMap();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Besin Değerleri',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  for (int i = 0; i < nutrition.entries.length; i += 2)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: _buildNutritionItem(
                                nutrition.entries.elementAt(i),
                              ),
                            ),
                            if (i + 1 < nutrition.entries.length)
                              Expanded(
                                flex: 1,
                                child: _buildNutritionItem(
                                  nutrition.entries.elementAt(i + 1),
                                ),
                              ),
                          ],
                        ),
                        if (i + 2 < nutrition.entries.length)
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.8,
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(MapEntry<String, String> entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(
            '${entry.key}: ',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            entry.value,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
