class TaskApi {
  final String method;
  final Map<String, dynamic>? params;

  TaskApi(this.method, this.params);

  TaskApi._(
    this.method,
    this.params,
  ) {}

  // * from json
  factory TaskApi.fromJson(Map<String, dynamic> jsonMap) {
    final model = TaskApi(jsonMap["method"], jsonMap["params"]);
    return model;
  }

  // * to json
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["method"] = method;
    map["params"] = params;
    return map;
  }
}

class TaskResult {
  final int code;
  final String? message;
  final dynamic data;

  const TaskResult(this.code, this.message, this.data);

  //maping json data
  factory TaskResult.fromJson(Map<String, dynamic> jsonMap) {
    var data = jsonMap["data"] as dynamic;
    int code = int.parse(jsonMap["code"]);
    String message = jsonMap["message"];

    final model = TaskResult(code, message, data);
    return model;
  }

  // 业务是否成功
  bool success() {
    if (code == 0) {
      return true;
    }
    return false;
  }
}

class HelloTooth {
  // * 获取平台版本号
  static TaskApi getPlatformVersion() {
    return TaskApi('getPlatformVersion', null);
  }

  // * 设置文本
  static TaskApi setPlainText(String text) {
    return TaskApi('setPlainText', {'plainText': text});
  }
}
