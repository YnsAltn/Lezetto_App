import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_demo/model/recipe_model.dart';
import 'package:flutter_demo/screens/home_page/recipe_card.dart';
import 'package:flutter_demo/screens/home_page/recipe_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 280.0,
                    child: RecipeSlider(recipes: recipes),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 10.0),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final recipe = recipes[index];
                      return RecipeCard(recipe: recipe);
                    },
                    childCount: recipes.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.8,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10.0),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
