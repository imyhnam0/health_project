
import 'package:flutter_project/main.dart';
import 'package:flutter_project/user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_project/health_routine.dart';
import 'package:flutter_project/diet.dart';
import 'package:flutter_project/friends.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({Key? key}) : super(key: key);


  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final title = 'Health routine&food';

  //int _bmiStatus = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("health"),
        actions: [
          GestureDetector(
            onTap: () async{
              Get.to(() => const UserPage());
            },
            child:Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.account_circle),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                fixedSize: const Size(300, 100),
              ),
              child: const Text('친구 추가',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FriendsMenu()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}