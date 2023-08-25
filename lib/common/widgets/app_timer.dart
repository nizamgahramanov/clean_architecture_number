import 'dart:async';

import 'package:flutter/cupertino.dart';

class AppTimer {
  Timer? _timer;
  DateTime? _loginTime;

  void startTimer() {
    _loginTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      // Update UI with the elapsed time if needed
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
      // Calculate the time spent using _loginTime
      Duration timeSpent = DateTime.now().difference(_loginTime!);
      debugPrint("Timer " +_timer.toString());
      debugPrint("Time Spent " + timeSpent.toString());
      debugPrint("Login Timer " +_loginTime.toString());
      // Call your API request function here with timeSpent
    }
  }
}
