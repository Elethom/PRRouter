//
//  PRRouter.h
//  PRRouter
//
//  Created by Elethom Hunter on 19/05/2016.
//  Copyright © 2016 Elethom Hunter. All rights reserved.
//

#import <PRRouter/UIViewController+PRRouter.h>

typedef NS_ENUM(NSUInteger, PRRouterTransitionStyle) {
    PRRouterTransitionStylePush, // push view controller (default)
    PRRouterTransitionStyleAutomatic, // replace if top view controller has the same path, push else
    PRRouterTransitionStyleReplace, // replace top view controller in current hierarchy
    PRRouterTransitionStyleToRoot, // replace all view controllers above root in current hierarchy
};

@interface PRRouter : NSObject <NSCopying, NSCoding>

/**
 *  Returns the default router.
 *
 *  @return The default router.
 */
+ (instancetype)defaultRouter;

/**
 *  Map a controller class to a path.
 *
 *  @param controllerClass The controller class to be associated with path.
 *  @param path            The path to be mapped to.
 */
- (void)mapControllerClass:(Class)controllerClass toPath:(NSString *)path;

/**
 *  Map a controller class to a path.
 *
 *  @param controllerClass The controller class to be associated with path.
 *  @param path            The path to be mapped to.
 *  @param style           The style of animation used presenting a controller.
 */
- (void)mapControllerClass:(Class)controllerClass toPath:(NSString *)path style:(PRRouterTransitionStyle)style;

/**
 *  Returns the controller class associated with a given path.
 *
 *  @param path The path for which to return the corresponding controller class.
 *
 *  @return The controller class associated with path.
 */
- (Class)controllerClassForPath:(NSString *)path;

/**
 *  Open a URL with the specified navigation controller.
 *
 *  @param url        The URL to be opened.
 *  @param controller The navigation controller with which the view controller is pushed.
 */
- (void)openURL:(NSURL *)url withNavigationController:(UINavigationController *)controller;

/**
 *  Open a path with the specified navigation controller.
 *
 *  @param path       The path to be opened.
 *  @param controller The navigation controller with which the view controller is pushed.
 */
- (void)openPath:(NSString *)path withNavigationController:(UINavigationController *)controller;

/**
 *  Open a path with the specified navigation controller.
 *
 *  @param path       The path to be opened.
 *  @param query      The query dictionary to be used when initiating the view controller.
 *  @param controller The navigation controller with which the view controller is pushed.
 */
- (void)openPath:(NSString *)path query:(NSDictionary *)query withNavigationController:(UINavigationController *)controller;

/**
 *  Open a path with the specified navigation controller.
 *
 *  @param path       The path to be opened.
 *  @param fragment   The fragmen to be used when initiating the view controller.
 *  @param controller The navigation controller with which the view controller is pushed.
 */
- (void)openPath:(NSString *)path fragment:(NSString *)fragment withNavigationController:(UINavigationController *)controller;

/**
 *  Open a path with the specified navigation controller.
 *
 *  @param path       The path to be opened.
 *  @param query      The query dictionary to be used when initiating the view controller.
 *  @param fragment   The fragmen to be used when initiating the view controller.
 *  @param controller The navigation controller with which the view controller is pushed.
 */
- (void)openPath:(NSString *)path query:(NSDictionary *)query fragment:(NSString *)fragment withNavigationController:(UINavigationController *)controller;

@end
