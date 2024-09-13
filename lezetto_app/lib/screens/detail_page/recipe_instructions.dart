import 'package:flutter/material.dart';
import 'detail_page_manager.dart';

class RecipeInstructions extends StatelessWidget {
  final DetailPageManager manager;

  RecipeInstructions({required this.manager});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Tarifin Yapılışı',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          ...manager.recipe!.instructions.asMap().entries.map((entry) {
            int index = entry.key;
            String step = entry.value;
            return Container(
              margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 0.0),
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.deepOrange,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      step,
                      style: TextStyle(fontSize: 16.0),
                    ),
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
