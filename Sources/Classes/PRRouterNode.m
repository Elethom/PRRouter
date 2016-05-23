//
//  PRRouterNode.m
//  PRRouter
//
//  Created by Elethom Hunter on 19/05/2016.
//  Copyright © 2016 Elethom Hunter. All rights reserved.
//

#import "PRRouterNode.h"

@interface PRRouterNode ()

/**
 *  Subnodes.
 *  In the form of: { path component : node }
 *  Default: @{ }
 */
@property (nonatomic, strong) NSMutableDictionary *subnodes;

@end

@implementation PRRouterNode

- (PRRouterNode *)subnodeForPathComponent:(NSString *)component
{
    return self.subnodes[component] ?: self.subnodes[@":"];
}

- (PRRouterNode *)createSubnodeForPathComponent:(NSString *)component
{
    NSString *key = [component hasPrefix:@":"] ? @":" : component;
    return self.subnodes[key] ?: ({
        PRRouterNode *node = [[PRRouterNode alloc] init];
        @synchronized (self) {
            self.subnodes[key] = node;
        }
        node;
    });
}

#pragma mark - Overrides

- (NSUInteger)hash
{
    return self.path.hash;
}

- (BOOL)isEqual:(PRRouterNode *)node
{
    return [node isKindOfClass:[self class]] && [self.path isEqualToString:node.path];
}

#pragma mark - Getters and setters

- (NSString *)path
{
    return _path ?: (_path = @"/");
}

- (NSArray *)paramKeys
{
    return _paramKeys ?: (_paramKeys = @[ ]);
}

- (NSMutableDictionary *)subnodes
{
    return _subnodes ?: (_subnodes = [[NSMutableDictionary alloc] init]);
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    PRRouterNode *node = [[self.class allocWithZone:zone] init];
    node.path = self.path;
    node.paramKeys = self.paramKeys;
    node.subnodes = [self.subnodes mutableCopy];
    node.mappedClassName = self.mappedClassName;
    node.style = self.style;
    return node;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (self) {
        _path = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(path))];
        _paramKeys = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(paramKeys))];
        _subnodes = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(subnodes))];
        _mappedClassName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(mappedClassName))];
        _style = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(style))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.path forKey:NSStringFromSelector(@selector(path))];
    [aCoder encodeObject:self.paramKeys forKey:NSStringFromSelector(@selector(paramKeys))];
    [aCoder encodeObject:self.subnodes forKey:NSStringFromSelector(@selector(subnodes))];
    [aCoder encodeObject:self.mappedClassName forKey:NSStringFromSelector(@selector(mappedClassName))];
    [aCoder encodeInteger:self.style forKey:NSStringFromSelector(@selector(style))];
}

@end
