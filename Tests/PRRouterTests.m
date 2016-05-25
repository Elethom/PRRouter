//
//  PRRouterTests.m
//  PRRouterTests
//
//  Created by Elethom Hunter on 12/05/2016.
//  Copyright © 2016 Elethom Hunter. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <PRRouter/PRRouter.h>
#import "PRRouter_Private.h"

@interface Root : UIViewController
@end
@implementation Root
@end
@interface Users : UIViewController
@end
@implementation Users
@end
@interface UsersSlash : UIViewController
@end
@implementation UsersSlash
@end
@interface User : UIViewController
@end
@implementation User
@end
@interface Me : UIViewController
@end
@implementation Me
@end
@interface UserID : UIViewController
@end
@implementation UserID
@end
@interface Article : UIViewController
@end
@implementation Article
@end
@interface ArticleID : UIViewController
@end
@implementation ArticleID
@end
@interface ArticleComments : UIViewController
@end
@implementation ArticleComments
@end
@interface ArticleComment : UIViewController
@end
@implementation ArticleComment
@end
@interface ArticleCommentID : UIViewController
@end
@implementation ArticleCommentID
@end
@interface Profile : UIViewController
@end
@implementation Profile
@end
@interface Messages : UIViewController
@end
@implementation Messages
@end

@interface PRRouterTests : XCTestCase

@property (nonatomic, strong) PRRouter *router;

@end

@implementation PRRouterTests

- (void)setUp
{
    [super setUp];
    
    NSDictionary *mappedPaths = @{
        @"/" : [Root class],
        @"/users" : [Users class],
        @"/users/" : [UsersSlash class],
        @"/user" : [User class],
        @"/user/me" : [Me class],
        @"/user/:user_id" : [UserID class],
        @"/user/:user_id/article" : [Article class],
        @"/user/:user_id/article/:article_id" : [ArticleID class],
        @"/user/:user_id/article/:article_id/comments" : [ArticleComments class],
        @"/user/:user_id/article/:article_id/comment" : [ArticleComment class],
        @"/user/:user_id/article/:article_id/comment/:comment_id" : [ArticleCommentID class],
        @"/user/:username/profile" : [Profile class],
        @"/user/:username/messages" : [Messages class],
    };
    self.router = [[PRRouter alloc] init];
    for (NSString *path in mappedPaths) {
        Class controllerClass = mappedPaths[path];
        [self.router mapControllerClass:controllerClass
                                 toPath:path];
    }
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testPaths
{
    NSDictionary *mappedPaths = @{
        @"/" : [Root class],
        @"/users" : [Users class],
        @"/users/" : [UsersSlash class],
        @"/user" : [User class],
        @"/user/me" : [Me class],
        @"/user/6" : [UserID class],
        @"/user/6/article" : [Article class],
        @"/user/6/article/13" : [ArticleID class],
        @"/user/6/article/13/comments" : [ArticleComments class],
        @"/user/6/article/13/comment" : [ArticleComment class],
        @"/user/6/article/13/comment/23" : [ArticleCommentID class],
        @"/user/elethom/profile" : [Profile class],
        @"/user/elethom/messages" : [Messages class],
    };
    for (NSString *path in mappedPaths) {
        Class controllerClass = mappedPaths[path];
        Class actualClass = [self.router controllerClassForPath:path];
        NSAssert(controllerClass == actualClass,
                 @"Incorrect mapped class: path = %@; class = %@, actual = %@",
                 path,
                 NSStringFromClass(controllerClass),
                 NSStringFromClass(actualClass));
    }
}

- (void)testParams
{
    NSDictionary *mappedPaths = @{
        @"/user/6" : @{
            @"user_id" : @"6",
        },
        @"/user/6/article" : @{
            @"user_id" : @"6",
        },
        @"/user/6/article/13" : @{
            @"user_id" : @"6",
            @"article_id" : @"13",
        },
        @"/user/6/article/13/comments" : @{
            @"user_id" : @"6",
            @"article_id" : @"13",
        },
        @"/user/6/article/13/comment" : @{
            @"user_id" : @"6",
            @"article_id" : @"13",
        },
        @"/user/6/article/13/comment/23" : @{
            @"user_id" : @"6",
            @"article_id" : @"13",
            @"comment_id" : @"23",
        },
        @"/user/elethom/profile" : @{
            @"username" : @"elethom",
        },
        @"/user/elethom/messages" : @{
            @"username" : @"elethom",
        },
    };
    for (NSString *path in mappedPaths) {
        NSDictionary *params = mappedPaths[path];
        PRRouterNode *node = [self.router nodeForPath:path];
        NSDictionary *actualParams = [self.router paramsForPath:path ofNode:node];
        NSAssert([params isEqual:actualParams],
                 @"Incorrect params: path = %@; params = %@, actual = %@",
                 path,
                 params,
                 actualParams);
    }
}

@end
