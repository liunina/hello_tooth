//
//  HelloResult.h
//  hello_tooth
//
//  Created by liu nian on 2022/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelloResult : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nullable, nonatomic, copy) NSString *message;
@property (nullable, nonatomic, strong) id data;
@property (nonatomic, strong, readonly) NSDictionary *jsonBody;

+ (HelloResult *)resultWithCode:(NSInteger)code message:(nullable NSString *)message data:(nullable id)data;
+ (HelloResult *)successWithData:(nullable id)data;
+ (HelloResult *)failedWithCode:(NSInteger)code message:(NSString *)message;
+ (HelloResult *)failedWithMessage:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
