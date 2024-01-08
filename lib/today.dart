import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Food extends Equatable{
  final String name;
  final int grams;
  final int kcal;
  final DateTime time;

  Food(this.name, this.grams, this.kcal, {DateTime? date}) : time = date ?? DateTime.now();

  @override
  List<Object> get props => [name, grams, kcal, time];

  Food copy(){
    return Food(name, grams, kcal, date: time);
  }
}

class FoodCollection{
  late int kcal;
  late int grams;
  late List<Food> foods;

  FoodCollection({this.kcal = 0, this.grams = 0, List<Food>? foods}) {
    this.foods = foods ?? <Food>[];
  }
  
  FoodCollection dietOnDateRange(DateTimeRange dateRange) {
    var newFoodCollection = FoodCollection(foods: []);
    for (Food m in foods) {
      if(
        m.time.isAtSameMomentAs(DateTime(dateRange.start.year, dateRange.start.month, dateRange.start.day)) || 
        m.time.isAfter(DateTime(dateRange.start.year, dateRange.start.month, dateRange.start.day)) && 
        m.time.isBefore(DateTime(dateRange.end.year, dateRange.end.month, dateRange.end.day+1))
      ) {
        newFoodCollection.addFood(m);
      }
    }
    return newFoodCollection;
  }

  void addFood(Food food){
    foods.add(food.copy());
    grams += food.grams;
    kcal += food.kcal;
  }
  void delFoodByIndex(int num){
    grams -= foods[num].grams;
    kcal -= foods[num].kcal;
    foods.removeAt(num);
  }
  void delFood(Food food){
    grams -= food.grams;
    kcal -= food.kcal;
    foods.remove(food);
  }
}

class BookmarkedFoods extends FoodCollection{
  BookmarkedFoods({int kcal = 0, int grams = 0, List<Food>? foods}) : super(kcal: kcal, grams: grams, foods: foods);
}

class OneDayFoods extends FoodCollection{
  late String name;
  late DateTime date;

  OneDayFoods({String? name, int kcal = 0, int grams = 0, List<Food>? foods, DateTime? date}) : super(kcal: kcal, grams: grams, foods: foods){
    this.name = name ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
    this.date = DateTime(
      date?.year ?? DateTime.now().year,
      date?.month ?? DateTime.now().month,
      date?.day ?? DateTime.now().day,
    );
  }
}

class MealCollection{
  late List<OneDayFoods> meals;

  MealCollection({List<OneDayFoods>? meals}) {
    this.meals = meals ?? <OneDayFoods>[];
  }

  OneDayFoods? get(DateTime date){
    for (OneDayFoods m in meals) {
      if(m.date.year == date.year && m.date.month == date.month && m.date.day == date.day){
        return m;
      }
    }
    return null;
  }
  void add(OneDayFoods meal){
    meals.add(meal);
  }
}