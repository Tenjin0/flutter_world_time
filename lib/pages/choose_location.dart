import 'package:flutter/material.dart';
import 'package:world_time/services/word_time.dart';

import 'package:world_time/helpers/searchList.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Local local = WorldTime.defaultLocal();

    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.arguments != null) {
      local = (ModalRoute.of(context)!.settings.arguments as Local);
    }

    List<String> locations = local.getLocations();

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          actions: [],
          title: Text('Choose a location'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SearchList(
          local: local,
          locations: locations,
        ));
  }
}
