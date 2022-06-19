import 'package:flutter/material.dart';
import 'package:select_search_sheet/search_sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Sheet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Search Sheet Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List list = [
    "apple",
    "banana",
    "cat",
    "dog",
    "apple",
    "banana",
    "cat",
    "dog",
    "apple",
    "banana",
    "cat",
    "dog",
    "apple",
    "banana",
    "cat",
    "dog",
    "apple",
    "banana",
    "cat",
    "dog",
    "apple",
    "banana",
    "cat",
    "dog",
  ];
  String searchName = "";

  void onSearchSelected(String searchName) {
    setState(() {
      print("onSearchSelected ->$searchName");
      this.searchName = searchName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Course',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () async {
                      SearchSheet(
                              searchList: list,
                              context: context,
                              selectedValue: searchName,
                              onSearchSelected: onSearchSelected)
                          .showSheet();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            searchName,
                          ),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
