import 'dart:async';

main() {
  print("test");

  int count = 0;

  var doStuffCallback = (timer) {
    count++;
    print(count);

    if (count >= 5) {
      timer.cancel();
      count = 0;
    }
  };
  Timer.periodic(const Duration(seconds: 1), doStuffCallback);
}
