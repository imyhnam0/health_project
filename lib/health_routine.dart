/* * 가독성 좋은 코드 만들기
 * 
 * 가독성은 사실 남들을 위한 게 아니라 날 위한 것이기도 하다.
 * 내가 만든 코드를 다시 보면서 이게 뭘 하는 거였지? 이걸 왜 이렇게 만들었지? 이런 생각을 하게 되는 일이 많기 때문이다.
 * 
 * 가독성 좋은 코드를 어떻게 만드는가? 이 코드를 처음 보는 사람의 입장이 되보면 좋다.
 * 이 코드를 처음 보는 사람은 무엇을 먼저 보게 될까?
 * 이 변수, 클래스 이름, 함수명은 어떻게 하면 이해하기 쉽게 만들 수 있을까?
 * 
 * 이후는 그걸 이루기 위한 방법론이다.
 * 
 * 
 * 
 * * 가장 먼저 네가 만든 코드에서 전역변수를 앞으로 뺐다.
 * 앞으로 전역변수로 쓰인 변수는 전부 다 앞으로 빼도록.
 * 그래야지 뭐가 전역변수인지 제대로 알 수 있기에 코드 다른 부분에도 이걸 쓰기에 용이하고 코드 이해가 쉬워진다.
 * 
 * 그리고 되도록이면 전역변수는 최대한 쓰지 않도록 하자. 기억해야 할 전역변수가 많아지면 이걸 관리하기가 힘들어진다.
 * 만약 전역변수를 많이 써야 한다면 되도록이면 클래스로 만들어서 객체지향적으로 한꺼번에 관리하도록 하자.
 * 
 * 
 * 
 * * 다음으로 적을 것은 변수로 사용될 클래스들이다.
 * 네 코드 전반에서 가장 많이 사용되는 클래스를 앞으로 빼서 네 처음 코드를 보는 사람들이 이해하기 쉽게 만들어야 한다.
 * 
 * 클래스 제작할 때 고려할 것:
 * 1. 클래스 내 메소드로 변수를 만들되 이게 복잡해지면 내가 SubExercise 클래스를 만든 것 처럼 클래스를 또 만들어서 변수를 관리하도록 하자.
 * 2. 코드를 작성하다 특정 기능을 수행하는 코드가 반복되면 클래스 내부의 메소드로 만들어서 코드를 간결하게 만들자.
 * 3. 굳이 반복되는 메소드 말고도 변수 추가, 삭제, 수정 등의 기능을 수행하는 메소드는 만들어 두는게 편리하다.
 * 
 * 클래스를 만드는 것은 객체지향을 위한 것이다.
 * 변수 하나하나 기억하는 것보다 클래스를 만들어서 객체 하나로 묶어 놓아야 이해하기도 쉽고 관리하기도 편리하다.
 * 
 * 
 * 
 * * Widget class순서
 * 이후 순서는 유저가 보는 화면 순서대로 정의하자.
 * 그러니 main.dart에서는 HealthRoutineMenu에 먼저 들어갈 것이니 HealthRoutineMenu를 먼저 정의하자.
 * 그 다음에는 CreateRoutine, Favorite, Calender 순서로 버튼을 만들었으니 코드 순서도 이렇게 되면 좋을 것이다.
 * 
 * 그리고 만약 한 Widget class 하위 class가 있다면 바로 다음에 정의하자. 이전에 정의하면 이게 뭐하는 기능인지 햇갈린다고 생각한다.
 * 
 * 
 * 
 * * 주석처리
 * 1. 내가 한 것처럼 class와 메소드, 함수 위에는 항상 주석을 달고 이 class가 어떤 역할을 하는지 간단하게 적어두자.
 * 
 * 2. 네가 쓴 코드의 로직에 중대한 영향을 주는 데이터에는 주석을 달아서 어떤 데이터인지 설명해두자.
 *  ex) CreateRoutine에서 nameController는 각 서브루틴의 이름을 관리하는 컨트롤러임을 설명한 부분 
 *        - 이로써 왜 setsController, kgController, repsController가 2차원 배열인지 알 수 있음
 * 
 * 3. 또한 햇갈릴만한 부분에는 주석을 달아서 설명해두자.
 *  ex) CreateRoutine에서 textFieldRows index와 nameController의 index는 같지 않음을 설명한 부분
 * 
 * 4. 쓸데없는 주석은 지워라.
 *  ex) color: Colors.blue, // 버튼 텍스트 색상 -> 누가 이게 버튼 텍스트 색상이라는걸 모르겠냐?
 * 
 * 
 * 
 * * 변수명
 * 변수명은 짧게 쓰라고 하는데 지랄이다. 굳이 짧게 쓸 필요가 없다.
 * 물론 너무 길게 쓰면 코드가 길어져서 가독성이 떨어지지만 변수를 왜 설정했는지 또는 역할이 무엇인지 알 수 있을 정도로 쓰자. ex) locationOfThisAddButton
 * 여기가 극에 달하면 사실 주석처리를 할 필요가 사라진다. 이게 진정한 코딩 고수의 경지다.
 * for문에서 i, j, k를 쓰는 경우가 많은데 for문이 길어지면 변수명도 길어져야 한다. sthIndex정도면 좋다.
 * 
 * 
 * 
 * * 마지막으로 코드를 정리하자.
 * 쓸데없는 엔터, 맞지 않는 들여쓰기는 코드 가독성을 엄청나게 떨어뜨린다.
 * 여기에 규칙 같은 것은 없지만 보통 언어나 프레임워크에서 추천해주는 양식이 있는데 그걸 따르는 것도 좋고 너만의 규칙이 있으면 그걸 따르는 것도 좋다.
 * 중요한 것은 그 규칙이 일정한 것이다.
 * 
 * 일정한 규칙이 깨지는 가장 쉬운 경우는 인터넷에서 복붙한 코드를 넣을 때다.
 * 다시 돌아가서 들여쓰기, 엔터를 맞추도록 하자.
 * 그리고 코드 좀 읽어보고 이해하고 넣자. 나중에 돌아와서 이해하려 하면 어려워.
 * 
 * 
 * 
 * * 그럼 어느정도까지 정리해야 하는가?
 * 네 코드가 공식 문서로 보일 정도까지 되면 좋다. 
 * 근데 이 코드 너랑 나 말고 누가 보냐?
 * 작은 프로젝트에는 내가 한 정도면 충분하다고 생각한다.
 * 
 * 그리고 솔직히 내가 코드 잘 쓰는 공부를 한 것도 아니니까 이 규칙이 반드시 맞는 것은 아닌데 내 말을 적용하면 네 코드가 더 깔끔해질거라고 생각한다.
 * 
 * 
 * 
 * 이걸 읽으면 가장 먼저 해야 할 게 무엇이냐? 바로 이 주석을 지우는 것이다.
 * 코드 내용과 하등 상관 없는 것은 가장 먼저 지워야 한다.
 * 
 * 이제 좀 더 가독성 좋은 코드를 만들어봐라.
 * 
 */


import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// 전체 루틴 리스트
// 전체 루틴 리스트를 전역변수로 선언하였기 때문에 class간 통신이 필요 없음
// 원하면 프로그램 어디서든 exercises를 사용할 수 있음
List<Exercise> exercises = [];
DateTime savedDay = DateTime.now();

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
}

// 루틴은 하루에 할 운동들의 집합
// 하나의 루틴은 여러 서브루틴으로 구성
class Exercise {
  String mainname;
  List<String> subExcerciseName;
  Map<String, SubExercise> subExercises;

  Exercise({
    required this.mainname,
    required this.subExcerciseName,
    required this.subExercises,
  });

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
            // const SizedBox(height: 80),

            // // 즐겨찾기 메뉴
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(0),
            //     ),
            //     fixedSize: const Size(300, 100),
            //   ),
            //   child: const Text('즐겨찾기',
            //     style: TextStyle(fontSize: 18),
            //   ),
            //   onPressed: (){
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => Favorite())
            //     );
            //   }
            // ),
            // const SizedBox(height: 80),

            // // 달력 메뉴
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(0),
            //     ),
            //     fixedSize: const Size(300, 100),
            //   ),
            //   child: const Text('달력',
            //     style: TextStyle(fontSize: 18),
            //   ),
            //   onPressed: (){
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Calender(exercises: exercises,selectedDay:savedDay ),
            //     ));
            //   }
            // ),
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
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HealthRoutineMenu())
                            );

                            setState(() {
                              final Exercise exercise = Exercise(
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

                                exercise.addSubExercise(name, sets, kg, reps);
                              }

                              exercises.add(exercise);

                              // 제대로 들어갔는지 확인하기 위한 코드
                              print(exercises);
                            });
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
}


// // 즐겨찾기 페이지
// class Favorite extends StatefulWidget {

//   const Favorite({Key? key}) : super(key: key);

//   @override
//   State<Favorite> createState() => _FavoriteState();
// }

// class _FavoriteState extends State<Favorite> {
//   @override
//   Widget build(BuildContext context) {
//     List<String> uniqueRoutineNames = exercises.map((exercise) => exercise.mainname).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Exercises'),
//       ),
//       body: ListView.builder(
//         itemCount: uniqueRoutineNames.length,
//         itemBuilder: (context, index) {
//           String routineName = uniqueRoutineNames[index];
//           List<Exercise> routineExercises = exercises.where((exercise) => exercise.mainname == routineName).toList();

//           return RoutineWidget(
//             routineName: routineName, 
//             exercises: routineExercises,
//             onDelete: () {
//               setState(() {
//                 exercises.removeWhere((exercise) => exercise.mainname == routineName);
//               });
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Routine "$routineName" deleted.'),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         tooltip: 'Home menu',
//         child: const Icon(Icons.home),
//       ),
//     );
//   }
// }

// //즐겨찾기
// class RoutineWidget extends StatefulWidget {
//   final String routineName;
//   final List<Exercise> exercises;
//   final VoidCallback onDelete;

//   const RoutineWidget({Key? key, required this.routineName, required this.exercises, required this.onDelete}) : super(key: key);

//   @override
//   State<RoutineWidget> createState() => _RoutineWidgetState();
// }

// class _RoutineWidgetState extends State<RoutineWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Routine Name: ${widget.routineName}'),
//                     content: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         for (Exercise exercise in widget.exercises)
//                           Card(
//                             child: Column(
//                               children: [
//                                 for (SubExercise subExercise in exercise.subExercisesList)
//                                   ListTile(
//                                     title: Text('Name: ${subExercise.name}, ', style: const TextStyle(fontSize: 16)),
//                                     subtitle: Column(
//                                       children: [
//                                         for (int i = 0; i < subExercise.sets.length; i++)
//                                           Text(
//                                             'Sets: ${subExercise.sets[i]}, \n'
//                                             'KG: ${subExercise.kg[i]}, \n'
//                                             'Reps: ${subExercise.reps[i]}',
//                                           ),
//                                       ],
//                                     ),
//                                     trailing: ElevatedButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           _editExercise(subExercise);
//                                         });
//                                       },
//                                       child: const Text('Edit'),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                       ],
//                     ),
//                     actions: [
//                       ElevatedButton(
//                         onPressed: () {
//                           widget.onDelete();
//                           Navigator.pop(context);
//                         },
//                         child: const Text('Delete'),
//                       ),
//                       // // ElevatedButton(
//                       //   onPressed: () {
//                       //     Navigator.push(
//                       //       context,
//                       //       MaterialPageRoute(
//                       //         builder: (context) => Calender(
//                       //           exercises: exercises,
//                       //           selectedDay: savedDay,
//                       //         ),
//                       //       ),
//                       //     );
//                       //     Navigator.pop(context);
//                       //   },
//                       //   child: const Text('save'),
//                       // ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           'Close',
//                           style: TextStyle(
//                             color: Colors.blue, // 버튼 텍스트 색상
//                             fontSize: 18.0,
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: Text(widget.routineName),
//           ),
//         ],
//       ),
//     );
//   }

//   // 운동 편집 다이얼로그
//   Future<void> _editExercise(SubExercise exercise) async {
//     TextEditingController mainnameController = TextEditingController();
//     List<TextEditingController> nameControllers = [];
//     List<TextEditingController> setsControllers = [];
//     List<TextEditingController> kgControllers = [];
//     List<TextEditingController> repsControllers = [];

//     // 기존 값으로 컨트롤러 초기화
//     mainnameController.text = exercise.mainname;
//     for (int totalLengthOfTextFieldRows = 0; totalLengthOfTextFieldRows < exercise.name.length; totalLengthOfTextFieldRows++) {
//       nameControllers.add(TextEditingController(text: exercise.name[totalLengthOfTextFieldRows]));
//       setsControllers.add(TextEditingController(text: exercise.sets[totalLengthOfTextFieldRows].toString()));
//       kgControllers.add(TextEditingController(text: exercise.kg[totalLengthOfTextFieldRows].toString()));
//       repsControllers.add(TextEditingController(text: exercise.reps[totalLengthOfTextFieldRows].toString()));
//     }

//     // 다이얼로그 열기
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Edit Exercise'),
//           content: Column(
//             children: [
//               // mainname 편집은 필요에 따라 추가
//               TextField(
//                 controller: mainnameController,
//                 decoration: InputDecoration(labelText: 'Main Name'),
//               ),
//               // 운동 정보들을 리스트로 편집
//               for (int totalLengthOfTextFieldRows = 0; totalLengthOfTextFieldRows < nameControllers.length; totalLengthOfTextFieldRows++)
//                 Column(
//                   children: [
//                     TextField(
//                       controller: nameControllers[totalLengthOfTextFieldRows],
//                       decoration: InputDecoration(labelText: 'Name'),
//                     ),
//                     TextField(
//                       controller: setsControllers[totalLengthOfTextFieldRows],
//                       decoration: InputDecoration(labelText: 'Sets'),
//                     ),
//                     TextField(
//                       controller: kgControllers[totalLengthOfTextFieldRows],
//                       decoration: InputDecoration(labelText: 'KG'),
//                     ),
//                     TextField(
//                       controller: repsControllers[totalLengthOfTextFieldRows],
//                       decoration: InputDecoration(labelText: 'Reps'),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // 편집 완료 시 운동 정보 업데이트
//                 setState(() {
//                   exercise.mainname = mainnameController.text;
//                   exercise.name.clear();
//                   exercise.sets.clear();
//                   exercise.kg.clear();
//                   exercise.reps.clear();

//                   for (int totalLengthOfTextFieldRows = 0; totalLengthOfTextFieldRows < nameControllers.length; totalLengthOfTextFieldRows++) {
//                     exercise.name.add(nameControllers[totalLengthOfTextFieldRows].text);
//                     exercise.sets.add(int.parse(setsControllers[totalLengthOfTextFieldRows].text));
//                     exercise.kg.add(double.parse(kgControllers[totalLengthOfTextFieldRows].text));
//                     exercise.reps.add(int.parse(repsControllers[totalLengthOfTextFieldRows].text));
//                   }
//                 });
//                 Navigator.pop(context);
//               },
//               child: Text('Save'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


// // 달력 페이지
// class Calender extends StatefulWidget{
//   final List<Exercise> exercises;
//   final DateTime selectedDay;

//   const Calender({Key? key, required this.exercises, required this.selectedDay}) : super(key: key);


//   @override
//   State<Calender> createState() => _CalenderState();
// }

// class _CalenderState extends State<Calender> {
//   DateTime focusedDay = DateTime.now();

//   DateTime selectedDay = DateTime(
//     DateTime.now().year,
//     DateTime.now().month,
//     DateTime.now().day,
//   );



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TableCalendar(
//             firstDay: DateTime.utc(2024, 1, 1),
//             lastDay: DateTime.utc(2030, 1, 11),
//             focusedDay: focusedDay,
//             onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
//               // 선택된 날짜의 상태를 갱신합니다.
//               setState(() {
//                 this.selectedDay = selectedDay;
//                 this.focusedDay = focusedDay;
//               });
//             },
//             selectedDayPredicate: (DateTime day) {
//               // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
//               return isSameDay(selectedDay, day);
//             },
//           ),
//           Text('운동 정보 - ${widget.selectedDay.year}.${widget.selectedDay.month}.${widget.selectedDay.day}'),
//           for (Exercise exercise in widget.exercises)
//             if (isSameDay(widget.selectedDay, DateTime.parse(exercise.mainname)))
//               for (int totalLengthOfTextFieldRows = 0; totalLengthOfTextFieldRows < exercise.name.length; totalLengthOfTextFieldRows++)
//                 ListTile(
//                   title: Text(
//                     'Name: ${exercise.name[totalLengthOfTextFieldRows]}, Sets: ${exercise.sets[totalLengthOfTextFieldRows]}, KG: ${exercise.kg[totalLengthOfTextFieldRows]}, Reps: ${exercise.reps[totalLengthOfTextFieldRows]}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         tooltip: 'Home menu',
//         child: const Icon(Icons.home),
//       ),
//     );
//   }
// }