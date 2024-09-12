import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/shopping_page/shopping_cart_manager.dart';
import '../../model/recipe_model.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late Map<Recipe, List<String>> shoppingCart;

  @override
  void initState() {
    super.initState();
    shoppingCart = ShoppingCartManager.getShoppingCart();
  }

  void _toggleIngredient(Recipe recipe, Ingredient ingredient) {
    setState(() {
      if (shoppingCart[recipe]?.contains(ingredient.name) ?? false) {
        ShoppingCartManager.removeIngredient(recipe, ingredient);
      } else {
        ShoppingCartManager.addIngredient(recipe, ingredient);
      }
      shoppingCart = ShoppingCartManager.getShoppingCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shoppingCart.isNotEmpty
          ? ListView.builder(
        itemCount: shoppingCart.length,
        itemBuilder: (context, index) {
          Recipe recipe = shoppingCart.keys.elementAt(index);
          List<String> ingredientNames = shoppingCart[recipe]!;
          return _buildShoppingCartItem(recipe, ingredientNames);
        },
      )
          : Center(
        child: Text('Alışveriş listesi boş.'),
      ),
    );
  }

  Widget _buildShoppingCartItem(Recipe recipe, List<String> ingredientNames) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              recipe.name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          ...ingredientNames.map((ingredientName) {
            return ListTile(
              title: Text(ingredientName),
              trailing: IconButton(
                icon: Icon(Icons.remove, color: Colors.red),
                onPressed: () {
                  final ingredient = recipe.ingredients.firstWhere((ing) => ing.name == ingredientName);
                  _toggleIngredient(recipe, ingredient);
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
