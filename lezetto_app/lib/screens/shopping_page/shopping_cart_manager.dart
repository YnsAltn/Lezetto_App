import '../../model/recipe_model.dart';

class ShoppingCartManager {
  static final Map<Recipe, List<String>> _shoppingCart = {};

  static void addIngredient(Recipe recipe, Ingredient ingredient) {
    if (!_shoppingCart.containsKey(recipe)) {
      _shoppingCart[recipe] = [];
    }
    if (!_shoppingCart[recipe]!.contains(ingredient.name)) {
      _shoppingCart[recipe]!.add(ingredient.name);
    }
  }

  static void removeIngredient(Recipe recipe, Ingredient ingredient) {
    if (_shoppingCart.containsKey(recipe)) {
      _shoppingCart[recipe]!.remove(ingredient.name);
      if (_shoppingCart[recipe]!.isEmpty) {
        _shoppingCart.remove(recipe);
      }
    }
  }

  static Map<Recipe, List<String>> getShoppingCart() {
    return Map.unmodifiable(_shoppingCart);
  }
}
