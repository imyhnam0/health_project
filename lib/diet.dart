import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/today.dart';

class DietMenu extends StatefulWidget{
  const DietMenu({super.key});

  @override
  State<DietMenu> createState() => _DietMenuState();
}

class _DietMenuState extends State<DietMenu> {
  TodayDiet diet = TodayDiet();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('diet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                fixedSize: const Size(300, 100),
              ),
              child: const Text('오늘 식단', style: TextStyle(fontSize: 18)),
              onPressed: () {
                setState(() async {
                  diet = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TodayMenu(diet: diet))
                  );
                });
              },
            ),
            const SizedBox(height: 80),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                fixedSize: const Size(300, 100),
              ),
              child: const Text('즐겨찾기', style: TextStyle(fontSize: 18)),
              onPressed: () {
                setState(() async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => History(diet: diet))
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TodayMenu extends StatefulWidget {
  final TodayDiet diet;
  const TodayMenu({super.key, required this.diet});

  @override
  State<TodayMenu> createState() => _TodayMenuState();
}

class _TodayMenuState extends State<TodayMenu> {
  _TodayMenuState();

  final nameCtrl = TextEditingController();
  final gramCtrl = TextEditingController();
  final kcalCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var diet = widget.diet;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Today Diet'),
        leading: BackButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context, diet);
                    });
                  },
                )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Enter Name')
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: nameCtrl,
            ),
            const SizedBox(height: 5),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Enter Gram')
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '0',
              ),
              controller: gramCtrl,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 5),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Enter Kcal')
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '0',
              ),
              controller: kcalCtrl,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if(nameCtrl.text.isEmpty) {
                  showDialog(
                    context: context, 
                    builder: (context) => AlertDialog(
                      content: const Text('name must be not empty'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                  return;
                }
                if (gramCtrl.text.isEmpty || kcalCtrl.text.isEmpty) {
                  bool result = await showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        content: const Text('If gram or kcal is 0, it will be saved as 0.\nDo you wish to save as such?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context, true),
                          )
                        ],
                      );
                    },
                  ) ?? false;
                  if(!result) return;
                }
                diet.addInfo(
                  Meal(
                    nameCtrl.text, 
                    int.parse(gramCtrl.text.isEmpty ? '0' : gramCtrl.text), 
                    int.parse(kcalCtrl.text.isEmpty ? '0' : kcalCtrl.text)
                  )
                );
              },
              child: const Text('Add'),
            ),
          ],
        )
      ),
    );
  }
}

// 다음 페이지의 sample code에 따라 수정할 것
//https://api.flutter.dev/flutter/widgets/ListView-class.html
class History extends StatefulWidget {
  final TodayDiet diet;

  const History({super.key, required this.diet});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool isSelectionMode = false;
  late List<bool> _selected;

  _HistoryState();

  @override
  Widget build(BuildContext context) {
    TodayDiet diet = widget.diet;
    _selected = List<bool>.generate(diet.meals.length, (_) => false);
    return Scaffold(  
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('history'),
        leading: isSelectionMode
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        isSelectionMode = false;
                      });
                    },
                  )
                : BackButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                )
      ),
      
      body: ListView.builder(
        itemCount: diet.meals.length,
        itemBuilder:(context, index) => ListTile(
          onTap: () {},
          title: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Spacer(),
                Text(diet.meals[index].name),
                Spacer(),
                Text(diet.meals[index].grams.toString()),
                Spacer(),
                Text(diet.meals[index].kcal.toString()),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Calandar extends StatelessWidget {
  const Calandar({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}