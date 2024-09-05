import 'package:flutter/material.dart';
import '../components/bottomNavBar.dart'; // Import your BottomNavBar widget
import '../components/favorites_manager.dart';
import '../model/recipe_model.dart'; // Assuming the Recipe model is here
import 'detailPage.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the list of favorite recipes
    List<Recipe> favoriteRecipes = FavoritesManager.getFavorites();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoriler'),
      ),
      body: favoriteRecipes.isNotEmpty
          ? ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoriteRecipes[index];
          return _buildFavoriteRecipeCard(recipe, context);
        },
      )
          : Center(
        child: Text('Favori tarifler bulunamadı'),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1, // Index of the Favorites tab
        onItemTapped: (index) {
          // Handle navigation between tabs
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/'); // Navigate to Home
          } else if (index == 1) {
            // Stay on the Favorites tab
          }
          // Add more tabs if needed
        },
      ),
    );
  }

  // This function builds the recipe card for the favorite recipes
  Widget _buildFavoriteRecipeCard(Recipe recipe, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle navigation to detail page or action
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(recipe: recipe), // Assuming you have a detail page
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(15.0)),
              child: Image.network(
                recipe.image,
                height: 80.0,
                width: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 18.0,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        recipe.prepTime,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                // Optional: Add functionality to remove from favorites if needed
                FavoritesManager.toggleFavorite(recipe);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${recipe.name} favorilerden kaldırıldı.'),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
