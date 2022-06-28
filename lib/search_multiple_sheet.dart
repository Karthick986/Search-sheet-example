import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// ignore: must_be_immutable
class SearchMultipleSelectSheet extends StatefulWidget {
  List searchList = [];
  BuildContext context;
  Color? color;
  bool? showSearchIcon;
  double? height;
  Function onSearchSelected;
  List selectedValue;
  bool? autoFocus;
  bool? isSearchable;
  bool? showHeaderText;
  String? searchHintText;
  String? headerText;
  Color? checkboxActiveColor;
  TextStyle? searchTextStyle;
  TextStyle? headerTextStyle;
  TextStyle? applyButtonStyle;
  TextStyle? cancelButtonStyle;
  Color? buttonColor;

  SearchMultipleSelectSheet(
      {Key? key,
      required this.searchList,
      required this.context,
      this.color = Colors.white,
      this.height,
      this.showSearchIcon,
      this.autoFocus,
      required this.onSearchSelected,
      this.isSearchable,
      this.checkboxActiveColor,
      this.searchTextStyle,
      this.headerText,
      this.headerTextStyle,
      this.showHeaderText,
      required this.selectedValue,
      this.searchHintText,
      this.cancelButtonStyle,
        this.applyButtonStyle,
      this.buttonColor})
      : super(key: key);

  showSheet() async {
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            color: color,
            child: SearchMultipleSelectSheet(
                searchList: searchList.toSet().toList(),
                context: context,
                onSearchSelected: onSearchSelected,
                color: color,
                height: height,
                showSearchIcon: showSearchIcon,
                selectedValue: selectedValue.toSet().toList(),
                autoFocus: autoFocus,
                isSearchable: isSearchable,
                searchHintText: searchHintText,
                checkboxActiveColor: checkboxActiveColor,
                searchTextStyle: searchTextStyle,
                headerTextStyle: headerTextStyle,
                showHeaderText: showHeaderText,
                headerText: headerText,
                applyButtonStyle: applyButtonStyle,
                cancelButtonStyle: cancelButtonStyle,
                buttonColor: buttonColor),
            height: height ?? MediaQuery.of(context).size.height / 1.5,
          );
        });
  }

  @override
  _SearchMultipleSelectSheetState createState() =>
      _SearchMultipleSelectSheetState();
}

class _SearchMultipleSelectSheetState extends State<SearchMultipleSelectSheet> {
  bool isFilterOnOff = false;
  List searchList = [];
  List<bool> checkedValue = [];

  final TextEditingController _etSearch = TextEditingController();

  void _searchFilter() {
    if (_etSearch.text.isEmpty) {
      isFilterOnOff = false;
    } else {
      isFilterOnOff = true;
      searchList = widget.searchList
          .toSet()
          .where((data) =>
              data.toLowerCase().contains(_etSearch.text.toLowerCase()))
          .toList();
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.searchList = widget.searchList.toSet().toList();

    for (int i = 0; i < widget.searchList.length; i++) {
      checkedValue.add(false);
      if (widget.selectedValue.contains(widget.searchList[i])) {
        checkedValue[i] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Visibility(
          visible:
              widget.showHeaderText == null ? false : widget.showHeaderText!,
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                  widget.headerText == null
                      ? "Type Header Text"
                      : widget.headerText.toString(),
                  style: widget.headerTextStyle),
            ],
          )),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.isSearchable == null || widget.isSearchable!
            ? TextField(
                controller: _etSearch,
                autofocus: widget.autoFocus == null ? false : widget.autoFocus!,
                textInputAction: TextInputAction.search,
                onChanged: (textValue) {
                  _searchFilter();
                },
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: widget.showSearchIcon == null
                      ? widget.showSearchIcon == null
                          ? const Icon(
                              Icons.search_rounded,
                            )
                          : null
                      : null,
                  suffixIcon: (_etSearch.text == '')
                      ? null
                      : const Icon(Icons.close, size: 20),
                  isDense: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  filled: true,
                  hintText: widget.searchHintText == null
                      ? "Search"
                      : widget.searchHintText!,
                ),
              )
            : Container(),
      ),
      Expanded(
          child: isFilterOnOff
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: searchList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                checkedValue[index] = !checkedValue[index];
                                if (widget.selectedValue
                                    .contains(searchList[index])) {
                                  widget.selectedValue
                                      .remove(searchList[index]);
                                } else {
                                  widget.selectedValue.add(searchList[index]);
                                }
                              });
                              widget.onSearchSelected(widget.selectedValue);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    activeColor:
                                        widget.checkboxActiveColor == null
                                            ? null
                                            : widget.checkboxActiveColor!,
                                    value: checkedValue[index],
                                    onChanged: (value) {
                                      setState(() {
                                        checkedValue[index] = value!;
                                        if (widget.selectedValue
                                            .contains(searchList[index])) {
                                          widget.selectedValue
                                              .remove(searchList[index]);
                                        } else {
                                          widget.selectedValue
                                              .add(searchList[index]);
                                        }
                                      });
                                      widget.onSearchSelected(
                                          widget.selectedValue);
                                    },
                                  ),
                                  Text(searchList[index].toString(),
                                      style: widget.searchTextStyle),
                                ],
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child:
                                Text("Cancel", style: widget.cancelButtonStyle,)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Apply",
                                  style: widget.applyButtonStyle),
                              color: widget.buttonColor,
                              padding: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.searchList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                checkedValue[index] = !checkedValue[index];
                                if (widget.selectedValue
                                    .contains(widget.searchList[index])) {
                                  widget.selectedValue
                                      .remove(widget.searchList[index]);
                                } else {
                                  widget.selectedValue
                                      .add(widget.searchList[index]);
                                }
                              });
                              widget.onSearchSelected(widget.selectedValue);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    activeColor:
                                        widget.checkboxActiveColor == null
                                            ? null
                                            : widget.checkboxActiveColor!,
                                    value: checkedValue[index],
                                    onChanged: (value) {
                                      setState(() {
                                        checkedValue[index] = value!;
                                        if (widget.selectedValue.contains(
                                            widget.searchList[index])) {
                                          widget.selectedValue
                                              .remove(widget.searchList[index]);
                                        } else {
                                          widget.selectedValue
                                              .add(widget.searchList[index]);
                                        }
                                      });
                                    },
                                  ),
                                  Text(widget.searchList[index].toString(),
                                      style: widget.searchTextStyle),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child:
                                    Text("Cancel", style: widget.cancelButtonStyle,)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Apply",
                                  style: widget.applyButtonStyle),
                              color: widget.buttonColor,
                              padding: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
    ]);
  }
}
