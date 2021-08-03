import 'package:flutter/material.dart';
import 'package:world_time/services/word_time.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Local? local = Local("Europe", 'Paris', "+02:00");

  @override
  Widget build(BuildContext context) {
    this.local = ModalRoute.of(context)!.settings.arguments as Local?;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/location');
              },
              icon: Icon(Icons.edit_location),
              label: Text('edit location'),
            ),
            SizedBox(height: 20),
            Row(
              children: [Text(local!.area)],
            )
          ],
        ),
      ),
    );
  }
}
