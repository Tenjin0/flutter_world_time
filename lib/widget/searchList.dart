import 'package:flutter/material.dart';
import 'package:world_time/services/word_time.dart';

// https://www.youtube.com/watch?v=oFZIwBudIj0
class SearchList extends StatefulWidget {
  const SearchList(
      {Key? key,
      // required this.local,
      required this.locations,
      required this.hintText,
      required this.onTap})
      : super(key: key);

  // final Local local;
  final List<String> locations;
  final String hintText;
  final Function onTap;

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final searchListController = TextEditingController();
  String query = '';
  String hintText = '';
  List<String> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      filteredLocations = widget.locations;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchListController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = query.isEmpty ? styleHint : styleActive;

    return Column(
      children: [
        Container(
          height: 42,
          margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(color: Colors.black26),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (String value) {
              if (value.length > 0) {
                setState(() {
                  filteredLocations = this
                      .widget
                      .locations
                      .where((location) => location.contains(value))
                      .toList();
                });
              } else {
                setState(() {
                  filteredLocations = this.widget.locations;
                });
              }
            },
            controller: searchListController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(-8, 16, 0, 16),
              border: InputBorder.none,
              icon: Icon(
                Icons.search,
                color: style.color,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: this.filteredLocations.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                    title: Text(this.filteredLocations[index]),
                    onTap: () {
                      this.widget.onTap(this.filteredLocations[index]);
                    }),
              );
            },
          ),
        )
      ],
    );
  }
}
