import 'package:flutter/material.dart';
import '../../model/recipe_model.dart';

class RecipeSlider extends StatefulWidget {
  final List<Recipe> recipes;

  RecipeSlider({required this.recipes});

  @override
  _RecipeSliderState createState() => _RecipeSliderState();
}

class _RecipeSliderState extends State<RecipeSlider> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(),
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: Colors.black12,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemCount: widget.recipes.length,
                      itemBuilder: (context, index) {
                        return _buildSliderCard(widget.recipes[index]);
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5.0,
                left: 0.0,
                right: 0.0,
                child: Center(
                  child: _buildPageIndicators(widget.recipes.length),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 2.0,
              color: Colors.deepOrange,
            ),
          ),
          SizedBox(width: 8.0),
          Text(
            'Günün Menüsü',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              height: 2.0,
              color: Colors.deepOrange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderCard(Recipe recipe) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            recipe.image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 20.0,
          left: 10.0,
          right: 10.0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 20.0, color: Colors.white),
                    SizedBox(width: 4.0),
                    Text(
                      recipe.prepTime,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicators(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: _currentPage == index ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.deepOrange : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }
}
