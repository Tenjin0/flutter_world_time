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

class Local {
  String area;
  String location;
  // ignore: non_constant_identifier_names
  String utc_offset;

  Local(this.area, this.location, this.utc_offset);

  @override
  String toString() {
    return 'Local: {area: ${this.area}, location: ${this.location}, utc_offset: ${this.utc_offset}}';
  }
}

class WorldTime {
  static Map<String, List<String>> areas = new Map();
  static Local? self;

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
    Map<String, dynamic> data = jsonDecode(response.body);

    var result = data['timezone'].split('/');

    WorldTime.self = Local(result[0], result[1], data['utc_offset']);

    return WorldTime.self;
  }
}
