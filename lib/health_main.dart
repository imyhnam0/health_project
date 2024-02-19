import 'package:flutter_project/user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'health_routine.dart';
import 'diet.dart';
import 'friends.dart';

import 'diet_define.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({Key? key}) : super(key: key);


  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final title = 'Health routine&food';
  
  @override
  void initState() {
    super.initState();
    
    exercises = [];

    final User? user = FirebaseAuth.instance.currentUser;
    String currentUserId = user!.uid;
    
    FirebaseFirestore.instance
      .collection('user')
      .doc(currentUserId)
      .collection('routines')
      .get()
      .then((event) {
        for (var doc in event.docs) {
          exercises.add(Exercise.fromJson(doc.data()));
        }
      });

    mealHistory = MealCollection();
      
    FirebaseFirestore.instance
      .collection('user')
      .doc(currentUserId)
      .collection('diets')
      .get()
      .then((event) {
        for (var doc in event.docs) {
          mealHistory.add(OneDayFoods.fromJson(doc.data()));
        }
      });
      
    bookmarks = BookmarkedFoods();

    FirebaseFirestore.instance
      .collection('user')
      .doc(currentUserId)
      .collection('dietBookmarks')
      .get()
      .then((event) {
        for (var foodDoc in event.docs) {
          bookmarks.addFood(Food.fromJson(foodDoc.data()));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("health"),
        actions: [
          GestureDetector(
            onTap: () async{
              Get.to(() => const UserPage());
            },
            child:Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.account_circle),
            ),
          ),

        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // 헬스 루틴 메뉴
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                fixedSize: const Size(300, 100),
              ),
              child: const Text('헬스 루틴',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HealthRoutineMenu()),
                );
              },
            ),
            const SizedBox(height: 80),

            //식단 메뉴
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                fixedSize: const Size(300, 100),
              ),
              child: const Text('식단',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DietMenu()),
                );
              },
            ),
            const SizedBox(height: 80),

            //친구 추가 메뉴
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(0),
            //     ),
            //     fixedSize: const Size(300, 100),
            //   ),
            //   child: const Text('친구 추가',
            //     style: TextStyle(fontSize: 18),
            //   ),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const FriendsMenu()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}