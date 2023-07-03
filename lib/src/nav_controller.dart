import 'dart:async';

import 'package:flutter/animation.dart';

class NavController {
  ///keep current state for isExpended
  bool _expended = false;

  ///expended stream controller
  final _isExpended = StreamController<bool>();

  ///isExpended status open sheet or close sheet
  Stream<bool> get isExpended => _isExpended.stream;

  ///change isExpended value [isExpendedChange]
  void isExpendedChange(bool it) {
    _expended = it;
    _isExpended
      ..sink
      ..add(it);
  }

  ///revert isExpended to !isExpended
  void isExpendedRevert() {
    _isExpended
      ..sink
      ..add(!_expended);
  }

  ///animation controller
  late AnimationController controller;

  ///init animation controller
  setAnimationController(AnimationController controller) {
    this.controller = controller;
  }

  ///update current height tracking
  final _updateHeightController = StreamController<bool>();

  ///update height broadcast
  Stream<bool> get updateHeight => _updateHeightController.stream;

  ///update height func [updateHeight]
  void updateMaxHeight() {
    _updateHeightController
      ..sink
      ..add(true);
  }

  ///play animation forward [forward]
  void forward() {
    controller.forward(from: 0.0);
    isExpendedRevert();
    updateMaxHeight();
  }

  ///play animation reverse [reverse]
  void reverse() {
    controller.reverse();
    _isExpended
      ..sink
      ..add(false);
  }

  ///close all stream controller
  ///and animation controller
  void dispose() {
    _isExpended.close();
    controller.dispose();
    _updateHeightController.close();
  }
}
