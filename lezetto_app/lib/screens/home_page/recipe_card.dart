import 'package:flutter/material.dart';
import '../../model/recipe_model.dart';
import '../detail_page/detailPage.dart';
import '../favorite_page/favorites_manager.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;

  RecipeCard({required this.recipe});

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    final isFavorite = FavoritesManager.isFavorite(widget.recipe);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(recipeId: widget.recipe.id),
          ),
        );
      },
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.network(
                widget.recipe.image,
                height: 130.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildRecipeHeader(context, isFavorite),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: _buildRecipeTime(),
            ),
            SizedBox(height: 4.0),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeHeader(BuildContext context, bool isFavorite) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.recipe.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              FavoritesManager.toggleFavorite(widget.recipe);
            });
          },
        ),
      ],
    );
  }

  Widget _buildRecipeTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.access_time,
          size: 25.0,
          color: Colors.black54,
        ),
        SizedBox(width: 4.0),
        Text(
          widget.recipe.prepTime,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
