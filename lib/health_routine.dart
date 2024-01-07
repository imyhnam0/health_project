import 'package:flutter/material.dart';

class Exercise {
  String mainname;
  String name;
  int sets;
  double kg;
  int reps;

  Exercise({
    required this.mainname,
    required this.name,
    required this.sets,
    required this.kg,
    required this.reps,

  });
}

List<Exercise> exercises = [];

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({Key? key}) : super(key: key);

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {

  var mainnameController = TextEditingController();
  var nameController = [TextEditingController()];
  var setsController = [TextEditingController()];
  var kgController = [TextEditingController()];
  var repsController = [TextEditingController()];

  List<Widget> textFieldRows = [];

  @override
 void initState() {
    super.initState();
    textFieldRows.add( // Initial row of text fields
        Row(
          children: [
            Expanded(
              child: Container(
                width: 100,
                height: 100,
                child: TextField(
                  controller: mainnameController,
                  decoration: InputDecoration(
                    labelText: 'Routine Name: ',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),

          ],
        ));
  }

  @override


  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

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
               showDialog(
                   context: context,
                   barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                   builder: (BuildContext context) {
                     return AlertDialog(
                         content: const Text('정말 저장하시겠습니까?'),
                         insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
                       actions: [
                         TextButton(
                           child: Row(
                             children: [
                               Column(
                                 children: [
                                   Center(child: const Text('예')),
                                 ],
                               ),
                             ],
                           ),
                           onPressed: () {
                             Navigator.of(context).pop();
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => const HealthRoutineMenu()));

                             setState(() {
                               for(int i=0;i<nameController.length;i++)
                               {
                                 Exercise exercise = Exercise(
                                   mainname: mainnameController.text,
                                   name: nameController[i].text,
                                   sets: int.parse(setsController[i].text),
                                   kg: double.parse(kgController[i].text),
                                   reps: int.parse(repsController[i].text),
                                 );
                                 exercises.add(exercise);


                               }

                               print("inner Exercises:");
                               for (Exercise storedExercise in exercises) {
                                 print("Name: ${storedExercise.name}, Sets: ${storedExercise.sets}, KG: ${storedExercise.kg}, Reps: ${storedExercise.reps}");
                               }

                             });



                           },
                         ),
                         TextButton(
                           child: Row(
                             children: [
                               Column(
                                 children: [
                                   Center(child: const Text('아니요')),
                                 ],
                               ),
                             ],
                           ),
                           onPressed: () {
                             Navigator.of(context).pop();
                           },
                         ),
                       ],
                     );
                   }
               );


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

          nameController.add(TextEditingController());
          kgController.add(TextEditingController());
          repsController.add(TextEditingController());
          setsController.add(TextEditingController());

          textFieldRows.add(
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: TextField(
                      controller: nameController.isNotEmpty ? nameController[textFieldRows.length - 1] : nameController[0],
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
                      controller: setsController.isNotEmpty ? setsController[textFieldRows.length - 1] : setsController[0],
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
                      controller: kgController.isNotEmpty ? kgController[textFieldRows.length - 1] : kgController[0],
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
                      controller: repsController.isNotEmpty ? repsController[textFieldRows.length - 1] : repsController[0],
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


class RoutineWidget extends StatelessWidget {
  final String routineName;
  final List<Exercise> exercises;

  const RoutineWidget({Key? key, required this.routineName, required this.exercises})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ElevatedButton(
        onPressed: () {
          // 버튼이 눌렸을 때 수행할 동작 추가
          // 예를 들어, 해당 루틴에 대한 상세 정보를 표시하는 다이얼로그를 띄울 수 있습니다.
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Routine Details'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Routine Name: $routineName'),
                    for (Exercise exercise in exercises)
                      Text(
                        '  - Name: ${exercise.name}, Sets: ${exercise.sets}, KG: ${exercise.kg}, Reps: ${exercise.reps}',
                      ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: Text(routineName),
      ),
    );
  }
}



class Favorite extends StatelessWidget {
  final List<Exercise> exercises;

  const Favorite({Key? key, required this.exercises}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 중복된 루틴 이름(mainname)을 제거한 리스트
    List<String> uniqueRoutineNames =
    exercises.map((exercise) => exercise.mainname).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Exercises'),
      ),
      body: ListView.builder(
        itemCount: uniqueRoutineNames.length,
        itemBuilder: (context, index) {
          String routineName = uniqueRoutineNames[index];
          List<Exercise> routineExercises = exercises
              .where((exercise) => exercise.mainname == routineName)
              .toList();

          return RoutineWidget(routineName: routineName, exercises: routineExercises);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Home menu',
        child: Icon(Icons.home),
      ),
    );
  }
}

class Calender extends StatefulWidget{
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // UI의 해당 부분이 미완성임을 표시하는 위젯
      body: Placeholder(),

      // main page로 돌아가는 버튼
      // navigator 사용법은 다음 웹페이지에서 설명함
      // https://docs.flutter.dev/cookbook/navigation/navigation-basics
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
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
                      MaterialPageRoute(builder: (context) => Favorite(exercises: exercises))
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
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Calender()),
                  );
                }

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