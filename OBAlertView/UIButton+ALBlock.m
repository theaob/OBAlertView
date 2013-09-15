//
//  UIButton+ALBlock.m
//  ALFullScreenAlert
//
//  Created by Andrea Mario Lufino on 04/07/13.
//  Copyright (c) 2013 Andrea Mario Lufino. All rights reserved.
//

// Based on Josh Holtz category
// You can find it here :
// https://gist.github.com/joshdholtz/2468899
// See UIButton+Block.m

#import "UIButton+ALBlock.h"
#import "/usr/include/objc/runtime.h"

@implementation UIButton (ALBlock)

static char overviewKey;

@dynamic actions;

- (void) setAction:(NSString*)action withBlock:(void(^)())block {
    
    if ([self actions] == nil) {
        [self setActions:[[NSMutableDictionary alloc] init]];
    }
    
    [[self actions] setObject:block forKey:action];
    
    if ([kUIButtonBlockTouchUpInside isEqualToString:action]) {
        [self addTarget:self action:@selector(doTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setActions:(NSMutableDictionary*)actions {
    objc_setAssociatedObject (self, &overviewKey,actions,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary*)actions {
    return objc_getAssociatedObject(self, &overviewKey);
}

- (void)doTouchUpInside:(id)sender {
    void(^block)();
    block = [[self actions] objectForKey:kUIButtonBlockTouchUpInside];
    block();
}

@end
