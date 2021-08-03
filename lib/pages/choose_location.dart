import 'package:flutter/material.dart';

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
    print("build");
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [],
        title: Text('Choose a location'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Text('choose location screen'),
    );
  }
}
