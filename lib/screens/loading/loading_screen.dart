import 'package:flutter/material.dart';
import 'package:go/screens/loading/loading_screen_controller.dart';
import 'package:go/screens/loading/loading_strings.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();

  static final LoadingScreen _shared = LoadingScreen._sharedInstance();

  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = LoadingStrings.loading,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      //show overlay
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController? showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final state = Overlay.of(context);
    if (state == null) {
      return null;
    }
  }
}
