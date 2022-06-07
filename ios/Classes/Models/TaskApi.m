//
//  TaskApi.m
//  hello_tooth
//
//  Created by liu nian on 2022/6/7.
//

#import "TaskApi.h"

@interface TaskApi ()
@property (nonatomic, copy) NSString *method;
@property (nullable,nonatomic, strong) NSDictionary *params;
@end
@implementation TaskApi

- (instancetype)initWithMehod:(NSString *)method
                       params:(NSDictionary *)params {
    self = [super init];
    if (self) {
        self.method = method;
        self.params = params;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.method = dictionary[@"method"];
        if ([dictionary.allKeys containsObject:@"params"]) {
            self.params = dictionary[@"params"];
        }
    }
    return self;
}

- (NSDictionary *)jsonBody {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:3];
    dict[@"method"] = self.method;

    dict[@"params"] = [NSNull null];
    if (self.params) {
        dict[@"params"] = self.params;
    }
    
    return dict;
}
@end
