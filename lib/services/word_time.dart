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
  int offset;

  Local(this.area, this.location, this.offset);

  @override
  String toString() {
    return 'Local: {area: ${this.area}, location: ${this.location}, utc_offset: ${this.offset}}';
  }

  DateTime current() {
    DateTime today = DateTime.now();

    return today.toUtc().add(Duration(seconds: this.offset));
  }

  List<String> getLocations() {
    return WorldTime.areas[this.area] ?? [];
  }

  set setArea(String area) {
    if (WorldTime.areas[area]!.isNotEmpty) {
      if (this.area != area) {
        this.location = WorldTime.areas[area]!.first;
      }
      this.area = area;
    }
  }

  setLocation(String location) async {
    this.location = location;

    await WorldTime.getOffSet(this.area, this.location);
  }

  set setOffset(int offset) {
    this.offset = offset;
  }
}

class WorldTime {
  static Map<String, List<String>> areas = new Map();
  static Local? self;

  static defaultLocal() {
    return Local("Europe", 'Paris', 0);
  }

  static List<String> getLocations(String area) {
    return WorldTime.areas[area] as List<String>;
  }

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

  static Future<int> getOffSet(String area, String location) async {
    var url = Uri.parse('http://worldtimeapi.org/api/timezone/$area/$location');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['raw_offset'] + data['dst_offset'];
  }

  static getSelfLocation() async {
    var url = Uri.parse('http://worldtimeapi.org/api/ip');
    var response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);
    var result = data['timezone'].split('/');

    WorldTime.self =
        Local(result[0], result[1], data['raw_offset'] + data['dst_offset']);

    return WorldTime.self;
  }
}
