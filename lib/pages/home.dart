import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world_time/services/word_time.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Local local = WorldTime.defaultLocal();
  Timer? timer;
  int count = 0;
  DateTime? current;
  @override
  void initState() {
    super.initState();
    this.current = local.current();
    timer = Timer.periodic(Duration(seconds: 1), (aTimer) {
      setState(() {
        this.current = local.current();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var local = ModalRoute.of(context)!.settings.arguments;
    if (local != null) {
      this.local = local as Local;
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: [
              TextButton.icon(
                onPressed: () async {
                  Navigator.pushNamed(context, '/location',
                      arguments: this.local);
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
                    this.local.location,
                    style: TextStyle(
                      fontSize: 25.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                this.current != null
                    ? DateFormat.jm().format(this.current!)
                    : "",
                style: TextStyle(
                  fontSize: 50.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
