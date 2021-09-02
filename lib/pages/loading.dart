import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/word_time.dart';

class Loading extends StatefulWidget {
  bool hasConnection = false;
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  init() async {
    await WorldTime.getAreas();
    await WorldTime.getSelfLocation();
    if (this.mounted) {
      Navigator.pushReplacementNamed(context, '/home',
          arguments: WorldTime.self);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  changeLocal(String area, String location) async {
    try {
      int offset = await WorldTime.getOffSet(area, location);
      print('$offset');
      Navigator.pushReplacementNamed(context, '/home',
          arguments: Local(area, location, offset));
    } catch (e) {
      print(e);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.arguments != null) {
      print(ModalRoute.of(context)!.settings.arguments);
      List<String>? result =
          ModalRoute.of(context)!.settings.arguments as List<String>?;
      if (result != null) {
        changeLocal(result[0], result[1]);
      }
    } else {
      init();
    }
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
