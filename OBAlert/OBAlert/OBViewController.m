//
//  OBViewController.m
//  OBAlert
//
//  Created by Onur Baykal on 15.09.2013.
//  Copyright (c) 2013 Onur Baykal. All rights reserved.
//

#import "OBViewController.h"

@interface OBViewController ()

@end

@implementation OBViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    OBAlert * alert = [[OBAlert alloc] initInViewController:self];
    [alert showAlertWithText:@"You can download music from the iTunes Store" titleText:@"No Content" buttonText:@"Store" onTap:^{
        [alert removeAlert];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
