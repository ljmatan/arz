import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class MainViewController {
  static StreamController<Widget>? _streamController;

  static void init() => _streamController = StreamController.broadcast();

  static Stream<Widget>? get stream => _streamController?.stream;

  static void change(value) => _streamController?.add(value);

  static void dispose() => _streamController?.close();
}
