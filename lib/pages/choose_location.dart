import 'package:flutter/material.dart';
import 'package:world_time/services/word_time.dart';

import 'package:world_time/widget/searchList.dart';

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
    final String area = ModalRoute.of(context)!.settings.arguments as String;

    final List<String> locations = WorldTime.getLocations(area);

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(
                  context,
                  '/area',
                );
              },
              icon: Icon(Icons.shopping_cart),
              tooltip: 'Change area',
            )
          ],
          title: Text('Choose a location'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SearchList(
          locations: locations,
          hintText: 'Location name',
          onTap: (String location) {
            print(location);
            Navigator.popAndPushNamed(context, '/',
                arguments: [area, location].toList());
          },
        ));
  }
}
