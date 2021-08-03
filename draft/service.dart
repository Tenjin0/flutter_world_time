import "package:world_time/services/word_time.dart";

main() async {
  var selfLocation = await WorldTime.getSelfLocation();
  print(selfLocation.toString());
}
