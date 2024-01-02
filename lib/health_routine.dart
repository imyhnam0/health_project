import 'package:flutter/material.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({Key? key}) : super(key: key);

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {


  List<Widget> textFieldRows = [
    // Initial row of text fields
    Row(
      children: [
        Expanded(
          child: Container(
            width: 100,
            height: 100,
            child: TextField(
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
              decoration: InputDecoration(
                labelText: 'reps: ',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    ),
  ];


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
          textFieldRows.add(
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: TextField(
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

