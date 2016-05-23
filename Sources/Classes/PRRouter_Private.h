//
//  PRRouter_Private.h
//  PRRouter
//
//  Created by Elethom Hunter on 23/05/2016.
//  Copyright © 2016 Elethom Hunter. All rights reserved.
//

#import "PRRouter.h"

@class PRRouterNode;

@interface PRRouter ()

/**
 *  Root node.
 */
@property (nonatomic, strong) PRRouterNode *rootNode;

/**
 *  Returns the node associated with a given path.
 *
 *  @param path The path for which to return the corresponding node.
 *
 *  @return The node associated with path.
 */
- (PRRouterNode *)nodeForPath:(NSString *)path;

/**
 *  Returns the params dictionary parsed from a given path.
 *
 *  @param path The path to be parsed.
 *  @param node The node associated with path.
 *
 *  @return The params dictionary parsed from path.
 */
- (NSDictionary *)paramsForPath:(NSString *)path ofNode:(PRRouterNode *)node;

@end
