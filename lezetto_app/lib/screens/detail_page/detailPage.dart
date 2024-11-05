import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/detail_page/custom_navbar.dart';
import 'package:share_plus/share_plus.dart';
import '../../components/appBar.dart';
import '../../components/sideBar.dart';
import 'build_info_card.dart';
import 'detail_page_manager.dart';
import 'ingredient_list.dart';
import 'nutritive_value.dart';
import 'recipe_instructions.dart';

class DetailPage extends StatefulWidget {
  final int recipeId;

  DetailPage({required this.recipeId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late DetailPageManager _manager;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _manager = DetailPageManager(widget.recipeId, context, setState);
    _manager.loadRecipe();
  }

  @override
  Widget build(BuildContext context) {
    if (_manager.recipe == null) {
      return Scaffold(
        appBar: CustomAppBar(),
        drawer: SideBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideBar(),
      body: RawScrollbar(  // RawScrollbar kullanıldı
        controller: _scrollController,
        thumbVisibility: true,  // Scrollbar her zaman görünür
        radius: Radius.circular(10),  // Thumb yuvarlak köşeli olacak
        thickness: 8.0,  // Thumb kalınlığı
        thumbColor: Colors.deepOrange,  // Scrollbar rengi
        child: SingleChildScrollView(
          controller: _scrollController,  // ScrollController ile scroll ayarı
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRecipeImage(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        _manager.recipe!.name,
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    _buildInfoSection(),
                    SizedBox(height: 15.0),
                    NutritionInfo(manager: _manager),
                    SizedBox(height: 15.0),
                    _buildServingsControl(),
                    IngredientList(manager: _manager),
                    SizedBox(height: 15.0),
                    RecipeInstructions(manager: _manager),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavbar(
        onBackPressed: () {
          Navigator.pop(context);
        },
        onSavePressed: () {
          // Favori butonu
        },
        onRatePressed: () {
          // Oylama butonu
        },
        onSharePressed: () {
          Share.share(_manager.recipe!.name);
        },
      ),
    );
  }

  Widget _buildRecipeImage() {
    return Center(
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
          child: Image.network(_manager.recipe!.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InfoCard('Hazırlık', _manager.recipe!.prepTime, Icons.schedule),
        InfoCard('Pişirme', _manager.recipe!.cookTime, Icons.timer),
        InfoCard('Zorluk', _manager.recipe!.difficulty, Icons.bar_chart),
        InfoCard('Kalori', '${_manager.recipe!.calories} kcal',
            Icons.local_fire_department),
      ],
    );
  }

  Widget _buildServingsControl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'Malzemeler',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove, color: Colors.deepOrange),
              onPressed: () {
                if (_manager.servings > 1) {
                  setState(() {
                    _manager.updateIngredients(_manager.servings - 1);
                  });
                }
              },
            ),
            Text(
              '${_manager.servings} Kişilik',
              style: TextStyle(fontSize: 25.0),
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.deepOrange),
              onPressed: () {
                setState(() {
                  _manager.updateIngredients(_manager.servings + 1);
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
