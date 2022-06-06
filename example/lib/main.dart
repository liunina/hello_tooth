import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:hello_tooth/TDPreviewController.dart';
import 'package:hello_tooth/camera_preview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  int tapCount = 0;
  TDPreviewController? previewController;

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      String? version = await previewController?.getPlatformVersion();

      platformVersion = version ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void setPlainText() {
    previewController?.setPlainText();
  }

  void viewDidTapListen() {
    previewController?.viewDidTap = () {
      setState(() {
        tapCount++;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('预览视图被点击次数: $tapCount'),
            ),
            const SizedBox(
              height: 100.0,
            ),
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setPlainText();
                    // Get.toNamed(AppRoutes.SignUp);
                  },
                  child: const Text(
                    "获取版本",
                    style: TextStyle(fontSize: 15.0, color: Colors.black54),
                  ),
                )
              ],
            ),
            Container(
              width: 300.0,
              height: 300.0,
              child: CameraPreview(
                plainText: '这是初始化文本',
                onViewCreated: (TDPreviewController controller) {
                  previewController = controller;
                  viewDidTapListen();
                  initPlatformState();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
