import 'package:flutter/material.dart';
import 'package:world_time/services/word_time.dart';

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
    var local = ModalRoute.of(context)!.settings.arguments as Local;
    List<String> locations = local.getLocations();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [],
        title: Text('Choose a location'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: WorldTime.areas[local.area]!.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(locations[index]),
              onTap: () async {
                Navigator.popAndPushNamed(context, '/',
                    arguments: [local.area, locations[index]]);
              },
            ),
          );
        },
      ),
    );
  }
}
