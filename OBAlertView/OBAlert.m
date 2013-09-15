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

#import "OBAlert.h"

#define kNumberOfLines 99
#define kMessageMaxHeight 380
#define kMessageWidth 260
#define kX 30
#define kCenteredX 320/2
#define kBtnWidth (kMessageWidth - 20)/2
#define kBtnY message.frame.origin.y + message.frame.size.height + 20
#define kBtnHeight 40

#define BTN_FONT [UIFont fontWithName:@"HelveticaNeue-Bold" size:14]
#define BTN_CENTERED CGRectMake(kCenteredX - kBtnWidth/2, kBtnY, kBtnWidth, kBtnHeight)
#define BTN_RIGHT CGRectMake(kX + kBtnWidth + 20, kBtnY, kBtnWidth, kBtnHeight)
#define BTN_LEFT CGRectMake(kX, kBtnY, kBtnWidth, kBtnHeight)


@implementation ALFSAlert

#pragma mark - Init methods

//Init ALFSAlert object using initInViewController:viewController 
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [NSException raise:@"init exception" format:@"Use ONLY initInViewController:viewController to init OBAlert object"];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [NSException raise:@"init exception" format:@"Use ONLY initInViewController:viewController to init OBAlert object"];
    }
    return self;
}

//Get the instance of the calling view controller and create the overlay
- (id)initInViewController:(UIViewController *)viewController {
    self = [super initWithFrame:viewController.view.bounds];
    if (self) {
        parentViewController = viewController;
        overlay = [[UIView alloc] initWithFrame:self.frame];
        [overlay setBackgroundColor:[UIColor colorWithWhite:0 alpha:.8]];
        subviews = [[NSMutableArray alloc] init];
        numberOfButtons = 0;
        isShown = NO;
    }
    return self;
}

#pragma mark - Build user interface

//Create the message label
- (void)buildUIWithAlertText:(NSString *)alertText {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    message = [[UILabel alloc] init];
    CGSize textSize = [alertText sizeWithFont:font constrainedToSize:CGSizeMake(kMessageWidth, kMessageMaxHeight) lineBreakMode:message.lineBreakMode];
    CGFloat y = kMessageMaxHeight/2 - textSize.height/2;
    [message setFrame:CGRectMake(kX, y, kMessageWidth, textSize.height)];
    [message setFont:font];
    [message setBackgroundColor:[UIColor clearColor]];  
    [message setTextColor:[UIColor whiteColor]];
    [message setText:alertText];
    [message setTextAlignment:NSTextAlignmentCenter];
    [message setNumberOfLines:kNumberOfLines];
}

#pragma mark - Add buttons to alert

//Add buttons to the alert, max 2 buttons
- (void)addButtonWithText:(NSString *)text forType:(ALFSAlertButtonType)type onTap:(void (^)(void))block {
    //If there are 2 buttons yet, throw an exception, else create the button
    if (numberOfButtons == 2 ) {
        [NSException raise:@"Maximum number of buttons" format:@"This alert provides a maximum of 2 buttons"];
    } else {
        if (!isShown) {
            [NSException raise:@"Alert not shown" format:@"You cannot add buttons to an alert that is not already shown"];
        }
        //Create button instance and control which type it is (delete button or normal button)
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (type == ALFSAlertButtonTypeNormal) {
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        } else {
            [button setBackgroundColor:[UIColor redColor]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        }
        [button.layer setCornerRadius:2];
        [[button titleLabel] setFont:BTN_FONT];
        [button setTitle:text forState:UIControlStateNormal];
        if (block != nil) {
            [button setAction:kUIButtonBlockTouchUpInside withBlock:block];
        }
        //If this is the 1st button, place it in center of the view, else place the last one to the right and the first one to the left
        if (numberOfButtons == 0) {
            buttons = [[NSMutableArray alloc] init];
            button.frame = BTN_CENTERED;
        } else if (numberOfButtons == 1) {
            button.frame = BTN_RIGHT;
            UIButton *previousBtn = [buttons objectAtIndex:0];
            previousBtn.frame = BTN_LEFT;
        }
        numberOfButtons++;
        [buttons addObject:button];
        [parentViewController.view addSubview:button];
        [subviews addObject:button];
    }
}

#pragma mark - Show the alert

//Show the alert in the view
- (void)showAlertWithMessage:(NSString *)alertText {
    [self buildUIWithAlertText:alertText];
    
    [parentViewController.view addSubview:overlay];
    [subviews addObject:overlay];
    
    [parentViewController.view addSubview:message];
    [subviews addObject:message];
    
    isShown = YES;
}

- (void)removeAlert {
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    isShown = NO;
}

@end
