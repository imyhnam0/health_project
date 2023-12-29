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
  var selectedIndex = 0;
  final title = 'diet';

  @override
  Widget build(BuildContext context) {
    
    Widget repeatedButton(BuildContext context, int pageNum, String name) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          fixedSize: const Size(300, 100),
        ),
        child: Text(name,
          style: const TextStyle(fontSize: 18),
        ),
        onPressed: () {
          setState(() {
            selectedIndex = pageNum;
          });
        },
      );
    }

    Function(BuildContext) page;
    Function(BuildContext) floatButton;
    switch(selectedIndex) {
      case 0:
        page = (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              repeatedButton(context, 1, '오늘 식단'),
              const SizedBox(height: 80),
              repeatedButton(context, 2, '즐겨찾기'),
              const SizedBox(height: 80),
              repeatedButton(context, 3, '달력'),
            ],
          ),
        );
        floatButton = (context) => FloatingActionButton(
          onPressed: () {Navigator.pop(context);},
          tooltip: 'Home Menu',
          child: const Icon(Icons.home)
        );
        break;
      case 1:
        page = (context) => const TodayMenu();
        floatButton = (context) => FloatingActionButton(
          onPressed: () {
            setState(() {
              selectedIndex = 0;
            });
          },
          tooltip: 'Diet Menu',
          child: const Icon(Icons.menu)
        );
      case 2:
        page = (context) => const History();
        floatButton = (context) => FloatingActionButton(
          onPressed: () {
            setState(() {
              selectedIndex = 0;
            });
          },
          tooltip: 'Diet Menu',
          child: const Icon(Icons.menu)
        );
      case 3:
        page = (context) => const Calandar();
        floatButton = (context) => FloatingActionButton(
          onPressed: () {
            setState(() {
              selectedIndex = 0;
            });
          },
          tooltip: 'Diet Menu',
          child: const Icon(Icons.menu)
        );
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return ChangeNotifierProvider(
      create: (context) => TodayDiet(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: page(context),
        floatingActionButton: floatButton(context)
      )
    );
  }
}

class TodayMenu extends StatefulWidget {
  const TodayMenu({super.key});

  @override
  State<TodayMenu> createState() => _TodayMenuState();
}

class _TodayMenuState extends State<TodayMenu> {
  final nameCtrl = TextEditingController();
  final gramCtrl = TextEditingController();
  final kcalCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var meals = context.watch<TodayDiet>();

    return Center(
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
                );
                if(!result) return;
              }
              meals.addInfo(
                Meal(
                  gramCtrl.text, 
                  int.parse(gramCtrl.text.isEmpty ? '0' : gramCtrl.text), 
                  int.parse(kcalCtrl.text.isEmpty ? '0' : kcalCtrl.text)
                )
              );
            },
            child: const Text('Add'),
          ),
        ],
      )
    );
  }
}

// 다음 페이지의 sample code에 따라 수정할 것
// https://api.flutter.dev/flutter/widgets/ListView-class.html
class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final meals = context.watch<TodayDiet>();
    return Placeholder();
  }
}

class Calandar extends StatelessWidget {
  const Calandar({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}