//
//  NSNumber+PRRouterURLCoding.m
//  PRRouter
//
//  Created by Elethom Hunter on 18/05/2016.
//  Copyright © 2016 Elethom Hunter. All rights reserved.
//

#import "NSNumber+PRRouterURLCoding.h"
#import "NSString+PRRouterURLCoding.h"

@implementation NSNumber (PRRouterURLCoding)

- (NSString *)pr_URLEncodedString
{
    return self.stringValue.pr_URLEncodedString;
}

@end
