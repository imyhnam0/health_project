import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

late BookmarkedFoods bookmarks;
late MealCollection mealHistory;

Future<void> updateTodayDietToFirestore(OneDayFoods todayDiet) async {
  // Firestore 인스턴스 생성

    // 현재 사용자의 UID
    final User? user = FirebaseAuth.instance.currentUser;
    String currentUserId = user!.uid;
    // 실제로는 FirebaseAuth 등을 통해 가져와야 합니다.

  // 루틴 데이터를 Firestore에 추가
  await FirebaseFirestore.instance
    .collection('user')
    .doc(currentUserId)
    .collection('diets')
    .doc(todayDiet.date.toIso8601String())
    .set(todayDiet.toJson());
}

Future<void> updateBookmarksToFirestore(Food food) async {
  // Firestore 인스턴스 생성

    // 현재 사용자의 UID
    final User? user = FirebaseAuth.instance.currentUser;
    String currentUserId = user!.uid;
    // 실제로는 FirebaseAuth 등을 통해 가져와야 합니다.

  // 루틴 데이터를 Firestore에 추가
  await FirebaseFirestore.instance
    .collection('user')
    .doc(currentUserId)
    .collection('dietBookmarks')
    .doc(food.name)
    .set(food.toJson());
}

Future<void> deleteBookmarksToFirestore(String foodname) async {
  // Firestore 인스턴스 생성

    // 현재 사용자의 UID
    final User? user = FirebaseAuth.instance.currentUser;
    String currentUserId = user!.uid;
    // 실제로는 FirebaseAuth 등을 통해 가져와야 합니다.

  // 루틴 데이터를 Firestore에 추가
  await FirebaseFirestore.instance
    .collection('user')
    .doc(currentUserId)
    .collection('dietBookmarks')
    .doc(foodname)
    .delete();
}

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

  Food.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        grams = json['grams'],
        kcal = json['kcal'],
        time = DateTime.parse(json['time']);
  
  Map<String, dynamic> toJson() => {  
    'name': name,
    'grams': grams,
    'kcal': kcal,
    'time': time.toIso8601String(),
  };
}

class FoodCollection{
  int kcal = 0;
  int grams = 0;
  late List<Food> foods;

  FoodCollection({List<Food>? foods}) {
    this.foods = foods ?? <Food>[];
    for (Food m in this.foods) {
      kcal += m.kcal;
      grams += m.grams;
    }
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
  BookmarkedFoods({List<Food>? foods}) : super(foods: foods);
  
  void addFoodWithNameDiff(Food food, BuildContext context){
    int index = foods.indexWhere((element) => element.name == food.name);
    if(index == -1){
      super.addFood(food);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('즐겨찾기가 추가되었습니다.')),
      );
    }
    else {
      showDialog(
        context: context, 
        builder:(context) => AlertDialog(
          title: const Text('이미 즐겨찾기에 추가된 음식입니다.'),
          content: const Text('기존 즐겨찾기를 대체하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                foods[index] = food;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('기존 즐겨찾기에 추가되었습니다.')),
                );
              }, 
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
  }
}

class OneDayFoods extends FoodCollection{
  late String name;
  late DateTime date;

  OneDayFoods({String? name, List<Food>? foods, DateTime? date}) : super(foods: foods){
    this.name = name ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
    this.date = DateTime(
      date?.year ?? DateTime.now().year,
      date?.month ?? DateTime.now().month,
      date?.day ?? DateTime.now().day,
    );
  }

  OneDayFoods.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        date = DateTime.parse(json['date']),
        super(foods: (json['foods'] as List).map((e) => Food.fromJson(e)).toList());
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'date': date.toIso8601String(),
    'foods': foods.map((e) => e.toJson()).toList(),
  };
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
  List<OneDayFoods> getAll(DateTime date){
    List<OneDayFoods> result = [];
    for (OneDayFoods m in meals) {
    if(m.date.year == date.year && m.date.month == date.month && m.date.day == date.day){
      result.add(m);
    }
    }
    return result;
  }
  void add(OneDayFoods meal){
    meals.add(meal);
  }

  MealCollection.fromJson(Map<String, dynamic> json)
      : meals = (json['meals'] as List).map((e) => OneDayFoods.fromJson(e)).toList();
  
  Map<String, dynamic> toJson() => {
    'meals': meals.map((e) => e.toJson()).toList(),
  };
}