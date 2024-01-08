import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/today.dart';
import 'package:table_calendar/table_calendar.dart';

class DietMenu extends StatefulWidget{
  const DietMenu({super.key});

  @override
  State<DietMenu> createState() => _DietMenuState();
}

class _DietMenuState extends State<DietMenu> {
  final todayDiet = OneDayFoods();
  final bookmarks = BookmarkedFoods();
  final mealHistory = MealCollection();

  @override
  void initState() {
    super.initState();

    // hard coding for test
    todayDiet.addFood(Food('first', 100, 4));
    todayDiet.addFood(Food('second', 130, 20));
    bookmarks.addFood(Food('first', 100, 4));
    bookmarks.addFood(Food('second', 130, 20));
    mealHistory.add(OneDayFoods(name: 'first', foods: [Food('first', 100, 4)], date: DateTime(2024, 1, 5)));
    mealHistory.add(OneDayFoods(name: 'second', foods: [Food('second', 130, 20)], date: DateTime(2024, 1, 4)));
    
    mealHistory.add(todayDiet);
  }

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
            // 오늘의 식단
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                fixedSize: const Size(300, 100),
              ),
              child: const Text('오늘의 식단',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodayDietWidget(todayDiet: todayDiet, bookmarks: bookmarks,)),
                );
              },
            ),
            const SizedBox(height: 80),
            // 즐겨찾기
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookmarkWidget(todayDiet: todayDiet, bookmarks: bookmarks,)),
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
              child: const Text('달력',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarWidget(mealHistory: mealHistory, todayDiet: todayDiet,)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class TodayDietWidget extends StatefulWidget{
  const TodayDietWidget({super.key, required this.todayDiet, required this.bookmarks});
  final OneDayFoods todayDiet;
  final BookmarkedFoods bookmarks;

  @override
  State<TodayDietWidget> createState() => _TodayDietWidgetState();
}

class _TodayDietWidgetState extends State<TodayDietWidget> {
  final _todayName = TextEditingController();
  final List<TextEditingController> _nameCtrl = [];
  final List<TextEditingController> _gramCtrl = [];
  final List<TextEditingController> _kcalCtrl = [];
  List<Widget> textFieldRows = [];

  @override
  void initState() {
    super.initState();
    _todayName.text = widget.todayDiet.name;
    for(int index = 0; index < widget.todayDiet.foods.length; index++) {
      _nameCtrl.add(TextEditingController(text: widget.todayDiet.foods[index].name));
      _gramCtrl.add(TextEditingController(text: widget.todayDiet.foods[index].grams.toString()));
      _kcalCtrl.add(TextEditingController(text: widget.todayDiet.foods[index].kcal.toString()));
      textFieldRows.add(
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: 100,
                height: 100,
                child: TextField(
                  controller: _nameCtrl.last,
                  decoration: const InputDecoration(
                    labelText: 'Food Name: ',
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
                  controller: _gramCtrl.last,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Grams: ',
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
                  controller: _kcalCtrl.last,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Kcal: ',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 50,
              height: 100,
              child: Column(
                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                    },
                    icon: const Icon(Icons.delete)
                  ),
                  IconButton(
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        if (_nameCtrl[index].text == '') {
                          const AlertDialog(actions: [Text('please enter a name')],);
                          return;
                        }
                        widget.bookmarks.addFood(
                          Food(_nameCtrl[index].text, 
                          int.parse(_gramCtrl[index].text == '' ? '0' : _gramCtrl[index].text), 
                          int.parse(_kcalCtrl[index].text == '' ? '0' : _kcalCtrl[index].text)
                        ));
                      });
                    },
                    icon: const Icon(Icons.bookmark)
                  ),
                  const Spacer(),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('오늘의 식단'),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 50),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: TextField(
                    controller: _todayName,
                    decoration: const InputDecoration(
                      labelText: '식단 이름: ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: textFieldRows,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    fixedSize: const Size(60, 60),
                  ),
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _nameCtrl.add(TextEditingController());
                      _gramCtrl.add(TextEditingController());
                      _kcalCtrl.add(TextEditingController());
                      textFieldRows.add(
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: TextField(
                                  controller: _nameCtrl.last,
                                  decoration: const InputDecoration(
                                    labelText: 'Food Name: ',
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
                                  controller: _gramCtrl.last,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: const InputDecoration(
                                    labelText: 'Grams: ',
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
                                  controller: _kcalCtrl.last,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: const InputDecoration(
                                    labelText: 'Kcal: ',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_nameCtrl.last.text == '') {
                                    const AlertDialog(actions: [Text('please enter a name')],);
                                    return;
                                  }
                                  widget.bookmarks.addFood(
                                    Food(_nameCtrl.last.text, 
                                    int.parse(_gramCtrl.last.text == '' ? '0' : _gramCtrl.last.text), 
                                    int.parse(_kcalCtrl.last.text == '' ? '0' : _kcalCtrl.last.text)
                                  ));
                                });
                              },
                              icon: const Icon(Icons.bookmark)
                            )
                          ],
                        ),
                      );
                    });
                  },
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    fixedSize: const Size(60, 60),
                  ),
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    setState(() {
                      widget.todayDiet.name = _todayName.text;
                      widget.todayDiet.foods = [];
                      for(int i = 0; i < _nameCtrl.length; i++) {
                        if (_nameCtrl[i].text == '') {
                          continue;
                        }
                        widget.todayDiet.addFood(
                          Food(_nameCtrl[i].text, 
                          int.parse(_gramCtrl[i].text == '' ? '0' : _gramCtrl[i].text), 
                          int.parse(_kcalCtrl[i].text == '' ? '0' : _kcalCtrl[i].text)
                        ));
                      }
                    });
                  },
                )
              ],
            ),
          ),
          const Center(
            child: Column(
              children: [
                Text('note: 이름이 빈칸으로 된 식단은 저장되지 않습니다.'),
                Text('gram, Kcal를 비워두면 0으로 저장됩니다.'),
              ],
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookmarkWidget(todayDiet: widget.todayDiet, bookmarks: widget.bookmarks,))
          );
        },
        tooltip: '즐겨찾기',
        child: const Icon(Icons.bookmark),
      ),
    );
  }
}

class BookmarkWidget extends StatefulWidget{
  final BookmarkedFoods bookmarks;
  final OneDayFoods todayDiet;
  const BookmarkWidget({super.key, required this.todayDiet, required this.bookmarks});

  @override
  State<BookmarkWidget> createState() => _BookmarksState();
}

class _BookmarksState extends State<BookmarkWidget> {
  bool _isEditing = false;
  late List<bool> _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = List.filled(widget.bookmarks.foods.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('즐겨찾기'),
        leading: _isEditing
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                        _isSelected = List.filled(widget.bookmarks.foods.length, false);
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
        actions: _isEditing ? [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                for (var index = widget.bookmarks.foods.length-1; index >= 0; index--) {
                  if (_isSelected[index]) {
                    widget.bookmarks.delFoodByIndex(index);
                  }
                }
                _isEditing = false;
                _isSelected = List.filled(widget.bookmarks.foods.length, false);
              });
            },
          ),
        ] : [],
      ),
      body: _isEditing 
            ? DataTable(
              columns: const [
                DataColumn(label: Text('음식 이름')),
                DataColumn(label: Text('Kcal')),
                DataColumn(label: Text('Grams')),
              ],
              rows: [
                for (var index = 0; index < widget.bookmarks.foods.length; index++)
                  DataRow(
                    selected: _isSelected[index],
                    onSelectChanged: (bool? isSelected) {
                      setState(() {
                        _isSelected[index] = isSelected!;
                      });
                    },
                    cells: [
                      DataCell(
                        Text(widget.bookmarks.foods[index].name),
                      ),
                      DataCell(
                        Text(widget.bookmarks.foods[index].kcal.toString()),
                      ),
                      DataCell(
                        Text(widget.bookmarks.foods[index].grams.toString()),
                      ),
                    ],
                  ),
              ],
            )
            : DataTable(
              columns: const [
                DataColumn(label: Text('음식 이름')),
                DataColumn(label: Text('Kcal')),
                DataColumn(label: Text('Grams')),
                DataColumn(label: Text('오늘의 식단에 추가')),
              ],
              rows: [
                for (var index = 0; index < widget.bookmarks.foods.length; index++)
                  DataRow(
                    onLongPress: () {
                      setState(() {
                        _isEditing = true;
                        _isSelected[index] = true;
                      });
                    },
                    cells: [
                      DataCell(
                        Text(widget.bookmarks.foods[index].name),
                      ),
                      DataCell(
                        Text(widget.bookmarks.foods[index].kcal.toString()),
                      ),
                      DataCell(
                        Text(widget.bookmarks.foods[index].grams.toString()),
                      ),
                      DataCell(
                        IconButton(
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              widget.todayDiet.addFood(widget.bookmarks.foods[index]);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('추가되었습니다.')),
                              );
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      )
                    ],
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodayDietWidget(todayDiet: widget.todayDiet, bookmarks: widget.bookmarks,))
          );
        },
        tooltip: '오늘의 식단',
        child: const Icon(Icons.food_bank),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget{
  final MealCollection mealHistory;
  final OneDayFoods todayDiet;
  const CalendarWidget({super.key, required this.mealHistory, required this.todayDiet});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class Event {
  String title;

  Event(this.title);
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    OneDayFoods? mealOnSelectedDay = widget.mealHistory.get(_selectedDay);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('달력'),
      ),
      body: ListView(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.now(),
            focusedDay: _focusedDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            eventLoader: (day) {
              final mealForSelectedDay = widget.mealHistory.get(day);
              return mealForSelectedDay == null ? [] : [mealForSelectedDay.name];
            },
          ),
          const Divider(),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('선택된 날짜: ${_selectedDay.toString().substring(0, 10)}'),
                  mealOnSelectedDay != null 
                  ? Text('${mealOnSelectedDay.grams.toString()}g, ${mealOnSelectedDay.kcal.toString()}kcal') 
                  : const SizedBox.shrink(),
                ],
              )
            ),
          mealOnSelectedDay != null ?
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                for (var meal in mealOnSelectedDay.foods)
                  SizedBox(
                    width: 200,
                    child: ListTile(
                      leading: IconButton(icon: const Icon(Icons.add), onPressed: () {
                        setState(() {
                          widget.todayDiet.addFood(meal);
                        });
                      }),
                      title: Text(meal.name),
                      subtitle: Text('${meal.grams.toString()}g, ${meal.kcal.toString()}kcal'),
                    ),
                  ),
              ],
            ) : const SizedBox.shrink()
        ],
      ),
    );
  }
}