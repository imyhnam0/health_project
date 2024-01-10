import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class Exercise {
  String mainname;
  List<String> name;
  List<int> sets;
  List<double> kg;
  List<int> reps;

  Exercise({
    required this.mainname,
    required this.name,
    required this.sets,
    required this.kg,
    required this.reps,

  });
}

List<Exercise> exercises = [];
DateTime savedDay = DateTime.now();

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({Key? key}) : super(key: key);

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {

  var mainnameController = TextEditingController();
  var nameController = <Map<int , TextEditingController>>[];
  var setsController =  <Map<int , TextEditingController>>[];
  var kgController =  <Map<int , TextEditingController>>[];
  var repsController =  <Map<int , TextEditingController>>[];

  List<Widget> textFieldRows = [];
  DateTime savedDay = DateTime.now();

  int i=1;

  @override
 void initState() {
    super.initState();
    i = 1;
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
                                   name: [nameController[i]?.values.first?.text ?? ''], // Using null-aware operators
                                   sets: [int.parse(setsController[i]?.values.first?.text ?? '0')], // Using null-aware operators
                                   kg: [double.parse(kgController[i]?.values.first?.text ?? '0.0')], // Using null-aware operators
                                   reps: [int.parse(repsController[i]?.values.first?.text ?? '0')],


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
          i++;
          nameController.add({i: TextEditingController()});
          kgController.add({i: TextEditingController()});
          repsController.add({i: TextEditingController()});
          setsController.add({i: TextEditingController()});

          textFieldRows.add(
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: TextField(
                      controller: nameController.isNotEmpty ? nameController[textFieldRows.length - 1][textFieldRows.length - 1] : nameController[0][0],
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
                      controller: setsController.isNotEmpty ? setsController[textFieldRows.length - 1][textFieldRows.length - 1] : setsController[0][0],
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
                      controller: kgController.isNotEmpty ? kgController[textFieldRows.length - 1][textFieldRows.length - 1] : kgController[0][0],
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
                      controller: repsController.isNotEmpty ? repsController[textFieldRows.length - 1][textFieldRows.length - 1] : repsController[0][0],
                      decoration: InputDecoration(
                        labelText: 'reps: ',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {

                      setState(() {

                        nameController.add({i: TextEditingController()});
                        kgController.add({i: TextEditingController()});
                        repsController.add({i: TextEditingController()});
                        setsController.add({i: TextEditingController()});
                      });
                      // Add a new row of text fields when the 'thisadd' button is pressed

                      textFieldRows.insert(i,
                        Row(
                        children: [

                          Expanded(
                            child: Container(
                              width: 100,
                              height: 100,
                              child: TextField(
                                controller:  setsController[textFieldRows.length - 1][textFieldRows.length - 1],
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
                                controller: kgController[textFieldRows.length - 1][textFieldRows.length - 1],
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
                                controller: repsController[textFieldRows.length - 1][textFieldRows.length - 1],
                                decoration: InputDecoration(
                                  labelText: 'reps: ',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),


                        ],

                      ));

                    },
                    child: const Text(
                      'thisadd',
                    ),
                  ),
                )

              ],
            ),
          );





        });
      },

    );

  }

}


class RoutineWidget extends StatefulWidget {

  final String routineName;
  final List<Exercise> exercises;
  final VoidCallback onDelete;

  const RoutineWidget({Key? key, required this.routineName, required this.exercises, required this.onDelete})
      : super(key: key);

  @override
  State<RoutineWidget> createState() => _RoutineWidgetState();
}

class _RoutineWidgetState extends State<RoutineWidget> {


  @override
  Widget build(BuildContext context) {
    return Card(

      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // 버튼이 눌렸을 때 수행할 동작 추가
              // 예를 들어, 해당 루틴에 대한 상세 정보를 표시하는 다이얼로그를 띄울 수 있습니다.
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Routine Name: ${widget.routineName}'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (Exercise exercise in widget.exercises)
                          ListTile(
                            title: Text(
                              'Name: ${exercise.name}, Sets: ${exercise
                                  .sets}, KG: ${exercise.kg}, Reps: ${exercise
                                  .reps}',
                              style: TextStyle(fontSize: 16),
                            ),

                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _editExercise(exercise);
                                });
                                // 편집 버튼이 눌렸을 때 수행할 동작 추가

                              },
                              child: Text('Edit'),
                            ),
                          ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {

                          widget.onDelete();
                          Navigator.pop(context);
                        },
                        child: Text('Delete'),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Calender(
                                exercises: exercises,
                                selectedDay: savedDay,
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Text('save'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.blue, // 버튼 텍스트 색상
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(widget.routineName),
          ),
        ],
      ),
    );
  }

  // 운동 편집 다이얼로그
  Future<void> _editExercise(Exercise exercise) async {
    TextEditingController mainnameController = TextEditingController();
    List<TextEditingController> nameControllers = [];
    List<TextEditingController> setsControllers = [];
    List<TextEditingController> kgControllers = [];
    List<TextEditingController> repsControllers = [];


    // 기존 값으로 컨트롤러 초기화
    mainnameController.text = exercise.mainname;
    for (int i = 0; i < exercise.name.length; i++) {
      nameControllers.add(TextEditingController(text: exercise.name[i]));
      setsControllers.add(TextEditingController(text: exercise.sets[i].toString()));
      kgControllers.add(TextEditingController(text: exercise.kg[i].toString()));
      repsControllers.add(TextEditingController(text: exercise.reps[i].toString()));
    }

    // 다이얼로그 열기
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Exercise'),
          content: Column(
            children: [
              // mainname 편집은 필요에 따라 추가
              TextField(
                controller: mainnameController,
                decoration: InputDecoration(labelText: 'Main Name'),
              ),
              // 운동 정보들을 리스트로 편집
              for (int i = 0; i < nameControllers.length; i++)
                Column(
                  children: [
                    TextField(
                      controller: nameControllers[i],
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: setsControllers[i],
                      decoration: InputDecoration(labelText: 'Sets'),
                    ),
                    TextField(
                      controller: kgControllers[i],
                      decoration: InputDecoration(labelText: 'KG'),
                    ),
                    TextField(
                      controller: repsControllers[i],
                      decoration: InputDecoration(labelText: 'Reps'),
                    ),
                  ],
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // 편집 완료 시 운동 정보 업데이트
                setState(() {
                  exercise.mainname = mainnameController.text;
                  exercise.name.clear();
                  exercise.sets.clear();
                  exercise.kg.clear();
                  exercise.reps.clear();

                  for (int i = 0; i < nameControllers.length; i++) {
                    exercise.name.add(nameControllers[i].text);
                    exercise.sets.add(int.parse(setsControllers[i].text));
                    exercise.kg.add(double.parse(kgControllers[i].text));
                    exercise.reps.add(int.parse(repsControllers[i].text));
                  }
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}



class Favorite extends StatefulWidget {
  final List<Exercise> exercises;

  const Favorite({Key? key, required this.exercises}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    // 중복된 루틴 이름(mainname)을 제거한 리스트
    List<String> uniqueRoutineNames =
    widget.exercises.map((exercise) => exercise.mainname).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Exercises'),
      ),
      body: ListView.builder(
        itemCount: uniqueRoutineNames.length,
        itemBuilder: (context, index) {
          String routineName = uniqueRoutineNames[index];
          List<Exercise> routineExercises = widget.exercises
              .where((exercise) => exercise.mainname == routineName)
              .toList();

          return RoutineWidget(routineName: routineName, exercises: routineExercises,onDelete: () {
            // 삭제 버튼 눌렀을 때 수행할 동작
            // exercises 리스트에서 해당 루틴을 제거

            setState(() {
              widget.exercises.removeWhere((exercise) => exercise.mainname == routineName);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Routine "$routineName" deleted.'),
              ),
            );
          },);
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
  final List<Exercise> exercises;
  final DateTime selectedDay;

  const Calender({Key? key, required this.exercises, required this.selectedDay}) : super(key: key);


  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime focusedDay = DateTime.now();

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2030, 1, 11),
            focusedDay: focusedDay,
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              // 선택된 날짜의 상태를 갱신합니다.
              setState(() {
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (DateTime day) {
              // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
              return isSameDay(selectedDay, day);
            },
          ),
          Text('운동 정보 - ${widget.selectedDay.year}.${widget.selectedDay.month}.${widget.selectedDay.day}'),
          for (Exercise exercise in widget.exercises)
            if (isSameDay(widget.selectedDay, DateTime.parse(exercise.mainname)))
              for (int i = 0; i < exercise.name.length; i++)
                ListTile(
                  title: Text(
                    'Name: ${exercise.name[i]}, Sets: ${exercise.sets[i]}, KG: ${exercise.kg[i]}, Reps: ${exercise.reps[i]}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
        ],
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
                    MaterialPageRoute(builder: (context) => Calender(exercises: exercises,selectedDay:savedDay ),
                  ));
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