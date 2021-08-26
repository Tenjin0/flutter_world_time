import 'package:flutter/material.dart';
import 'package:world_time/services/word_time.dart';

import 'package:world_time/widget/searchList.dart';

class ChooseArea extends StatefulWidget {
  @override
  _ChooseAreaState createState() => _ChooseAreaState();
}

class _ChooseAreaState extends State<ChooseArea> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Choose an Area'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SearchList(
        locations: WorldTime.areas.keys.toList(),
        hintText: 'Area name',
        onTap: (ressource) {
          print(ressource);
          Navigator.popAndPushNamed(context, '/location', arguments: ressource);
        },
      ),
    );
  }
}
