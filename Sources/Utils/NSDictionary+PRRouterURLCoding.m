//
//  NSDictionary+PRRouterURLCoding.m
//  PRRouter
//
//  Created by Elethom Hunter on 19/05/2016.
//  Copyright © 2016 Elethom Hunter. All rights reserved.
//

#import "NSDictionary+PRRouterURLCoding.h"
#import "NSString+PRRouterURLCoding.h"

@implementation NSDictionary (PRRouterURLCoding)

- (NSString *)pr_URLEncodedString
{
    NSMutableArray *components = [[NSMutableArray alloc] initWithCapacity:self.count];
    for (NSString *key in self) {
        [components addObject:({
            NSString *value = ^NSString *{
                id value = self[key];
                if ([value isKindOfClass:[NSString class]]) {
                    return [value pr_URLEncodedString];
                } else if ([value isKindOfClass:[NSNumber class]]) {
                    return [value stringValue];
                } else if ([value isKindOfClass:[NSArray class]] ||
                           [value isKindOfClass:[NSOrderedSet class]] ||
                           [value isKindOfClass:[NSSet class]]) {
                    NSMutableArray *components = [NSMutableArray arrayWithCapacity:[value count]];
                    for (id component in value) {
                        [components addObject:^NSString *{
                            if ([component isKindOfClass:[NSString class]]) {
                                return [component pr_URLEncodedString];
                            } if ([component isKindOfClass:[NSString class]]) {
                                return [component stringValue];
                            } else {
                                return @"";
                            }
                        }()];
                    }
                    return [components componentsJoinedByString:@","];
                } else {
                    return @"";
                }
            }();
            [@[[key pr_URLEncodedString], value] componentsJoinedByString:@"="];
        })];
    }
    return [components componentsJoinedByString:@"&"];
}

@end
