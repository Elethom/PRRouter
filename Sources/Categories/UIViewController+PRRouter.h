//
//  UIViewController+PRRouter.h
//  PRRouter
//
//  Created by Elethom Hunter on 19/05/2016.
//  Copyright © 2016 Elethom Hunter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PRRouter)

/**
 *  Params in the path.
 *  In the form of: { param key : param }
 *  
 *  Example:
 *  path to resolve = /user/elethom/article/1
 *  path mapped = /user/:username/artile/:article_id
 *  params = {
 *      username : elethom,
 *      article_id : 1,
 *  }
 */
@property (nonatomic, copy, readonly) NSDictionary *pr_routerParams;

/**
 *  The query string, conforming to RFC 1808.
 *  In the form of: { key : value }
 *  Values may be NSString or NSArray<NSString *> instances.
 *
 *  Example:
 *  path to resolve = /article?username=elethom&article_id=1
 *  query = {
 *      username : elethom,
 *      article_id : 1,
 *  }
 */
@property (nonatomic, copy, readonly) NSDictionary *pr_routerQuery;

/**
 *  The fragment identifier, conforming to RFC 1808.
 *
 *  Example:
 *  path to resolve = /user/elethom#articles
 *  fragment = articles
 */
@property (nonatomic, copy, readonly) NSString *pr_routerFragment;

/**
 *  The designated initializer.
 *  Router will initialize view controllers mapped to a path via this method.
 *  This method should be implemented by any view controller classes mapped to a path.
 *
 *  @param params   Params in the path.
 *  @param query    The query string, conforming to RFC 1808.
 *  @param fragment The fragment identifier, conforming to RFC 1808.
 *
 *  @return A newly initialized UIViewController object.
 */
- (instancetype)initWithParams:(NSDictionary *)params
                         query:(NSDictionary *)query
                      fragment:(NSString *)fragment;

@end
