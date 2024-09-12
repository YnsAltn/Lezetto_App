import 'package:flutter/material.dart';
import '../shopping_page/shopping_cart_manager.dart';
import 'detail_page_manager.dart';

class IngredientList extends StatelessWidget {
  final DetailPageManager manager;

  IngredientList({required this.manager});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: 10.0),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: manager.scaledIngredients.length,
          itemBuilder: (context, index) {
            final ingredient = manager.scaledIngredients[index];
            final isInCart = ShoppingCartManager.getShoppingCart()[manager.recipe!]
                ?.contains(ingredient.name) ?? false;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => manager.toggleIngredient(ingredient),
                        icon: Icon(
                          isInCart ? Icons.remove : Icons.add,
                          color: isInCart ? Colors.red : Colors.green,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${ingredient.quantity} ${ingredient.unit} ${ingredient.name}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey[300],
                  indent: 10.0,
                  endIndent: 10.0,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
