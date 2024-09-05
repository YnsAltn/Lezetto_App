import '../../model/recipe_model.dart';

class FavoritesManager {
  static final List<Recipe> _favorites = [];

  static void addFavorite(Recipe recipe) {
    _favorites.add(recipe);
  }

  static void removeFavorite(Recipe recipe) {
    _favorites.remove(recipe);
  }

  static List<Recipe> getFavorites() {
    return _favorites;
  }

  static void toggleFavorite(Recipe recipe) {
    if (_favorites.contains(recipe)) {
      removeFavorite(recipe);
    } else {
      addFavorite(recipe);
    }
  }

  static bool isFavorite(Recipe recipe) {
    return _favorites.contains(recipe);
  }
}
