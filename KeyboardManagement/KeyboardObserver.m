//
//  KeyboardObserver.m
//  KeyboardManagement
//
//  Created by Yongwei.Chen on 6/16/14.
//  Copyright (c) 2014 EF. All rights reserved.
//

#import "KeyboardObserver.h"
#import "BaseKeyboardHandler.h"
#import "UIScrollViewKeyboardHandler.h"
#import "UIViewKeyboardHandler.h"

@implementation KeyboardObserver
{
    BaseKeyboardHandler *keyboardHandler;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)observeView:(UIView *)view inMainView:(UIView *)mainView
{
    if ([[view class] isSubclassOfClass:[UIScrollView class]]) {
        keyboardHandler = [[UIScrollViewKeyboardHandler alloc] init];
    }
    else
    {
        keyboardHandler = [[UIViewKeyboardHandler alloc] init];
    }

    keyboardHandler.mainView = mainView;
    keyboardHandler.observeView = view;
    [self addObserverHandler:keyboardHandler forUITextField:view];
}


-(void)addObserverHandler:(BaseKeyboardHandler *)handler forUITextField:(UIView *)view
{
    if ([[view class] isSubclassOfClass:[UITextField class]]) {
        ((UITextField *)view).delegate = handler;
    }
    else {
        for (UIView *subview in [view subviews]) {
            [self addObserverHandler:handler forUITextField:subview];
        }
    }
}

-(void)dealloc
{
    NSLog(@"KeyboardObserver dealloced, please try to hold the instance in your class. For example, put it as private variable");
}

@end
