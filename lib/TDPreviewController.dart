import 'package:flutter/services.dart';
import 'package:hello_tooth/camera_preview.dart';
import 'package:hello_tooth/models/task_apis.dart';

const toothDoctorCallMethod = "tooth_doctor_call_method";

typedef PreviewDidReceiveRequest = TaskResult? Function(TaskApi api);

class TDPreviewController {
  final MethodChannel channel;
  final CameraPreviewState _previewState;

  // * 收到请求
  PreviewDidReceiveRequest? receiveRequest;

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
      case toothDoctorCallMethod:
        Map arguments = call.arguments;
        String method = arguments["method"];
        Map<String, dynamic>? params = arguments["params"];
        TaskApi api = TaskApi(method, params);

        if (receiveRequest != null) {
          return receiveRequest!(api);
        }
        break;
    }
  }

  Future<TaskResult> doCallMethod(TaskApi api) async {
    final Map? responseData =
        await channel.invokeMapMethod(toothDoctorCallMethod, api.toJson());
    if (responseData == null) {
      return const TaskResult(9527, '错误,无响应', null);
    }
    int code = responseData["code"];
    String? message = responseData["message"];
    dynamic data = responseData["data"];

    TaskResult result = TaskResult(code, message, data);
    return result;
  }
}
