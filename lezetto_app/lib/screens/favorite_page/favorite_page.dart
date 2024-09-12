import 'package:flutter/material.dart';
import '../../components/bottomNavBar.dart';
import '../../model/recipe_model.dart';
import '../detail_page/detailPage.dart';
import 'favorites_manager.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    List<Recipe> favoriteRecipes = FavoritesManager.getFavorites();

    return Scaffold(
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
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (index == 1) {
          }
        },
      ),
    );
  }

  Widget _buildFavoriteRecipeCard(Recipe recipe, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(recipeId: recipe.id),
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
                _showRemoveFavoriteDialog(context, recipe);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showRemoveFavoriteDialog(BuildContext context, Recipe recipe) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Favorilerden Kaldır'),
          content: Text('${recipe.name} favorilerden kaldırılacak. Emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hayır'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  FavoritesManager.toggleFavorite(recipe);
                });

                Navigator.of(context).pop();
                _showRemovedNotification(recipe.name);
              },
              child: Text('Evet'),
            ),
          ],
        );
      },
    );
  }

  void _showRemovedNotification(String recipeName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Favori Kaldırıldı'),
          content: Text('$recipeName favorilerden kaldırıldı.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}
