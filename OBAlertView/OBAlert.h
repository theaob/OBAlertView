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
#import "UIButton+ALBlock.h"

/*!
 ----------------------------
 /// @name OBAlert
 ----------------------------
 */

/*!
 * This class is useful to display some alert on the view and show messages to the user
 */

@interface OBAlert : UIView {
    UIViewController *parentViewController;
    UIView *overlay;
    UILabel *title;
    UILabel *message;
    NSMutableArray *subviews, *buttons;
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
 */
- (void)showAlertWithMessage:(NSString *)alertText;
/*!
 Remove the alert from the screen
 */
- (void)removeAlert;

@end
