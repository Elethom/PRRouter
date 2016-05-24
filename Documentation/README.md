# PRRouter API Reference

## PRRouter

### Getting a PRRouter Instance

#### + defaultRouter

Returns the default router.

##### Declaration

```objective-c
+ (instancetype)defaultRouter
```

##### Return Value

The default router.

##### Discussion

A `PRRouter` instance can also be initialized by `[[PRRouter alloc] init]`.

### Map a Path to a Controller Class

#### - mapPath:toControllerClass:

Map a path to a controller class.

##### Declaration

```objective-c
- (void)mapPath:(NSString *)path toControllerClass:(Class)controllerClass
```

##### Parameters

| Paramter        | Description                                      |
| --------------- | ------------------------------------------------ |
| path            | The path to be mapped.                           |
| controllerClass | The controller class to be associated with path. |

#### - mapPath:toControllerClass:style:

Map a path to a controller class.

##### Declaration

```objective-c
- (void)mapPath:(NSString *)path toControllerClass:(Class)controllerClass style:(PRRouterTransitionStyle)style
```

##### Parameters

| Paramter        | Description                                          |
| --------------- | ---------------------------------------------------- |
| path            | The path to be mapped.                               |
| controllerClass | The controller class to be associated with path.     |
| style           | The style of animation used presenting a controller. |

### Get a Mapped Controller Class

#### - controllerClassForPath:

Returns the controller class associated with a given path.

##### Declaration

```objective-c
- (Class)controllerClassForPath:(NSString *)path
```

##### Parameters

| Paramter | Description                                                      |
| -------- | ---------------------------------------------------------------- |
| path     | The path for which to return the corresponding controller class. |

##### Return Value

The controller class associated with path.

### Navigate to a View Controller

#### - openURL:withNavigationController:

Open a URL with the specified navigation controller.

##### Declaration

```objective-c
- (void)openURL:(NSURL *)url withNavigationController:(UINavigationController *)controller
```

##### Parameters

| Paramter   | Description                                                         |
| ---------- | ------------------------------------------------------------------- |
| url        | The URL to be opened.                                               |
| controller | The navigation controller with which the view controller is pushed. |

#### - openPath:withNavigationController:

Open a path with the specified navigation controller.

##### Declaration

```objective-c
- (void)openPath:(NSString *)path withNavigationController:(UINavigationController *)controller
```

##### Parameters

| Paramter   | Description                                                         |
| ---------- | ------------------------------------------------------------------- |
| path       | The path to be opened.                                              |
| controller | The navigation controller with which the view controller is pushed. |

#### - openPath:query:withNavigationController:

Open a path with the specified navigation controller.

##### Declaration

```objective-c
- (void)openPath:(NSString *)path query:(NSDictionary *)query withNavigationController:(UINavigationController *)controller
```

##### Parameters

| Paramter   | Description                                                          |
| ---------- | -------------------------------------------------------------------- |
| path       | The path to be opened.                                               |
| query      | The query dictionary to be used when initiating the view controller. |
| controller | The navigation controller with which the view controller is pushed.  |

#### - openPath:fragment:withNavigationController:

Open a path with the specified navigation controller.

##### Declaration

```objective-c
- (void)openPath:(NSString *)path fragment:(NSString *)fragment withNavigationController:(UINavigationController *)controller
```

##### Parameters

| Paramter   | Description                                                         |
| ---------- | ------------------------------------------------------------------- |
| path       | The path to be opened.                                              |
| fragment   | The fragmen to be used when initiating the view controller.         |
| controller | The navigation controller with which the view controller is pushed. |

#### - openPath:query:fragment:withNavigationController:

Open a path with the specified navigation controller.

##### Declaration

```objective-c
- (void)openPath:(NSString *)path query:(NSDictionary *)query fragment:(NSString *)fragment withNavigationController:(UINavigationController *)controller
```

##### Parameters

| Paramter   | Description                                                          |
| ---------- | -------------------------------------------------------------------- |
| path       | The path to be opened.                                               |
| query      | The query dictionary to be used when initiating the view controller. |
| fragment   | The fragmen to be used when initiating the view controller.          |
| controller | The navigation controller with which the view controller is pushed.  |

## UIViewController (PRRouter)

### Accessing Configurations

#### pr_routerParams *property*

Params in the path. (read-only)

##### Declaration

```objective-c
@property (nonatomic, copy, readonly) NSDictionary *pr_routerParams
```

##### Discussion

In the form of: `{ param key : param }`

Example:

```
path to resolve = /user/elethom/article/1
path mapped = /user/:username/artile/:article_id
params = {
    username : elethom,
    article_id : 1,
}
```

#### pr_routerQuery *property*

The query string, conforming to RFC 1808. (read-only)

##### Declaration

```objective-c
@property (nonatomic, copy, readonly) NSDictionary *pr_routerQuery
```

##### Discussion

In the form of: `{ key : value }`

Values may be `NSString` or `NSArray<NSString *>` instances.

Example:

```
path to resolve = /article?username=elethom&article_id=1
query = {
    username : elethom,
    article_id : 1,
}
```

#### pr_routerFragment *property*

The fragment identifier, conforming to RFC 1808. (read-only)

##### Declaration

```objective-c
@property (nonatomic, copy, readonly) NSString *pr_routerFragment
```

##### Discussion

Example:

```
path to resolve = /user/elethom#articles
fragment = articles
```

### Initializing a View Controller Instance

#### - initWithParams:query:fragment: *Designated Initializer*

The designated initializer. Router will initialize view controllers mapped to a path via this method.

##### Declaration

```objective-c
- (instancetype)initWithParams:(NSDictionary *)params query:(NSDictionary *)query fragment:(NSString *)fragment
```

##### Parameters

| Paramter | Description                                      |
| -------- | ------------------------------------------------ |
| params   | Params in the path.                              |
| query    | The query string, conforming to RFC 1808.        |
| fragment | The fragment identifier, conforming to RFC 1808. |

##### Return Value

A newly initialized UIViewController object.

##### Discussion

This method should be implemented by any view controller classes mapped to a path.

