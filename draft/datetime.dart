import 'dart:async';

main() {
  DateTime today = DateTime.now();

  today.add(Duration(hours: 2));

  Timer.periodic(Duration(seconds: 1), (timer) {
    DateTime today = DateTime.now();

    today = today.toUtc().add(Duration(seconds: 3600 - 18000));
    print(today);
  });
}
