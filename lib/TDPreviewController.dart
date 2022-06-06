import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:hello_tooth/camera_preview.dart';

typedef PreviewDidTap = void Function();

class TDPreviewController {
  final MethodChannel channel;
  final CameraPreviewState _previewState;

  PreviewDidTap? viewDidTap;

  TDPreviewController._(
    this.channel,
    this._previewState,
  ) {
    channel.setMethodCallHandler(_handleMethodCall);
  }

  // * 构造
  static Future<TDPreviewController> init(
    int id,
    CameraPreviewState previewState,
  ) async {
    final MethodChannel channel = MethodChannel('preview_$id');
    return TDPreviewController._(channel, previewState);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'preview#viewDidTap':
        if (viewDidTap != null) {
          viewDidTap!();
        }
        break;
    }
  }

  Future<String?> getPlatformVersion() async {
    final Map? responseData = await channel.invokeMapMethod(
      'preview#getPlatformVersion',
    );
    if (responseData == null) {
      return null;
    }
    int code = responseData["code"];
    if (code == 0) {
      Map data = responseData["data"];
      String version = data["version"];
      return version;
    } else {
      return null;
    }
  }

  Future<bool> setPlainText({String plainText = "江月和人初见月,江月何年初照人"}) async {
    final Map data = await channel.invokeMethod(
      'preview#setPlainText',
      {"plainText": plainText},
    );

    int code = data["code"];
    if (code == 0) {
      return true;
    } else {
      return false;
    }
  }
}
