//
//  CustomBadgeAppDelegate.h
//  CustomBadge
//


#import <UIKit/UIKit.h>

@class CustomBadgeViewController;

@interface CustomBadgeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CustomBadgeViewController *viewController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet CustomBadgeViewController *viewController;

@end

