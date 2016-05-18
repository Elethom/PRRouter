//
//  NSString+PRRouterURLCoding.h
//  PRRouter
//
//  Created by Elethom Hunter on 18/05/2016.
//  Copyright © 2016 Elethom Hunter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PRRouterURLCoding)

- (NSString *)pr_URLEncodedString;
- (NSString *)pr_URLDecodedString;
- (NSDictionary *)pr_URLDecodedDictionary;

@end
