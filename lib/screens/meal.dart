import 'package:flutter/material.dart';
import 'package:recipe_app/models/meal_model.dart';
import 'package:recipe_app/models/meal_plan_model.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/recipe.dart';
import 'package:recipe_app/services/api_services.dart';

class MealsScreen extends StatefulWidget {
  final MealPlan? mealPlan;

  const MealsScreen({this.mealPlan});

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  _buildTotalNutrientsCard() {
    return Container(
      height: 140.0,
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.indigo.shade200,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Total Nutrients',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Calories: ${widget.mealPlan!.calories.toString()} cal',
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Protein: ${widget.mealPlan!.protein.toString()} g',
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Fat: ${widget.mealPlan!.fat.toString()} g',
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Carbs: ${widget.mealPlan!.carbs.toString()} g',
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildMealCard(Meal meal, int index) {
    String mealType = _mealType(index);
    return GestureDetector(
      onTap: () async {
        Recipe recipe =
            await APIService.instance.fetchRecipe(meal.id.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipeScreen(
              mealType: mealType,
              recipe: recipe,
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 200.0,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFB74D),
              image: DecorationImage(
                image: NetworkImage(meal.imageUrl.toString()),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(60.0),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  mealType,
                  style: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  meal.title.toString(),
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _mealType(int index) {
    switch (index) {
      case 0:
        return 'Breakfast';
      case 1:
        return 'Lunch';
      case 2:
        return 'Dinner';
      default:
        return 'Breakfast';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Meal Plan'),
        backgroundColor: const Color(0xFFF57C00),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 1 + widget.mealPlan!.meals.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildTotalNutrientsCard();
          }
          Meal meal = widget.mealPlan!.meals[index - 1];
          return _buildMealCard(meal, index - 1);
        },
      ),
    );
  }
}
