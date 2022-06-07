//
//  TaskApi.h
//  hello_tooth
//
//  Created by liu nian on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskApi : NSObject
@property (nonatomic, copy, readonly) NSString *method;
@property (nullable,nonatomic, strong, readonly) NSDictionary *params;
@property (nonatomic, strong, readonly) NSDictionary *jsonBody;

- (instancetype)initWithMehod:(NSString *)method
                       params:(nullable NSDictionary *)params;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
