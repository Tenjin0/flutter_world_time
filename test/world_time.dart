import 'package:world_time/services/word_time.dart';

main(List<String> args) async {
  await WorldTime.getAreas();

  print(WorldTime.areas.keys);
  // WorldTime service = WorldTime();
}

// WorldTime.getAreas();