//
//  TDCameraPreViewFactory.m
//  hello_tooth
//
//  Created by liu nian on 2022/6/6.
//

#import "TDCameraPreviewFactory.h"
#import "HelloPlatformView.h"

@interface TDCameraPreviewFactory ()
/// 用于与 Flutter 传输二进制消息通信
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger> *messenger;
@end
@implementation TDCameraPreviewFactory

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager {
    self = [super init];
    if (self) {
        self.messenger = messager;
    }
    return self;
}

#pragma mark - FlutterPlatformViewFactory

/// 创建一个“FlutterPlatformView”
/// 由iOS代码实现，该代码公开了一个用于嵌入Flutter应用程序的“UIView”。
/// 这个方法的实现应该创建一个新的“UIView”并返回它。
/// @param frame Flutter通过其布局widget来计算得来
/// @param viewId 视图的唯一标识符，创建一个 UIKitView 该值会+1
/// @param args 对应Flutter 端UIKitView的creationParams参数
- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                            viewIdentifier:(int64_t)viewId
                                                 arguments:(id _Nullable)args {
    HelloPlatformView *platformView = [[HelloPlatformView alloc] initWithWithFrame:frame
                                                                    viewIdentifier:viewId
                                                                         arguments:args
                                                                   binaryMessenger:self.messenger];
    return platformView;
}

/// 使用Flutter标准二进制编码
- (NSObject<FlutterMessageCodec> *)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

@end
