import '../model/recipe_model.dart';

class FavoritesManager {
  static final List<Recipe> _favorites = [];

  // Add a recipe to the favorites list
  static void addFavorite(Recipe recipe) {
    _favorites.add(recipe);
  }

  // Remove a recipe from the favorites list
  static void removeFavorite(Recipe recipe) {
    _favorites.remove(recipe);
  }

  // Get the list of favorite recipes
  static List<Recipe> getFavorites() {
    return _favorites;
  }

  // Toggle favorite status (add/remove)
  static void toggleFavorite(Recipe recipe) {
    if (_favorites.contains(recipe)) {
      removeFavorite(recipe);
    } else {
      addFavorite(recipe);
    }
  }

  // Check if a recipe is in the favorites list
  static bool isFavorite(Recipe recipe) {
    return _favorites.contains(recipe);
  }
}
