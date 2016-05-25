//
//  PRRouter.m
//  PRRouter
//
//  Created by Elethom Hunter on 19/05/2016.
//  Copyright © 2016 Elethom Hunter. All rights reserved.
//

#import "PRRouter_Private.h"
#import "NSString+PRRouterURLCoding.h"
#import "PRRouterNode.h"

@implementation PRRouter

#pragma mark - Private

- (PRRouterNode *)nodeForPath:(NSString *)path
{
    PRRouterNode *node = self.rootNode;
    NSArray *components = path.pathComponents;
    for (NSUInteger i = 0; i < components.count; i++) {
        NSString *component = components[i];
        if (i == 0 && [component isEqualToString:@"/"]) {
            continue;
        }
        node = [node subnodeForPathComponent:component];
    }
    return node;
}

- (NSDictionary *)paramsForPath:(NSString *)path ofNode:(PRRouterNode *)node
{
    NSArray *pathComponents = path.pathComponents;
    NSArray *mappedPathComponents = node.path.pathComponents;
    NSArray *paramKeys = node.paramKeys;
    NSMutableArray *paramValues = [[NSMutableArray alloc] initWithCapacity:paramKeys.count];
    for (NSUInteger i = 0; i < mappedPathComponents.count; i++) {
        NSString *component = mappedPathComponents[i];
        if ([component hasPrefix:@":"]) {
            [paramValues addObject:pathComponents[i]];
        }
    }
    return [NSDictionary dictionaryWithObjects:paramValues
                                       forKeys:paramKeys];
}

#pragma mark - External

- (void)mapControllerClass:(Class)controllerClass toPath:(NSString *)path
{
    [self mapControllerClass:controllerClass toPath:path style:PRRouterTransitionStylePush];
}

- (void)mapControllerClass:(Class)controllerClass toPath:(NSString *)path style:(PRRouterTransitionStyle)style
{
    PRRouterNode *node = self.rootNode;
    NSArray *components = path.pathComponents;
    NSMutableArray *paramKeys = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < components.count; i++) {
        NSString *component = components[i];
        if (i == 0 && [component isEqualToString:@"/"]) {
            continue;
        }
        if ([component hasPrefix:@":"]) {
            [paramKeys addObject:[component substringFromIndex:1]];
        }
        node = [node createSubnodeForPathComponent:component];
    }
    node.path = path;
    node.paramKeys = paramKeys;
    node.mappedClassName = NSStringFromClass(controllerClass);
    node.style = style;
}

- (Class)controllerClassForPath:(NSString *)path
{
    PRRouterNode *node = [self nodeForPath:path];
    return NSClassFromString(node.mappedClassName);
}

- (void)openURL:(NSURL *)url withNavigationController:(UINavigationController *)controller
{
    [self openPath:url.path query:url.query.pr_URLDecodedDictionary fragment:url.fragment withNavigationController:controller];
}

- (void)openPath:(NSString *)path withNavigationController:(UINavigationController *)controller
{
    [self openPath:path query:nil fragment:nil withNavigationController:controller];
}

- (void)openPath:(NSString *)path query:(NSDictionary *)query withNavigationController:(UINavigationController *)controller
{
    [self openPath:path query:query fragment:nil withNavigationController:controller];
}

- (void)openPath:(NSString *)path fragment:(NSString *)fragment withNavigationController:(UINavigationController *)controller
{
    [self openPath:path query:nil fragment:fragment withNavigationController:controller];
}

- (void)openPath:(NSString *)path query:(NSDictionary *)query fragment:(NSString *)fragment withNavigationController:(UINavigationController *)controller
{
    PRRouterNode *node = [self nodeForPath:path];
    Class controllerClass = NSClassFromString(node.mappedClassName);
    NSDictionary *params = [self paramsForPath:path ofNode:node];
    UIViewController *newController = [[controllerClass alloc] initWithParams:params
                                                                        query:query
                                                                     fragment:fragment];
    void (^push)() = ^{
        [controller pushViewController:newController
                              animated:YES];
    };
    void (^replace)() = ^{
        NSMutableArray *controllers = [controller.viewControllers mutableCopy];
        [controllers removeLastObject];
        [controllers addObject:newController];
        [controller setViewControllers:controllers
                              animated:YES];
    };
    void (^toRoot)() = ^{
        NSArray *controllers = @[controller.viewControllers.firstObject, newController];
        [controller setViewControllers:controllers
                              animated:YES];
    };
    switch (node.style) {
        case PRRouterTransitionStyleAutomatic: {
            Class currentControllerClass = [controller.topViewController class];
            if (currentControllerClass == controllerClass) {
                replace();
            } else {
                push();
            }
            break;
        }
        case PRRouterTransitionStylePush:
            push();
            break;
        case PRRouterTransitionStyleReplace:
            replace();
            break;
        case PRRouterTransitionStyleToRoot:
            toRoot();
            break;
    }
}

#pragma mark - Getters and setters

- (PRRouterNode *)rootNode
{
    return _rootNode ?: (_rootNode = [[PRRouterNode alloc] init]);
}

#pragma mark - Life cycle

+ (instancetype)defaultRouter
{
    static PRRouter *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    PRRouter *router = [[self.class allocWithZone:zone] init];
    router.rootNode = [self.rootNode copy];
    return router;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (self) {
        _rootNode = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(rootNode))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.rootNode forKey:NSStringFromSelector(@selector(rootNode))];
}

@end

@implementation UIViewController (PRRouterExtension)

+ (void)pr_mapToPath:(NSString *)path
{
    [[PRRouter defaultRouter] mapControllerClass:self
                                          toPath:path];
}

+ (void)pr_mapToPath:(NSString *)path style:(PRRouterTransitionStyle)style
{
    [[PRRouter defaultRouter] mapControllerClass:self
                                          toPath:path
                                           style:style];
}

@end
