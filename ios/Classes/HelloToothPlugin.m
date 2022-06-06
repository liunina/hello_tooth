#import "HelloToothPlugin.h"
#import "TDCameraPreviewFactory.h"

@implementation HelloToothPlugin

/// 注册插件
/// @param registrar 提供应用程序上下文和注册回调的方法
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    // 注册视图工厂
    // 绑定工厂唯一标识符这里与 Flutter UIKitView 所使用 viewType 一致
    [registrar registerViewFactory:[[TDCameraPreviewFactory alloc] initWithMessenger:[registrar messenger]]
                            withId:@"hello_tooth"];
}

@end
