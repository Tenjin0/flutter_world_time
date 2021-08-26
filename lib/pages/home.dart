import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world_time/services/word_time.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Local? local;
  Timer? timer;
  int count = 0;
  DateTime? current;
  @override
  void initState() {
    if (this.local != null) {
      setState(() {
        this.current = local!.current();
      });
    }
    timer = Timer.periodic(Duration(seconds: 1), (aTimer) {
      if (this.local != null) {
        setState(() {
          this.current = local!.current();
        });
      }
    });
    print("home init");
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    print("home dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var local = ModalRoute.of(context)!.settings.arguments;
    if (local != null) {
      this.local = local as Local;
    }

    List<Widget> children = [
      TextButton.icon(
        onPressed: () async {
          // timer!.cancel();
          Navigator.pushNamed(context, '/location',
              arguments: this.local!.area);
        },
        icon: Icon(Icons.edit_location),
        label: Text(
          'edit location',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            this.local != null ? this.local!.location : "",
            style: TextStyle(
              fontSize: 25.0,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      Text(
        this.current != null ? DateFormat.jm().format(this.current!) : "",
        style: TextStyle(
          fontSize: 50.0,
        ),
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(children: children),
        ),
      ),
    );
  }
}
