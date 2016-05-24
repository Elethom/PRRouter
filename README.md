# PRRouter [![CocoaPods compatible](https://img.shields.io/cocoapods/v/PRRouter.svg)](https://cocoapods.org/pods/PRRouter) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage) [![Build Status](https://img.shields.io/travis/Elethom/PRRouter.svg)](https://travis-ci.org/Elethom/PRRouter) [![Language](https://img.shields.io/badge/language-Objective--C-blue.svg)](../../search) [![License](https://img.shields.io/github/license/Elethom/PRRouter.svg)](/LICENSE)

URL router framework for iOS

## Why use a router?

Here's a typical way of navigating through view controllers:

```objective-c
#import "MyViewController.h"

...

MyViewController *controller = [[MyViewController alloc] init];
controller.someProperty = someProperty;
controller.someOtherProperty = someOtherProperty
[self.navigationController pushViewController:controller
                                     animated:YES];
```

Here's the same job did with a router.

```objective-c
[[PRRouter defaultRouter] openURL:myModel.url
         withNavigationController:self.navigationController];
```

Benefits of using a router:

* less coupling & more flexible
* navigation logic can be controlled by the server side
* better backward compatibility by falling back to web view

## Installation

### With Carthage

[Carthage](https://github.com/Carthage/Carthage) can be installed with [Homebrew](http://brew.sh):

```sh
$ brew update
$ brew install carthage
```

Add PRRouter to your `Cartfile`:

```
github "Elethom/PRRouter"
```

Run `carthage` to build the framework and add the built `PRRouter.framework` to your Xcode project.

### With CocoaPods

[CocoaPods](https://cocoapods.org) can be installed with [RubyGems](https://rubygems.org):

```sh
$ gem install cocoapods
```

Add PRRouter to your `Podfile`:

```ruby
pod 'PRRouter'
```

Run `pod install` to install the framework.

## Getting Started

### Map a path to a view controller class

```objective-c
@implementation PRUserViewController

...

#pragma mark - Life cycle

+ (void)load
{
    [[PRRouter defaultRouter] mapPath:@"/user/:user_id"
                    toControllerClass:self];
}

...

@end
```

### Implement `-initWithParams:query:fragment:`

```objective-c
@implementation PRUserViewController

...

- (instancetype)initWithParams:(NSDictionary *)params
                         query:(NSDictionary *)query
                      fragment:(NSString *)fragment
{
    self = [super initWithParams:params
                           query:query
                        fragment:fragment];
    if (self) {
        // Initialize your view controller
    }
    return self;
}

...

@end
```

### Use URL to navigate to a view conroller

```objective-c
@implementation PRContactsViewController

...

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PRContact *contact = self.viewModel.objects[indexPath.row];
    [[PRRouter defaultRouter] openURL:contact.url
             withNavigationController:self.navigationController];
}

...

@end
```

## Full API Reference

See [Documentation](/Documentation).

## License

This project is released under the terms and conditions of the [MIT license](http://opensource.org/licenses/MIT). See [LICENSE](/LICENSE) for details.

## Contact

This project is designed and developed by [Elethom Hunter](http://github.com/Elethom). You can reach me via:

* Email: elethomhunter@gmail.com
* Telegram: [@elethom](http://telegram.me/elethom)
* Twitter: [@ElethomHunter](https://twitter.com/ElethomHunter)

## Be Social

[![Tweet](https://img.shields.io/twitter/url/http/ElethomHunter.svg?style=social)](https://twitter.com/intent/tweet?text=PRRouter%3A%20URL%20router%20framework%20for%20iOS.&url=https%3A%2F%2Fgithub.com%2FElethom%2FPRRouter&via=ElethomHunter)
[![Twitter](https://img.shields.io/twitter/follow/ElethomHunter.svg?style=social)](https://twitter.com/intent/follow?user_id=1512633926)

## Donate

You can support me by:

* [sending me iTunes Gift Cards](mailto:elethomhunter@gmail.com)
* via [Alipay](https://www.alipay.com): elethomhunter@gmail.com
* via [PayPal](https://www.paypal.com): elethomhunter@gmail.com

:-)
