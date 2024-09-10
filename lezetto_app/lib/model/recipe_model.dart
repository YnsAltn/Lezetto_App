class Recipe {
  final int id;
  final String name;
  final String category;
  final String image;
  final String prepTime;
  final String cookTime;
  final String difficulty;
  final int calories;
  final int servings;
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final Nutrition nutrition;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.prepTime,
    required this.cookTime,
    required this.difficulty,
    required this.calories,
    required this.servings,
    required this.ingredients,
    required this.instructions,
    required this.nutrition,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    var ingredientList = (json['ingredients'] as List)
        .map((i) => Ingredient.fromJson(i))
        .toList();

    var instructionList = List<String>.from(json['instructions']);

    var nutritionData = Nutrition.fromJson(json['nutrition']);

    return Recipe(
      id: (json['id'] as num).toInt(),
      name: json['name'],
      category: json['category'],
      image: json['image'],
      prepTime: json['prep_time'],
      cookTime: json['cook_time'],
      difficulty: json['difficulty'],
      calories: (json['calories'] as num).toInt(),
      servings: (json['servings'] as num).toInt(),
      ingredients: ingredientList,
      instructions: instructionList,
      nutrition: nutritionData,
    );
  }
}

class Ingredient {
  final String name;
  final double quantity;
  final String unit;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'],
    );
  }
}

class Nutrition {
  final String carbohydrates;
  final String protein;
  final String fat;

  Nutrition({
    required this.carbohydrates,
    required this.protein,
    required this.fat,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      carbohydrates: json['carbohydrates'],
      protein: json['protein'],
      fat: json['fat'],
    );
  }
}
