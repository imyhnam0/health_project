import 'package:flutter/material.dart';

class CreateRoutine extends StatelessWidget {
  const CreateRoutine({super.key});

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter your routine name : ',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'name:  ',
              border: OutlineInputBorder(),
            ),
          ),
        ],


      ),

      // main page로 돌아가는 버튼
      // navigator 사용법은 다음 웹페이지에서 설명함

      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pop(context);},
        tooltip: 'Home menu',
        child: const Icon(Icons.home),
      ),
    );
  }
}

class HealthRoutineMenu extends StatelessWidget{
  const HealthRoutineMenu({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
              child: const Text('루틴생성',
                style: TextStyle(fontSize: 18),
              ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateRoutine()),
                  );
                }



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
              child: const Text('즐겨찾기',
                style: TextStyle(fontSize: 18),
              ),
                onPressed: (){}

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
              child: const Text('달력',
                style: TextStyle(fontSize: 18),
              ),
                onPressed: (){}

            ),
          ],
        ),
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pop(context);},
        tooltip: 'Home menu',
        child: const Icon(Icons.home),
      ),
    );
  }
}

