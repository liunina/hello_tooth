//
//  TDCameraPreViewFactory.h
//  hello_tooth
//
//  Created by liu nian on 2022/6/6.
//

#import <Flutter/Flutter.h>

@interface TDCameraPreviewFactory : NSObject<FlutterPlatformViewFactory>
/// 初始化视图工厂
/// @param messager 用于与 Flutter 传输二进制消息通信
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager;
@end
