//
//  HelloResult.m
//  hello_tooth
//
//  Created by liu nian on 2022/6/6.
//

#import "HelloResult.h"

@implementation HelloResult
- (instancetype)initWithCode:(NSInteger)code
                     message:(nullable NSString *)message
                        data:(nullable id)data {
    self = [super init];
    if (self) {
        self.code = code;
        self.message = message;
        self.data = data;
    }
    return self;
}

+ (HelloResult *)resultWithCode:(NSInteger)code message:(nullable NSString *)message data:(nullable id)data {
    return [[HelloResult alloc] initWithCode:code message:message data:data];
}

+ (HelloResult *)successWithData:(nullable id)data {
    return [[HelloResult alloc] initWithCode:0 message:@"success" data:data];
}

+ (HelloResult *)failedWithCode:(NSInteger)code message:(NSString *)message {
    return [[HelloResult alloc] initWithCode:code message:message data:nil];
}

+ (HelloResult *)failedWithMessage:(NSString *)message {
    return [[HelloResult alloc] initWithCode:9527 message:message data:nil];
}

- (NSDictionary *)jsonBody {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:3];
    dict[@"code"] = @(self.code);
    dict[@"messag"] = [NSNull null];
    if (self.message) {
        dict[@"messag"] = self.message;
    }
    dict[@"data"] = [NSNull null];
    if (self.data) {
        dict[@"data"] = self.data;
    }
    
    return dict;
}
@end
