import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/word_time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  init() async {
    await WorldTime.getAreas();

    await WorldTime.getSelfLocation();
    Navigator.pushReplacementNamed(context, '/home', arguments: WorldTime.self);
  }

  @override
  void initState() {
    super.initState();
    print("initstate");
  }

  changeLocal(String area, String location) async {
    var result = await WorldTime.getOffSet(area, location);
    print(result);
    int offset = await WorldTime.getOffSet(area, location);
    Navigator.pushReplacementNamed(context, '/home',
        arguments: Local(area, location, offset));
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
