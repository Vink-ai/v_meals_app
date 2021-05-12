import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meals.dart';

class CategorymealsScreen extends StatefulWidget {

  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategorymealsScreen(this.availableMeals);

  @override
  _CategorymealsScreenState createState() => _CategorymealsScreenState();
}

class _CategorymealsScreenState extends State<CategorymealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
      final routeArg = 
        ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArg['title'];
      final categoryId = routeArg['id'];
      displayedMeals = widget.availableMeals.where((meal){
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId){
  //   setState(() {
  //     displayedMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl, 
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity, 
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}