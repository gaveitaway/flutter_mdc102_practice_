import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';
import 'login.dart';
import 'model/products_repository.dart';
import 'model/product.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, this.restorationId}) : super(key: key);
  final String? restorationId;
  @override
  _SearchPageState createState() => _SearchPageState();
}

bool isExpanded = false;
List<bool> ListExpanded = [false, false, false];
List<String> checkList = ['No Kids Zone', 'Pet- Friendly', 'free break fast'];

class _SearchPageState extends State<SearchPage> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;
  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021, 1, 1),
          lastDate: DateTime(2022, 9, 9),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(_restorableDatePickerRouteFuture,
        'date_selectDate_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.year}/${_selectedDate.value.month}/${_selectedDate.value.day}'),
        ));
      });
    }
  }

  List<String> dayData = ["dummy", "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(110.0, 8.0, 8.0, 8.0),
          child: Text('Search'),
        ),
      ),
      floatingActionButton: searchButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 60, 0),
                child: Text('Filter'),
              ),
              SingleChildScrollView(
                child: Container(
                  width: 300,
                  child: ExpansionPanelList(
                    expansionCallback: (int index, bool expanded) {
                      setState(() {
                        print(expanded);
                        isExpanded = !expanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text("select filters"),
                          );
                        },
                        body: Container(
                          height: 150,
                          child: ListView(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          ListExpanded[0] =
                                              ListExpanded[0] ? false : true;
                                        });
                                      },
                                      icon: ListExpanded[0]
                                          ? Icon(Icons.check_box)
                                          : Icon(Icons.check_box_outline_blank),
                                    ),
                                    Text("NO kids Zone"),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          ListExpanded[1] =
                                              ListExpanded[1] ? false : true;
                                        });
                                      },
                                      icon: ListExpanded[1]
                                          ? Icon(Icons.check_box)
                                          : Icon(Icons.check_box_outline_blank),
                                    ),
                                    Text("Pet-Friendly"),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          ListExpanded[2] =
                                              ListExpanded[2] ? false : true;
                                        });
                                      },
                                      icon: ListExpanded[2]
                                          ? Icon(Icons.check_box)
                                          : Icon(Icons.check_box_outline_blank),
                                    ),
                                    Text("Free breakfast"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        isExpanded: isExpanded,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 30),
                          Text('Check-in'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(150, 20, 0, 0),
                        child: OutlinedButton(
                          onPressed: () {
                            _restorableDatePickerRouteFuture.present();
                          },
                          child: const Text('Select date'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Text(
                      ' ${_selectedDate.value.year}.${_selectedDate.value.month}.${_selectedDate.value.day}(${dayData[_selectedDate.value.weekday]})\n 9:30 am'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget searchButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: OutlinedButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Padding(
              padding: const EdgeInsets.all(0),
              child: Stack(children: <Widget>[
                Container(
                  width: 300,
                  height: 50,
                  color: Colors.blue,
                ),
                Column(
                  children: [
                    Container(child: const Text('Please check')),
                    Container(
                        child: const Text('your choice :)')),
                  ],
                ),
              ]),
            ),
            content: Column(
              children: [
                Column(
                    children : [
                      ListExpanded[0]? Text(checkList[0]): Text(""),
                      ListExpanded[1]? Text(checkList[1]): Text(""),
                      ListExpanded[2]? Text(checkList[2]): Text(""),
                    ]
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_today),
                    Text(
                        'IN ${_selectedDate.value.year}.${_selectedDate.value.month}.${_selectedDate.value.day}(${dayData[_selectedDate.value.weekday]})'),
                  ],
                ),

              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
        child: const Text('Search'),
      ),
    );
  }
}
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[0].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
