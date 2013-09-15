//
//  OBAlert.m
//  OBAlert
//
//  Extended by Onur Baykal on 15/09/13
//
//  Based on ALFullScreenAlert:
//  Created by Andrea Mario Lufino on 02/07/13.
//  Copyright (c) 2013 Andrea Mario Lufino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIButton+ALBlock.m"

/*!
 ----------------------------
 /// @name OBAlert
 ----------------------------
 */

/*!
 * This class is useful to display some alert on the view and show messages to the user
 */

typedef void (^ActionBlock)(void);

@interface OBAlert : UIView {
    UIViewController *parentViewController;
    UIView *overlay;
    UILabel *title;
    UILabel *message;
    NSMutableArray *subviews;
    UIButton * button;
    BOOL isShown;
}

/*!
 Init the alert
 @param viewController The UIViewController in which the alert will display
 @return self
 */
- (id)initInViewController:(UIViewController *)viewController;
/*!
 Show the alert on the view controller passed in the init method
 @param alertText The text that have to be displayed in the alert
 @param titleText The title text for the alert title
 @param buttonText The text for the button on the alert
 @param block The executed block when the button on the alert receives Touch Up Inside
 */
- (void)showAlertWithText:(NSString *)alertText titleText:(NSString *)titleText buttonText:(NSString *)buttonText onTap:(void (^)(void))block;
/*!
 Remove the alert from the screen
 */
- (void)removeAlert;

@end
