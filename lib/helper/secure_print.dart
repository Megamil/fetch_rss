import 'package:flutter/foundation.dart';

class SecurePrint {

  static log(Object? msg) {
    if (kDebugMode) {
      print(msg);
    }
  }

}