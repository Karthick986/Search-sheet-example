import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SearchSheet extends StatefulWidget {
  List searchList = [];
  BuildContext context;
  Color? color;
  Color? selectedColor;
  bool? showSearchIcon;
  double? height;
  Function onSearchSelected;
  String selectedValue;
  bool? autoFocus;
  bool? isSearchable;
  bool? showHeaderText;
  String? searchHintText;
  String? headerText;
  bool? showRadioButton;
  Color? radioActiveColor;
  TextStyle? searchTextStyle;
  TextStyle? headerTextStyle;

  SearchSheet(
      {Key? key,
      required this.searchList,
      required this.context,
      this.color = Colors.white,
      this.height,
      this.showSearchIcon,
      this.autoFocus,
      required this.onSearchSelected,
      this.isSearchable,
      this.selectedColor,
      this.showRadioButton,
      this.radioActiveColor,
      this.searchTextStyle,
      this.headerText,
      this.headerTextStyle,
      this.showHeaderText,
      required this.selectedValue,
      this.searchHintText})
      : super(key: key);

  showSheet() async {
    await showModalBottomSheet(
        context: context,
        // backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            color: color,
            child: SearchSheet(
              searchList: searchList,
              context: context,
              onSearchSelected: onSearchSelected,
              color: color,
              height: height,
              showSearchIcon: showSearchIcon,
              selectedValue: selectedValue,
              autoFocus: autoFocus,
              showRadioButton: showRadioButton,
              selectedColor: selectedColor,
              isSearchable: isSearchable,
              searchHintText: searchHintText,
              radioActiveColor: radioActiveColor,
              searchTextStyle: searchTextStyle,
              headerTextStyle: headerTextStyle,
              showHeaderText: showHeaderText,
              headerText: headerText,
            ),
            height: height ?? MediaQuery.of(context).size.height / 1.5,
          );
        });
  }

  @override
  _SearchSheetState createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  bool isFilterOnOff = false;
  List searchList = [];
  Object? groupValue;

  TextEditingController _etSearch = TextEditingController();

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
    groupValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Visibility(
        visible: widget.showHeaderText==null ? false : widget.showHeaderText!,
          child: Column(
            children: [
              const SizedBox(height: 12,),
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
                  prefixIcon:
                      widget.showSearchIcon == null
                          ? widget.showSearchIcon == null ? const Icon(
                              Icons.search_rounded,
                            )
                          : null : null,
                  suffixIcon: (_etSearch.text == '')
                      ? null
                      : InkWell(
                          onTap: () {
                            setState(() {
                              _etSearch = TextEditingController(text: '');
                              _searchFilter();
                            });
                          },
                          child: const Icon(Icons.close, size: 20)),
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
            ? ListView(
                shrinkWrap: true,
                children: searchList
                    .toSet()
                    .map(
                      (data) => InkWell(
                        onTap: () {
                          widget.onSearchSelected(data);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: widget.showRadioButton==null ?
                          const EdgeInsets.all(16) : widget.showRadioButton! ?
                          EdgeInsets.zero : EdgeInsets.zero,
                          color: widget.selectedValue == data
                              ? widget.selectedColor == null
                                  ? Colors.grey[300]
                                  : widget.selectedColor!
                              : null,
                          child: Row(
                            children: <Widget>[
                              widget.showRadioButton != null
                                  ? widget.showRadioButton!
                                      ? Radio(
                                          groupValue: groupValue,
                                          activeColor:
                                              widget.radioActiveColor == null
                                                  ? null
                                                  : widget.radioActiveColor!,
                                          value: data.toString(),
                                          onChanged: (index) {
                                            setState(() {
                                              groupValue = index!;
                                            });
                                            widget.onSearchSelected(
                                                data.toString());
                                            Navigator.pop(context);
                                          },
                                        )
                                      : Container()
                                  : Container(),
                              Text(data.toString(),
                                  style: widget.searchTextStyle),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            : ListView(
                shrinkWrap: true,
                children: widget.searchList
                    .toSet()
                    .map(
                      (data) => InkWell(
                        onTap: () {
                          widget.onSearchSelected(data);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: widget.showRadioButton==null ?
                          const EdgeInsets.all(16) : widget.showRadioButton! ?
                          EdgeInsets.zero : EdgeInsets.zero,
                          color: widget.selectedValue == data
                              ? widget.selectedColor == null
                                  ? Colors.grey[300]
                                  : widget.selectedColor!
                              : null,
                          child: Row(
                            children: <Widget>[
                              widget.showRadioButton != null
                                  ? widget.showRadioButton!
                                      ? Radio(
                                          groupValue: groupValue,
                                          activeColor:
                                              widget.radioActiveColor == null
                                                  ? null
                                                  : widget.radioActiveColor!,
                                          value: data.toString(),
                                          onChanged: (index) {
                                            setState(() {
                                              groupValue = index!;
                                            });
                                            widget.onSearchSelected(
                                                data.toString());
                                            Navigator.pop(context);
                                          },
                                        )
                                      : Container()
                                  : Container(),
                              Text(data.toString(),
                                  style: widget.searchTextStyle),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    ]);
  }
}
