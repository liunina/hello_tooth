//
//  HelloPlatformView.m
//  hello_tooth
//
//  Created by liu nian on 2022/6/6.
//

#import "HelloPlatformView.h"
#import "TDCameraPreview.h"
#import "HelloResult.h"
#import "TaskApi.h"

@interface HelloPlatformView ()<TDCameraPreviewDelegate>
/// 视图
@property (nonatomic, strong) TDCameraPreview *preview;
/// 平台通道
@property (nonatomic, strong) FlutterMethodChannel *channel;

@end
@implementation HelloPlatformView

- (instancetype)initWithWithFrame:(CGRect)frame
                   viewIdentifier:(int64_t)viewId
                        arguments:(id _Nullable)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    if ([super init]) {
        /// 初始化视图
        TDCameraPreview *preview = [[TDCameraPreview alloc] initWithFrame:frame];
        preview.backgroundColor = UIColor.blueColor;
        preview.delegate = self;
        [self mapArgs:args toView:preview];
        self.preview = preview;
        
        /// 这里的channelName是和Flutter 创建MethodChannel时的名字保持一致的，保证一个原生视图有一个平台通道传递消息
        NSString *channelName = [NSString stringWithFormat:@"preview_%lld", viewId];
        self.channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        // 处理 Flutter 发送的消息事件
        __weak __typeof__(self) weakSelf = self;
        [self.channel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
            if (weakSelf) {
                [weakSelf onMethodCall:call result:result];
            }
        }];
    }
    return self;
}

/// 处理参数
/// @param args 参数
/// @param view 视图
- (void)mapArgs:(id _Nullable)args toView:(TDCameraPreview *)view {
    if ([args isKindOfClass:[NSDictionary class]] && view != nil) {
        view.plainText = args[@"plainText"];
        // 其他参数，略
    }
}

/// 处理Flutter 发送的消息事件
/// @param call 事件
/// @param result 结果
- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([call.method isEqualToString:@"tooth_doctor_call_method"] && [call.arguments isKindOfClass:[NSDictionary class]]) {
        
        TaskApi *api = [[TaskApi alloc] initWithDictionary:call.arguments];
        HelloResult *resultModel = nil;
        if ([api.method isEqualToString:@"getPlatformVersion"]) {
            NSString *version = [@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]];
            resultModel = [HelloResult successWithData:@{@"version": version}];
        }else if ([api.method isEqualToString:@"setPlainText"]) {
            self.preview.plainText = api.params[@"plainText"];
            resultModel = [HelloResult successWithData:nil];
        }
        
        result(resultModel.jsonBody);
    }else {
        result(FlutterMethodNotImplemented);
    }
}
#pragma mark - TDCameraPreviewDelegate
- (void)viewDidTapWithPreview:(TDCameraPreview *)preiview {
    TaskApi *api = [[TaskApi alloc] initWithMehod:@"viewDidTap" params:nil];
    
    [_channel invokeMethod:@"tooth_doctor_call_method" arguments:api.jsonBody];
}

#pragma mark - FlutterPlatformView
/// 返回真正的视图
- (UIView *)view {
    return self.preview;
}

@end
