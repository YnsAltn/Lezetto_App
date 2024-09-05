import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../components/favorites_manager.dart';
import '../model/recipe_model.dart';
import 'detailPage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<Recipe>> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture = loadData();
  }

  Future<List<Recipe>> loadData() async {
    final String response = await rootBundle.loadString('assets/karniyarik.json');
    final List<dynamic> data = json.decode(response);
    return data.map((item) => Recipe.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: _recipesFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Veri bulunamadı'));
        }

        final List<Recipe> recipes = snapshot.data!;
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: _buildGrid(recipes, context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGrid(List<Recipe> recipes, BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.8,
      ),
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) {
        final recipe = recipes[index];
        return _buildRecipeCard(recipe, context);
      },
    );
  }

  Widget _buildRecipeCard(Recipe recipe, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(recipe: recipe),
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
                recipe.image,
                height: 130.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildRecipeHeader(recipe),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: _buildRecipeTime(recipe),
            ),
            SizedBox(height: 4.0),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeHeader(Recipe recipe) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            recipe.name,
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
            FavoritesManager.isFavorite(recipe) ? Icons.favorite : Icons.favorite_border,
            color: FavoritesManager.isFavorite(recipe) ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              FavoritesManager.toggleFavorite(recipe);
            });
          },
        ),
      ],
    );
  }

  Widget _buildRecipeTime(Recipe recipe) {
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
          recipe.prepTime,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
