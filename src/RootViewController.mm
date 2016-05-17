
#import "RootViewController.h"
#import "DictationTest-Swift.h"
#include "DictationTestApp.h"
#include "cinder/Log.h"

@implementation RootViewController : UIViewController

- (void)addCinderViewToFront
{
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"Root View Controller";

    KeyboardViewController *keyboard = [[KeyboardViewController alloc] init];
    [self presentViewController:keyboard animated:FALSE completion:NULL];

    auto *cinder_view = ci::app::getWindow()->getNativeViewController();
    [keyboard.view addSubview:cinder_view.view];
}

- (void)setText: (NSString*) text
{
    auto *app = static_cast<DictationTestApp*>(ci::app::App::get());
    app->setText([text UTF8String]);
}

@end