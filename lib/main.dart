import 'package:flutter/material.dart';
import 'package:select_search_sheet/search_multiple_sheet.dart';
import 'package:select_search_sheet/search_single_sheet.dart';

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
  String selectedName = "apple";

  void onSingleSearchSelected(String selectedName) {
    setState(() {
      print("onSingleSearchSelected ->$selectedName");
      this.selectedName = selectedName;
    });
  }

  List selectedList = ["banana"];

  void onMultiSearchSelected(List selectedList) {
    setState(() {
      print("onMultiSearchSelected ->$selectedList");
      this.selectedList = selectedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Single sheet',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () async {
                      SearchSingleSelectSheet(
                              searchList: list,
                              context: context,
                              selectedValue: selectedName,
                              onSearchSelected: onSingleSearchSelected)
                          .showSheet();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              selectedName,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down_rounded)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Mutiple Select sheet',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () async {
                      SearchMultipleSelectSheet(
                              searchList: list,
                              context: context,
                              selectedValue: selectedList,
                              onSearchSelected: onMultiSearchSelected)
                          .showSheet();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0; i < selectedList.length; i++)
                                  Text(
                                    selectedList[i].toString(),
                                  ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down_rounded)
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
