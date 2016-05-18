//
//  NSString+PRRouterURLCoding.m
//  PRRouter
//
//  Created by Elethom Hunter on 18/05/2016.
//  Copyright © 2016 Elethom Hunter. All rights reserved.
//

#import "NSString+PRRouterURLCoding.h"

@implementation NSString (PRRouterURLCoding)

- (NSString *)pr_URLEncodedString
{
    NSCharacterSet *allowedCharacters = [NSCharacterSet alphanumericCharacterSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}

- (NSString *)pr_URLDecodedString
{
    return [self stringByRemovingPercentEncoding];
}

- (NSDictionary *)pr_URLDecodedDictionary
{
    NSArray *components = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *decodedDictionary = [NSMutableDictionary dictionaryWithCapacity:components.count];
    for (NSString *component in components) {
        NSUInteger length = component.length;
        NSUInteger divider = MIN([component rangeOfString:@"="].location, length);
        NSString *key = [[component substringToIndex:divider] pr_URLDecodedString];
        NSString *value = [[component substringFromIndex:MIN(divider + 1, length)] pr_URLDecodedString];
        if ([decodedDictionary.allKeys containsObject:key]) {
            id oldValue = decodedDictionary[key];
            if ([oldValue isKindOfClass:[NSString class]]) {
                decodedDictionary[key] = [NSMutableArray arrayWithObjects:oldValue, value, nil];
            } else if ([oldValue isKindOfClass:[NSMutableArray class]]) {
                [oldValue addObject:value];
            }
        }
    }
    return decodedDictionary;
}

@end
