import 'package:flutter/material.dart';
import 'detail_page_manager.dart';

class RecipeInstructions extends StatelessWidget {
  final DetailPageManager manager;

  RecipeInstructions({required this.manager});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(height: 20.0),
        ...manager.recipe!.instructions.map((step) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: Text(
              step,
              style: TextStyle(fontSize: 16.0),
            ),
          );
        }).toList(),
      ],
    );
  }
}
