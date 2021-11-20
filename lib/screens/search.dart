import 'package:flutter/material.dart';
import 'package:recipe_app/models/meal_plan_model.dart';
import 'package:recipe_app/screens/meal.dart';
import 'package:recipe_app/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> _diets = [
    'None',
    'Gluten Free',
    'Ketogenic',
    'Lacto-Vegetarian',
    'Ovo-Vegetarian',
    'Vegan',
    'Pescetarian',
    'Paleo',
    'Primal',
    'Whole30',
  ];

  double _targetCalories = 2250;
  String _diet = 'None';

  void _searchMealPlan() async {
    MealPlan mealPlan = await APIService.instance.generateMealPlan(
      targetCalories: _targetCalories.toInt(),
      diet: _diet,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MealsScreen(mealPlan: mealPlan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/pot.jpg'),
            // NetworkImage(
            //   'https://image.freepik.com/free-photo/top-view-vegetables-stucco-background_23-2148724962.jpg',
            // ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Daily Meal Planner',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 25),
                    children: [
                      TextSpan(
                        text: _targetCalories.truncate().toString(),
                        style: const TextStyle(
                          color: Color(0xFFF57C00),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: ' cal',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: Colors.orange.shade700,
                    activeTrackColor: Colors.black,
                    inactiveTrackColor: Colors.black26,
                    trackHeight: 6.0,
                  ),
                  child: Slider(
                    min: 0.0,
                    max: 4500.0,
                    value: _targetCalories,
                    onChanged: (value) => setState(() {
                      _targetCalories = value.round().toDouble();
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: DropdownButtonFormField(
                    items: _diets.map((String priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(
                          priority,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Diet',
                      labelStyle: TextStyle(fontSize: 18.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _diet = value.toString();
                      });
                    },
                    value: _diet,
                  ),
                ),
                const SizedBox(height: 30.0),
                RaisedButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60.0,
                    vertical: 8.0,
                  ),
                  color: const Color(0xFFF57C00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: _searchMealPlan,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
