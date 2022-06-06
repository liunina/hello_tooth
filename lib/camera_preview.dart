import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_tooth/TDPreviewController.dart';

typedef PreviewCreatedCallback = void Function(TDPreviewController controller);

class CameraPreview extends StatefulWidget {
  final String plainText;
  final PreviewCreatedCallback onViewCreated;

  const CameraPreview(
      {super.key, required this.plainText, required this.onViewCreated});

  @override
  State<CameraPreview> createState() => CameraPreviewState();
}

class CameraPreviewState extends State<CameraPreview> {
  final Completer<TDPreviewController> _controller =
      Completer<TDPreviewController>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{
      'plainText': widget.plainText,
    };

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        // 视图类型，作为唯一标识符
        viewType: "hello_tooth",
        // 创建参数：将会传递给 iOS 端侧, 可以传递任意类型参数
        creationParams: creationParams,
        // 用于将creationParams编码后再发送到平台端。
        // 这里使用Flutter标准二进制编码
        creationParamsCodec: const StandardMessageCodec(),
        // 原生视图创建回调
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text('$defaultTargetPlatform is not yet supported');
  }

  /// 原生视图创建回调操作
  /// id 是原生视图唯一标识符
  Future<void> _onPlatformViewCreated(int id) async {
    final TDPreviewController controller =
        await TDPreviewController.init(id, this);
    _controller.complete(controller);
    widget.onViewCreated(controller);
  }
}
