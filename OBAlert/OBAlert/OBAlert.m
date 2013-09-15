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
#define kMessageWidth 200
#define kTitleMaxHeight 300
#define kTitleWidth 200
#define kX 55
#define kCenteredX 320/2
#define kBtnWidth (kMessageWidth)/2
#define kBtnY message.frame.origin.y + message.frame.size.height + 30
#define kBtnHeight 24

#define BTN_FONT [UIFont fontWithName:@"HelveticaNeue-Bold" size:12]
#define BTN_CENTERED CGRectMake(kCenteredX - kBtnWidth/2, kBtnY, kBtnWidth, kBtnHeight)


@implementation OBAlert

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
        [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
        subviews = [[NSMutableArray alloc] init];
        isShown = NO;
    }
    return self;
}

#pragma mark - Build user interface

//Create the message label
- (void)showAlertWithText:(NSString *)alertText titleText:(NSString *)titleText buttonText:(NSString *)buttonText onTap:(void (^)(void))block
{
    isShown = YES;

    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    message = [[UILabel alloc] init];
    CGSize textSize = [alertText sizeWithFont:font constrainedToSize:CGSizeMake(kMessageWidth, kMessageMaxHeight) lineBreakMode:message.lineBreakMode];
    CGFloat y = kMessageMaxHeight/2 - textSize.height/2;
    [message setFrame:CGRectMake(kX, y, kMessageWidth, textSize.height)];
    [message setFont:font];
    [message setBackgroundColor:[UIColor clearColor]];  
    [message setTextColor:[UIColor grayColor]];
    [message setText:alertText];
    [message setTextAlignment:NSTextAlignmentCenter];
    [message setNumberOfLines:kNumberOfLines];
    
    title = [[UILabel alloc] init];
    CGSize titleSize = [titleText sizeWithFont:font constrainedToSize:CGSizeMake(kTitleWidth, kTitleMaxHeight) lineBreakMode:title.lineBreakMode];
    y = kTitleMaxHeight/2 - titleSize.height/2;
    [title setFrame:CGRectMake(kX, y, kTitleWidth, titleSize.height)];
    UIFont * titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
    [title setFont:titleFont];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextColor:[UIColor grayColor]];
    [title setText:titleText];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setNumberOfLines:1];
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [button.layer setCornerRadius:2];
    [[button titleLabel] setFont:BTN_FONT];
    [button setTitle:buttonText forState:UIControlStateNormal];
    
    if (block != nil)
    {
        [button setAction:kUIButtonBlockTouchUpInside withBlock:block];
    }
    
    button.frame = BTN_CENTERED;
    [parentViewController.view addSubview:overlay];
    [parentViewController.view addSubview:message];
    [parentViewController.view addSubview:title];
    [parentViewController.view addSubview:button];
    [subviews addObject:overlay];
    [subviews addObject:message];
    [subviews addObject:title];
    [subviews addObject:button];
}

- (void)removeAlert {
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    isShown = NO;
}

@end

