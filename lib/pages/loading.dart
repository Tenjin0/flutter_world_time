import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/word_time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  init() async {
    print("loading");
    await WorldTime.getAreas();
    print("areas");
    await WorldTime.getSelfLocation();
    print("location");
    if (this.mounted) {
      Navigator.pushReplacementNamed(context, '/home',
          arguments: WorldTime.self);
    }
  }

  @override
  void initState() {
    print("loading init");
    super.initState();
  }

  @override
  void dispose() {
    print("loading dispose");
    super.dispose();
  }

  changeLocal(String area, String location) async {
    print("changeLocal $area, $location");
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
