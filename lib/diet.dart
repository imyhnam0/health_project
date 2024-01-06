import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/today.dart';

class DietMenu extends StatefulWidget{
  const DietMenu({super.key});

  @override
  State<DietMenu> createState() => _DietMenuState();
}

class _DietMenuState extends State<DietMenu> {
  Diet diet = Diet();

  @override
  void initState() {
    super.initState();
    _initiate();
  }

  Future<void> _initiate() async {
    //dietHistory = Diet.json(jsonDecode(await file.readAsString()));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('diet'),
        leading: BackButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                )
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodayMenu(diet: diet))
                );
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => History(diet: diet))
                  );
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
              child: const Text('달력', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Calandar(diet: diet))
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TodayMenu extends StatefulWidget {
  final Diet diet;
  final String? name;
  final int? gram, kcal;
  const TodayMenu({super.key, required this.diet, this.name, this.gram, this.kcal});

  @override
  State<TodayMenu> createState() => _TodayMenuState();
}

class _TodayMenuState extends State<TodayMenu> {
  _TodayMenuState();

  final nameCtrl = TextEditingController();
  final gramCtrl = TextEditingController();
  final kcalCtrl = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    nameCtrl.text = widget.name ?? '';
    gramCtrl.text = widget.gram?.toString() ?? '';
    kcalCtrl.text = widget.kcal?.toString() ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
    gramCtrl.dispose();
    kcalCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var diet = widget.diet;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Today Diet'),
        leading: BackButton(onPressed: () {Navigator.pop(context);},)
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
              child: const Icon(Icons.add),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => History(diet: diet))
          );
        },
        tooltip: 'Home menu',
        child: const Icon(Icons.bookmark),
      ),
    );
  }
}

// 다음 페이지의 sample code에 따라 수정할 것
//https://api.flutter.dev/flutter/widgets/ListView-class.html
class History extends StatefulWidget {
  final Diet diet;
  final DateTimeRange? dateRange;

  const History({super.key, required this.diet, this.dateRange});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool isSelectionMode = false;
  bool? totalCheck;
  late List<bool> _selected;
  late Diet _selectedDiet;

  _HistoryState();

  @override
  void initState() {
    super.initState();
    _selectedDiet = widget.dateRange == null ? widget.diet : widget.diet.dietOnDateRange(widget.dateRange!);
    setSelection(false, _selectedDiet);
  }

  void setSelection(bool selected, Diet diet) {
    _selected = List<bool>.generate(diet.meals.length, (_) => selected);
  }

  void _toggle(int index) {
    setState(() {
      _selected[index] = !_selected[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selected.isNotEmpty) totalCheck = null;
    for (var element in _selected) {
      if(element != totalCheck) totalCheck = totalCheck == null ? element : null;
    }
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
                        setSelection(false, _selectedDiet);
                      });
                    },
                  )
                : BackButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
        actions: isSelectionMode
                  ? [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          for(int i = _selected.length-1; i >= 0 ; i--) {
                            if(_selected[i]) {
                              if(widget.dateRange != null)widget.diet.delFood(_selectedDiet.meals[i]);
                              _selectedDiet.delFoodByIndex(i);
                            }
                          }
                          setSelection(false, _selectedDiet);
                        });
                      },
                    ),
                    Checkbox(
                      value: totalCheck, 
                      tristate: true,
                      onChanged: (value) {
                        setState(() {
                          totalCheck = value ?? false;
                          setSelection(value ?? false, _selectedDiet);
                        });
                      }
                    ),
                    const SizedBox(width: 24,)
                  ] 
                  : [const SizedBox.shrink()],
      ),
      
      body: ListView.builder(
        itemCount: _selectedDiet.meals.length,
        itemBuilder:(context, index) => ListTile(
          onTap: () {
            if(isSelectionMode) {_toggle(index);}
          },
          onLongPress: () {
            if (!isSelectionMode) {
              setState(() {
                isSelectionMode = true;
                _selected[index] = true;
              });
            }
          },
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
                Text(_selectedDiet.meals[index].name),
                Spacer(),
                Text(_selectedDiet.meals[index].grams.toString()),
                Spacer(),
                Text(_selectedDiet.meals[index].kcal.toString()),
                Spacer(),
              ],
            ),
          ),
          trailing: isSelectionMode
                  ? Checkbox(
                      value: _selected[index],
                      onChanged: (bool? x) {_toggle(index);},
                    )
                  : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => TodayMenu(
                          diet : _selectedDiet,
                          name : _selectedDiet.meals[index].name,
                          gram : _selectedDiet.meals[index].grams,
                          kcal : _selectedDiet.meals[index].kcal
                        ))
                      );
                    },
                  ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Calandar(diet: _selectedDiet))
          );
        },
        tooltip: 'Home menu',
        child: const Icon(Icons.calendar_month_outlined),
      ),
    );
  }
}

class Calandar extends StatefulWidget {
  final Diet diet;

  const Calandar({super.key, required this.diet});

  @override
  State<Calandar> createState() => _CalandarState();
}

class _CalandarState extends State<Calandar> {
  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now(), 
    end: DateTime.now()
  );

  String showDate(DateTimeRange dateRange) {
    return '${dateRange.start.year}.${dateRange.start.month}.${dateRange.start.day} ~ '
      '${dateRange.end.year}.${dateRange.end.month}.${dateRange.end.day}'
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calandar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected date range is : ${showDate(_selectedDateRange)}', style: const TextStyle(fontSize: 18)),
            ElevatedButton(
              onPressed: () async {
                _selectedDateRange = await showDateRangePicker(
                  context: context,
                  currentDate: DateTime.now(),
                  firstDate: DateTime(2021), 
                  lastDate: DateTime.now()
                ) ?? _selectedDateRange;
                setState(() {});
              },
              child: const Text('choose'),
            ),
            const SizedBox(height: 80),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                fixedSize: const Size(300, 100),
              ),
              child: const Text('show diet in range', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => History(diet: widget.diet, dateRange: _selectedDateRange,))
                  );
              },
            ),
          ]
        ),
      ),
    );
  }
}