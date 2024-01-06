import 'package:flutter/material.dart';

class Meal {
  String name;
  int grams;
  int kcal;
  DateTime time;

  Meal(this.name, this.grams, this.kcal, {DateTime? date}) : time = date ?? DateTime.now();
}

class Diet{
  late int kcal;
  late int grams;
  late List<Meal> meals;

  Diet({this.kcal = 0, this.grams = 0, List<Meal>? meals}) {
    this.meals = meals ?? <Meal>[Meal('first', 100, 4, date: DateTime(2024, 1, 3)), Meal('second', 130, 20)];
  }
  
  Diet dietOnDateRange(DateTimeRange dateRange) {
    var newDiet = Diet(meals: []);
    for (Meal m in meals) {
      if(
        m.time.isAtSameMomentAs(DateTime(dateRange.start.year, dateRange.start.month, dateRange.start.day)) || 
        m.time.isAfter(DateTime(dateRange.start.year, dateRange.start.month, dateRange.start.day)) && 
        m.time.isBefore(DateTime(dateRange.end.year, dateRange.end.month, dateRange.end.day+1))
      ) {
        newDiet.addInfo(m);
      }
    }
    return newDiet;
  }

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