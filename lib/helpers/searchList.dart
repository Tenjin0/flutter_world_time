import 'package:flutter/material.dart';
import 'package:world_time/services/word_time.dart';

// https://www.youtube.com/watch?v=oFZIwBudIj0
class SearchList extends StatefulWidget {
  const SearchList({
    required this.local,
    required this.locations,
  });

  final Local local;
  final List<String> locations;

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: myController,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: this.widget.locations.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(this.widget.locations[index]),
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/', arguments: [
                      this.widget.local.area,
                      this.widget.locations[index]
                    ]);
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
