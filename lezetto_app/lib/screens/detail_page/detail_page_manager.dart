import 'dart:convert';
import 'package:flutter/material.dart';
import '../../model/recipe_model.dart';
import '../shopping_page/shopping_cart_manager.dart';

class DetailPageManager {
  final int recipeId;
  final BuildContext context;
  final Function(void Function()) setState;
  Recipe? recipe;
  int servings = 1;
  List<Ingredient> scaledIngredients = [];

  DetailPageManager(this.recipeId, this.context, this.setState);

  Future<void> loadRecipe() async {
    final List<Recipe> recipes = await _fetchRecipes();
    setState(() {
      recipe = recipes.firstWhere((r) => r.id == recipeId);
      servings = recipe!.servings;
      scaledIngredients = recipe!.ingredients.map((ingredient) {
        return Ingredient(
          name: ingredient.name,
          quantity: ingredient.quantity,
          unit: ingredient.unit,
        );
      }).toList();
    });
  }

  Future<List<Recipe>> _fetchRecipes() async {
    final String response = await DefaultAssetBundle.of(context)
        .loadString('assets/karniyarik.json');
    final List<dynamic> data = json.decode(response);
    return data.map((item) => Recipe.fromJson(item)).toList();
  }

  void updateIngredients(int newServings) {
    setState(() {
      final double scale = newServings / recipe!.servings;
      scaledIngredients = recipe!.ingredients.map((ingredient) {
        return Ingredient(
          name: ingredient.name,
          quantity: ingredient.quantity * scale,
          unit: ingredient.unit,
        );
      }).toList();
      servings = newServings;
    });
  }

  void toggleIngredient(Ingredient ingredient) {
    setState(() {
      final bool isInCart = ShoppingCartManager.getShoppingCart()[recipe!]
          ?.contains(ingredient.name) ?? false;

      if (isInCart) {
        ShoppingCartManager.removeIngredient(recipe!, ingredient);
      } else {
        ShoppingCartManager.addIngredient(recipe!, ingredient);
      }
    });
  }
}
