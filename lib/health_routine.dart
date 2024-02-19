import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 전체 루틴 리스트
// 전체 루틴 리스트를 전역변수로 선언하였기 때문에 class간 통신이 필요 없음
// 원하면 프로그램 어디서든 exercises를 사용할 수 있음
late List<Exercise> exercises;

// 서브루틴이란 하루 루틴의 일부분으로, 하나의 루틴에는 여러 개의 서브루틴이 존재
// 운동할 때 세트 수, 무게, 횟수 등등이 바뀔 수 있기 때문에 서브루틴을 만들어서 관리
class SubExercise {
  String name;
  List<int> sets;
  List<double> kg;
  List<int> reps;

  SubExercise({
    required this.name,
    required this.sets,
    required this.kg,
    required this.reps,
  });

  void combine(SubExercise subExercise) {
    sets.addAll(subExercise.sets);
    kg.addAll(subExercise.kg);
    reps.addAll(subExercise.reps);
  }

  @override
  String toString() {
    return 'SubExercise{name: $name, sets: $sets, kg: $kg, reps: $reps}';
  }

  SubExercise.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        sets = (json['sets'] as List).cast<int>(),
        kg = (json['kg'] as List).cast<double>(),
        reps = (json['reps'] as List).cast<int>();

  Map<String, dynamic> toJson() => {
    'name': name,
    'sets': sets,
    'kg': kg,
    'reps': reps,
  };
}

// 루틴은 하루에 할 운동들의 집합
// 하나의 루틴은 여러 서브루틴으로 구성
class Exercise {
  String mainname;
  DateTime date;
  List<String> subExcerciseName;
  Map<String, SubExercise> subExercises;

  Exercise({
    required this.mainname,
    required this.subExcerciseName,
    required this.subExercises,
  }) : date = DateTime.now();

  List<String> get exerciseNames => subExcerciseName;
  List<SubExercise> get subExercisesList => subExercises.values.toList();

  @override
  String toString() {
    return 'Exercise{mainname: $mainname, subExcerciseName: $subExcerciseName, subExercises: $subExercises}';
  }

  // 서브루틴 추가
  void addSubExercise(String name, List<int> sets, List<double> kg, List<int> reps) {
    SubExercise subExercise = SubExercise(
      name: name,
      sets: sets,
      kg: kg,
      reps: reps,
    );
    subExcerciseName.add(name);
    if (subExercises.keys.contains(name)) {
      subExercises[name]!.combine(subExercise);
    }
    else {
      subExercises[name] = subExercise;
    }
  }
  
  Exercise.fromJson(Map<String, dynamic> json)
      : mainname = json['mainname'] as String,
        date = DateTime.parse(json['date'] as String),
        subExcerciseName = (json['subExcerciseName'] as List).cast<String>(),
        subExercises = (json['subExercises'] as Map<String, dynamic>).map((key, value) => MapEntry(key, SubExercise.fromJson(value)));
  
  Map<String, dynamic> toJson() => {
    'mainname': mainname,
    'date': date.toIso8601String(),
    'subExcerciseName': subExcerciseName,
    'subExercises': subExercises.map((key, value) => MapEntry(key, value.toJson())),
  };
}


// 헬스 루틴을 들어가면 가장 처음으로 보이는 페이지
class HealthRoutineMenu extends StatelessWidget{
  const HealthRoutineMenu({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('헬스 루틴'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // 루틴 생성 메뉴
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  fixedSize: const Size(300, 100),
                ),
                child: const Text('루틴 생성',
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

            // 즐겨찾기 메뉴
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
                      MaterialPageRoute(builder: (context) => const Favorite())
                  );
                }
            ),
            const SizedBox(height: 80),

            // 달력 메뉴
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
                      MaterialPageRoute(builder: (context) => const Calender(),
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


// 루틴 생성 페이지
class CreateRoutine extends StatefulWidget {
  const CreateRoutine({Key? key}) : super(key: key);


  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {

  // mainnameController는 전체루틴 이름을 관리
  TextEditingController mainnameController = TextEditingController();

  // nameController는 각 서브루틴 이름을 관리
  List<TextEditingController> nameController = [];

  // nameController의 index는 곧 서브루틴의 index가 됨
  List<List<TextEditingController>> setsController = [];
  List<List<TextEditingController>> kgController = [];
  List<List<TextEditingController>> repsController = [];

  // textFieldRows는 각 입력창들의 행을 관리.
  // 여기 index와 nameController의 index는 같지 않음
  List<Widget> textFieldRows = [];

  // 화면 처음에 제목만이 있는 텍스트 필드를 만들어줌
  @override
  void initState() {
    super.initState();
    textFieldRows.add(
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: 100,
                height: 100,
                child: TextField(
                  controller: mainnameController,
                  decoration: const InputDecoration(
                    labelText: 'Routine Name: ',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

  // 화면 맨 밑 + 버튼의 구현
  Widget _plusButtonOnTheBottom(BuildContext context) {
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
        setState(() {
          nameController.add(TextEditingController());
          setsController.add([TextEditingController()]);
          kgController.add([TextEditingController()]);
          repsController.add([TextEditingController()]);

          textFieldRows.add(
            Builder(
                builder: (context) {
                  final indexOfNameController = nameController.length - 1;
                  return Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: TextField(
                            controller: nameController.last,
                            decoration: const InputDecoration(
                              labelText: 'Name: ',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: TextField(
                            controller: setsController.last[0],
                            decoration: const InputDecoration(
                              labelText: 'Sets: ',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: TextField(
                            controller: kgController.last[0],
                            decoration: const InputDecoration(
                              labelText: 'kg: ',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: TextField(
                            controller: repsController.last[0],
                            decoration: const InputDecoration(
                              labelText: 'reps: ',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),

                      // thisAdd를 누르면 해당 subExercise에서 새로운 sets, kg, reps를 추가함
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            setsController[indexOfNameController].add(TextEditingController());
                            kgController[indexOfNameController].add(TextEditingController());
                            repsController[indexOfNameController].add(TextEditingController());

                            // 이 코드는 textFieldRows의 thisAdd를 누른 위치를 확인하고
                            // 해당 subExercise를 관리하는 row 마지막에 새로운 textField를 추가함
                            final locationOfThisAddButton = textFieldRows.indexOf(context.widget);
                            textFieldRows.insert(locationOfThisAddButton + kgController[indexOfNameController].length -1,
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: TextField(
                                          controller: setsController[indexOfNameController].last,
                                          decoration: const InputDecoration(
                                            labelText: 'Sets: ',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: TextField(
                                          controller: kgController[indexOfNameController].last,
                                          decoration: const InputDecoration(
                                            labelText: 'kg: ',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: TextField(
                                          controller: repsController[indexOfNameController].last,
                                          decoration: const InputDecoration(
                                            labelText: 'reps: ',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            );
                          });
                        },
                        child: const Text('thisadd'),
                      )
                    ],
                  );
                }
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('루틴 생성'),
      ),
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
                    builder: (BuildContext context) => AlertDialog(
                      content: const Text('정말 저장하시겠습니까?'),
                      insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
                      actions: [
                        TextButton(
                          child: const Row(
                            children: [
                              Column(
                                children: [
                                  Center(child: Text('예')),
                                ],
                              ),
                            ],
                          ),
                          onPressed: () {
                            final Exercise subExercise = Exercise(
                              mainname: mainnameController.text,
                              subExcerciseName: [],
                              subExercises: {},
                            );

                            for(int i = 0; i < nameController.length; i++) {
                              String name = nameController[i].text == '' ? '$i번째 운동' : nameController[i].text;
                              List<int> sets = [];
                              List<double> kg = [];
                              List<int> reps = [];

                              for (int j = 0; j < setsController[i].length; j++) {
                                sets.add(int.parse(setsController[i][j].text == '' ? '0' : setsController[i][j].text));
                                kg.add(double.parse(kgController[i][j].text == '' ? '0' : kgController[i][j].text));
                                reps.add(int.parse(repsController[i][j].text == '' ? '0' : repsController[i][j].text));
                              }

                              subExercise.addSubExercise(name, sets, kg, reps);
                            }

                            exercises.add(subExercise);
                            saveRoutineToFirestore(subExercise);

                            // healthRoutineMenu로 돌아감
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            setState(() {});
                          },
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Column(
                                children: [
                                  Center(child: Text('아니요')),
                                ],
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              _plusButtonOnTheBottom(context),
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
  Future<void> saveRoutineToFirestore(Exercise exercise) async {
    // Firestore 인스턴스 생성

      // 현재 사용자의 UID
      final User? user = FirebaseAuth.instance.currentUser;
      String currentUserId = user!.uid;
      // 실제로는 FirebaseAuth 등을 통해 가져와야 합니다.

    // 루틴 데이터를 Firestore에 추가
    await FirebaseFirestore.instance
      .collection('user')
      .doc(currentUserId)
      .collection('routines')
      .doc(exercise.date.toIso8601String())
      .set(exercise.toJson());
  }
}



// 즐겨찾기 페이지
class Favorite extends StatefulWidget {

  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    List<String> uniqueRoutineNames = exercises.map((exercise) => exercise.mainname).toSet().toList();
    
    final User? user = FirebaseAuth.instance.currentUser;
    String currentUserId = user!.uid;
    
    CollectionReference routines = FirebaseFirestore.instance
      .collection('user')
      .doc(currentUserId)
      .collection('routines');

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Exercises'),
      ),
      body: ListView.builder(
        itemCount: uniqueRoutineNames.length,
        itemBuilder: (context, index) {
          String routineName = uniqueRoutineNames[index];
          List<Exercise> routineExercises = exercises.where((exercise) => exercise.mainname == routineName).toList();

          return RoutineWidget(
            routineName: routineName,
            exercises: routineExercises,
            onDelete: () {
              setState(() {
                exercises.where((exercise) => exercise.mainname == routineName,)
                         .forEach((exercise) {
                            routines.doc(exercise.date.toIso8601String()).delete();
                          });
                exercises.removeWhere((exercise) => exercise.mainname == routineName);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Routine "$routineName" deleted.'),
                ),
              );
            },
          );
        },
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

//즐겨찾기
class RoutineWidget extends StatefulWidget {
  final String routineName;
  final List<Exercise> exercises;
  final VoidCallback onDelete;

  const RoutineWidget({Key? key, required this.routineName, required this.exercises, required this.onDelete}) : super(key: key);

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
              _showExerciseOnPress(context);
            },
            child: Text(widget.routineName),
          ),
        ],
      ),
    );
  }

  // 해당 subExercise를 누르면 보여주는 다이얼로그
  Future<void> _showExerciseOnPress(context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Routine Name: ${widget.routineName}'),
          content: SizedBox(
            height: 300,
            width: 450,
            child: ListView(
              children: [
                for (Exercise exercise in widget.exercises)
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (SubExercise subExercise in exercise.subExercisesList)
                          ListTile(
                            title: Text('Name: ${subExercise.name}, ', style: const TextStyle(fontSize: 16)),
                            subtitle: Column(
                              children: [
                                for (int i = 0; i < subExercise.sets.length; i++)
                                  Column(
                                    children: [
                                      Text(
                                        'Sets: ${subExercise.sets[i]}, \n'
                                            'KG: ${subExercise.kg[i]}, \n'
                                            'Reps: ${subExercise.reps[i]}',
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                              ],
                            ),
                            trailing: ElevatedButton(
                              onPressed: () async {
                                await _editSubExercise(exercise, subExercise);
                                setState(() {
                                  Navigator.pop(context);
                                  _showExerciseOnPress(context);
                                });
                              },
                              child: const Text('Edit'),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                widget.onDelete();
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
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
  }

  // 운동 편집 다이얼로그
  Future<void> _editSubExercise(Exercise exercise, SubExercise subExercise) async {
    TextEditingController nameController = TextEditingController();
    List<TextEditingController> setsControllers = [];
    List<TextEditingController> kgControllers = [];
    List<TextEditingController> repsControllers = [];

    // 기존 값으로 컨트롤러 초기화
    nameController.text = subExercise.name;
    for (int i = 0; i < subExercise.sets.length; i++) {
      setsControllers.add(TextEditingController(text: subExercise.sets[i].toString()));
      kgControllers.add(TextEditingController(text: subExercise.kg[i].toString()));
      repsControllers.add(TextEditingController(text: subExercise.reps[i].toString()));
    }

    // 다이얼로그에는 편집할 수 있는 텍스트 필드들을 보여줌
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Exercise'),
          content: SizedBox(
            height: 300,
            width: 450,
            child: ListView(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Main Name'),
                ),
                // 운동 정보들을 리스트로 편집
                for (int i = 0; i < setsControllers.length; i++)
                  Card(
                    child: Column(
                      children: [
                        TextField(
                          controller: setsControllers[i],
                          decoration: const InputDecoration(labelText: 'Sets'),
                        ),
                        TextField(
                          controller: kgControllers[i],
                          decoration: const InputDecoration(labelText: 'KG'),
                        ),
                        TextField(
                          controller: repsControllers[i],
                          decoration: const InputDecoration(labelText: 'Reps'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // 편집 완료 시 운동 정보 업데이트
                setState(() {
                  subExercise.name = nameController.text;
                  subExercise.sets.clear();
                  subExercise.kg.clear();
                  subExercise.reps.clear();

                  for (int i = 0; i < setsControllers.length; i++) {
                    subExercise.sets.add(int.parse(setsControllers[i].text));
                    subExercise.kg.add(double.parse(kgControllers[i].text));
                    subExercise.reps.add(int.parse(repsControllers[i].text));
                  }
                });

                updateRoutineToFirestore(exercise);
                
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
  
  Future<void> updateRoutineToFirestore(Exercise exercise) async {
    // Firestore 인스턴스 생성

      // 현재 사용자의 UID
      final User? user = FirebaseAuth.instance.currentUser;
      String currentUserId = user!.uid;
      // 실제로는 FirebaseAuth 등을 통해 가져와야 합니다.

    // 루틴 데이터를 Firestore에 추가
    await FirebaseFirestore.instance
      .collection('user')
      .doc(currentUserId)
      .collection('routines')
      .doc(exercise.date.toIso8601String())
      .set(exercise.toJson());
  }
}


// 달력 페이지
class Calender extends StatefulWidget{

  const Calender({Key? key}) : super(key: key);


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
      body: ListView(
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
            selectedDayPredicate: (DateTime day) => isSameDay(selectedDay, day),
          ),
          Text('운동 정보 - ${selectedDay.year}.${selectedDay.month}.${selectedDay.day}'),
          for (Exercise exercise in exercises)
            if (isSameDay(selectedDay, exercise.date))
              Card(
                child: Column(
                    children: [
                      ListTile(
                        title: Text('루틴 이름: ${exercise.mainname}'),
                      ),
                      for (SubExercise subExercise in exercise.subExercisesList)
                        ListTile(
                            title: Text(
                              'Name: ${subExercise.name}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            subtitle: Column(
                              children: [
                                for (int i = 0; i < subExercise.sets.length; i++)
                                  Column(
                                    children: [
                                      Text(
                                        'Sets: ${subExercise.sets[i]}, \n'
                                            'KG: ${subExercise.kg[i]}, \n'
                                            'Reps: ${subExercise.reps[i]}',
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                              ],
                            )
                        ),
                    ]
                ),
              )
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