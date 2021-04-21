//
//  NSObject+Expand.m
//  WiFiCamera
//
//  Created by kui on 2021/4/21.
//

#import "NSObject+Expand.h"

@implementation NSObject (Expand)

+ (NSString *)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
