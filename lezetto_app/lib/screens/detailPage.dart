import 'dart:convert';

import 'package:flutter/material.dart';
import '../components/appBar.dart';
import '../components/sideBar.dart';
import '../model/recipe_model.dart';
import 'favorite_page/favorites_manager.dart';

class DetailPage extends StatefulWidget {
  final int recipeId;

  DetailPage({required this.recipeId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Recipe recipe;
  late int servings;
  late List<Ingredient> scaledIngredients;

  @override
  void initState() {
    super.initState();
    _loadRecipe();
  }

  Future<void> _loadRecipe() async {
    final List<Recipe> recipes = await _fetchRecipes();
    setState(() {
      recipe = recipes.firstWhere((r) => r.id == widget.recipeId);
      servings = recipe.servings;
      scaledIngredients = recipe.ingredients.map((ingredient) {
        return Ingredient(
          name: ingredient.name,
          quantity: ingredient.quantity,
          unit: ingredient.unit,
        );
      }).toList();
    });
  }

  Future<List<Recipe>> _fetchRecipes() async {
    final String response = await DefaultAssetBundle.of(context).loadString('assets/karniyarik.json');
    final List<dynamic> data = json.decode(response);
    return data.map((item) => Recipe.fromJson(item)).toList();
  }

  void _updateIngredients(int newServings) {
    setState(() {
      final double scale = newServings / recipe.servings;
      scaledIngredients = recipe.ingredients.map((ingredient) {
        return Ingredient(
          name: ingredient.name,
          quantity: ingredient.quantity * scale,
          unit: ingredient.unit,
        );
      }).toList();
      servings = newServings;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (recipe == null) {
      return Scaffold(
        appBar: CustomAppBar(),
        drawer: SideBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final imageUrl = recipe.image;
    final preparationTime = recipe.prepTime;
    final cookingTime = recipe.cookTime;
    final difficulty = recipe.difficulty;
    final calories = recipe.calories;
    final instructions = recipe.instructions;
    final nutrition = recipe.nutrition;

    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(12.0),
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      recipe.name,
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoCard('Hazırlık', preparationTime, Icons.schedule),
                      _buildInfoCard('Pişirme', cookingTime, Icons.timer),
                      _buildInfoCard('Zorluk', difficulty, Icons.bar_chart),
                      _buildInfoCard('Kalori', '$calories kcal', Icons.local_fire_department),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Center(
                            child: Text(
                              'Besin Değerleri',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      FavoritesManager.isFavorite(recipe) ? Icons.favorite : Icons.favorite_border,
                                      color: Colors.deepOrange,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        FavoritesManager.toggleFavorite(recipe);
                                      });
                                    },
                                  ),
                                  SizedBox(width: 8.0),
                                  IconButton(
                                    icon: Icon(Icons.share, color: Colors.deepOrange, size: 30),
                                    onPressed: () {
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'Karbonhidrat: ${nutrition.carbohydrates}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Protein: ${nutrition.protein}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Yağ: ${nutrition.fat}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 24.0),
                  Container(
                    child: const Center(
                      child: Text(
                        'Malzemeler',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.deepOrange),
                        onPressed: () {
                          if (servings > 1) {
                            _updateIngredients(servings - 1);
                          }
                        },
                      ),
                      Text(
                        '$servings Kişilik',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.deepOrange),
                        onPressed: () {
                          _updateIngredients(servings + 1);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  ...scaledIngredients.map<Widget>((ingredient) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                              },
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: '${ingredient.quantity.toStringAsFixed(2)} ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '${ingredient.unit} ${ingredient.name}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.grey),
                      ],
                    );
                  }).toList(),
                  SizedBox(height: 15.0),
                  Container(
                    child: const Center(
                      child: Text(
                        'Yapılış Adımları',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ...instructions.map<Widget>((step) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          step,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 24.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.deepOrange, size: 28.0),
        SizedBox(height: 4.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
