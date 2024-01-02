import 'package:flutter/material.dart';

class HealthRoutineMenu extends StatelessWidget{
  const HealthRoutineMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // UI의 해당 부분이 미완성임을 표시하는 위젯
      body: const Placeholder(),

      // main page로 돌아가는 버튼
      // navigator 사용법은 다음 웹페이지에서 설명함
      // https://docs.flutter.dev/cookbook/navigation/navigation-basics
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pop(context);},
        tooltip: 'Home menu',
        child: const Icon(Icons.home),
      ),
    );
  }
}