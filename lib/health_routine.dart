import 'package:flutter/material.dart';

class Exercise {
  String name;
  int sets;
  double kg;
  int reps;

  Exercise({
    required this.name,
    required this.sets,
    required this.kg,
    required this.reps,
  });
}

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({Key? key}) : super(key: key);

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
} 

class _CreateRoutineState extends State<CreateRoutine> {
  TextEditingController nameController = TextEditingController();
  TextEditingController setsController = TextEditingController();
  TextEditingController kgController = TextEditingController();
  TextEditingController repsController = TextEditingController();

  List<Exercise> exercises = [];

  List<Widget> textFieldRows = [];

  @override
  void initState() {
    super.initState();
    textFieldRows.add(
      // Initial row of text fields
      Row(
        children: [
          Expanded(
            child: Container(
              width: 100,
              height: 100,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name: ',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 100,
              height: 100,
              child: TextField(
                controller: setsController,
                decoration: InputDecoration(
                  labelText: 'Sets: ',
                  border: OutlineInputBorder(),
                ),

              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 100,
              height: 100,
              child: TextField(
                controller: kgController,
                decoration: InputDecoration(
                  labelText: 'kg: ',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 100,
              height: 100,
              child: TextField(
                controller: repsController,
                decoration: InputDecoration(
                  labelText: 'reps: ',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name: ',
                    border: OutlineInputBorder(),
                  ),
                ),
              const SizedBox(height: 10),
              // Display the list of text field rows
              Column(children: textFieldRows),
              const SizedBox(height: 10),

           ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              fixedSize: const Size(100, 10),
            ),
            child: const Text('save',
              style: TextStyle(fontSize: 18),
            ),
             onPressed: () {
              Exercise exercise = Exercise(
                name: nameController.text,
                sets: int.parse(setsController.text),
                kg: double.parse(kgController.text),
                reps: int.parse(repsController.text),
              );
              setState(() {
                exercises.add(exercise);
              });

              print("Stored Exercises:");
              for (Exercise storedExercise in exercises) {
                print("Name: ${storedExercise.name}, Sets: ${storedExercise.sets}, KG: ${storedExercise.kg}, Reps: ${storedExercise.reps}");
              }
            },
          ),
              const SizedBox(height: 30),

            _elevatedButton(context),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Home menu',
        child: const Icon(Icons.home),
      ),
    );
  }





  Widget _elevatedButton(BuildContext context) {
    TextEditingController newExerciseNameController = TextEditingController();
    TextEditingController newSetsController = TextEditingController();
    TextEditingController newKgController = TextEditingController();
    TextEditingController newRepsController = TextEditingController();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        fixedSize: const Size(10, 10),
      ),
      child: const Text(
        '+',
        style: TextStyle(fontSize: 18),
      ),
      onPressed: () {
        // Add a new row of text fields when the '+' button is pressed
        setState(() {
          textFieldRows.add(
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: TextField(
                      controller: newExerciseNameController,
                      decoration: InputDecoration(
                        labelText: 'Name: ',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: TextField(
                      controller: newSetsController,
                      decoration: InputDecoration(
                        labelText: 'Sets: ',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: TextField(
                      controller: newKgController,
                      decoration: InputDecoration(
                        labelText: 'kg: ',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: TextField(
                      controller: newRepsController,
                      decoration: InputDecoration(
                        labelText: 'reps: ',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );




        });
      },
    );
  }
}

class Favorite extends StatelessWidget{
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // UI의 해당 부분이 미완성임을 표시하는 위젯
      body: Placeholder(),

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
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Favorite()),
                  );
                }

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