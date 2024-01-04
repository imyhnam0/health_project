import 'package:flutter/material.dart';

class Meal {
  String name;
  int grams;
  int kcal;

  Meal(this.name, this.grams, this.kcal);
}

class TodayDiet extends ChangeNotifier {
  var kcal = 0;
  var grams = 0;
  var meals = <Meal>[];

  void addInfo(Meal food){
    meals.add(food);
    grams += food.grams;
    kcal += food.kcal;
  }
  void delFood(int num){
    grams -= meals[num].grams;
    kcal -= meals[num].kcal;
    meals.removeAt(num);
  }
}