//
//  UIViewController+PRRouter.m
//  PRRouter
//
//  Created by Elethom Hunter on 19/05/2016.
//  Copyright © 2016 Elethom Hunter. All rights reserved.
//

#import "UIViewController+PRRouter.h"
#import <objc/runtime.h>

@interface UIViewController ()

@property (nonatomic, copy, readwrite) NSDictionary *pr_routerParams;
@property (nonatomic, copy, readwrite) NSDictionary *pr_routerQuery;
@property (nonatomic, copy, readwrite) NSString *pr_routerFragment;

@end

@implementation UIViewController (PRRouter)

#pragma mark - Getters and setters

- (NSDictionary *)pr_routerParams
{
    return objc_getAssociatedObject(self,
                                    @selector(pr_routerParams));
}

- (void)setPr_routerParams:(NSDictionary *)pr_routerParams
{
    objc_setAssociatedObject(self,
                             @selector(pr_routerParams),
                             pr_routerParams,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)pr_routerQuery
{
    return objc_getAssociatedObject(self,
                                    @selector(pr_routerQuery));
}

- (void)setPr_routerQuery:(NSDictionary *)pr_routerQuery
{
    objc_setAssociatedObject(self,
                             @selector(pr_routerQuery),
                             pr_routerQuery,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)pr_routerFragment
{
    return objc_getAssociatedObject(self,
                                    @selector(pr_routerFragment));
}

- (void)setPr_routerFragment:(NSString *)pr_routerFragment
{
    objc_setAssociatedObject(self,
                             @selector(pr_routerFragment),
                             pr_routerFragment,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - Life cycle

- (instancetype)initWithParams:(NSDictionary *)params
                         query:(NSDictionary *)query
                      fragment:(NSString *)fragment
{
    self = [self init];
    if (self) {
        self.pr_routerParams = params;
        self.pr_routerQuery = query;
        self.pr_routerFragment = fragment;
    }
    return self;
}

@end
