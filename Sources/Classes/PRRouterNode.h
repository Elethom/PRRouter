//
//  PRRouterNode.h
//  PRRouter
//
//  Created by Elethom Hunter on 19/05/2016.
//  Copyright © 2016 Elethom Hunter. All rights reserved.
//

#import "PRRouter.h"

@interface PRRouterNode : NSObject <NSCopying, NSCoding>

/**
 *  Full path.
 *  Default: /
 */
@property (nonatomic, copy) NSString *path;

/**
 *  Param keys.
 *  Default: @[ ]
 */
@property (nonatomic, copy) NSArray *paramKeys;

/**
 *  Mapped class name. Should be a subclass of UIViewController.
 */
@property (nonatomic, copy) NSString *mappedClassName;

/**
 *  Default transition style to use when not specified.
 */
@property (nonatomic, assign) PRRouterTransitionStyle style;

/**
 *  Returns a subnode.
 *
 *  @param component Path component. Will be treated as a param value if a key is not found.
 *
 *  @return Subnode for the key specified.
 */
- (PRRouterNode *)subnodeForPathComponent:(NSString *)component;

/**
 *  Returns a subnode. Create one if subnode doesn't exist.
 *
 *  @param component Path component. Will be treated as a param key if starts with ":".
 *
 *  @return Subnode for the key specified.
 */
- (PRRouterNode *)createSubnodeForPathComponent:(NSString *)component;

@end
