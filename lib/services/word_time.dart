import 'dart:convert';

import 'package:http/http.dart' as http;

// class Area {
//   String name;
//   List<String> locations = [];

//   Area(this.name, List<String>? locations) {
//     if (locations != null) {
//       this.locations = locations;
//     }
//   }
// }

class WorldTime {
  static Map<String, List<String>> areas = new Map();

  static getAreas() async {
    var url = Uri.parse('http://worldtimeapi.org/api/timezone');
    var response = await http.get(url);
    List<dynamic> data = jsonDecode(response.body);
    for (var i = 0; i < data.length; i++) {
      String location = data[i];
      List<String> splitedLocation = location.split('/');
      if (splitedLocation.length >= 2) {
        String areaToTest = splitedLocation[0];
        if (areaToTest == 'Etc') {
          continue;
        }
        if (!WorldTime.areas.containsKey(areaToTest)) {
          WorldTime.areas[areaToTest] = [];
        }
        if (!WorldTime.areas[areaToTest]!.contains(splitedLocation[1])) {
          WorldTime.areas[areaToTest]!.add(splitedLocation[1]);
        }
      }
    }
  }

  static getSelfLocation() async {
    var url = Uri.parse('http://worldtimeapi.org/api/ip');
    var response = await http.get(url);
    List<dynamic> data = jsonDecode(response.body);
    for (var i = 0; i < data.length; i++) {
      String location = data[i];
      List<String> splitedLocation = location.split('/');
      if (splitedLocation.length >= 2) {
        String areaToTest = splitedLocation[0];
        if (areaToTest == 'Etc') {
          continue;
        }
        if (!WorldTime.areas.containsKey(areaToTest)) {
          WorldTime.areas[areaToTest] = [];
        }
        if (!WorldTime.areas[areaToTest]!.contains(splitedLocation[1])) {
          WorldTime.areas[areaToTest]!.add(splitedLocation[1]);
        }
      }
    }
  }
}
