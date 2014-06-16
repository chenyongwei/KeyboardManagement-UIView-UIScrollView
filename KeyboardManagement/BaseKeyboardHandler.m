//
//  BaseKeyboardHandler.m
//  KeyboardManagement
//
//  Created by Yongwei.Chen on 6/16/14.
//  Copyright (c) 2014 EF. All rights reserved.
//

#import "BaseKeyboardHandler.h"

@implementation BaseKeyboardHandler

-(id)init
{
    self = [super init];
    if (self) {
        space = 30;
        [self registerForKeyboardNotifications];
    }
    return self;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    [self adjustFrame];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.5f animations:^{
        [textField resignFirstResponder];
    }];
    return YES;
}

-(void)keyboardWasShown:(NSNotification*)aNotification
{
    // should be implemented in child class
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    // should be implemented in child class
}

-(void)adjustFrame
{
    // should be implemented in child class
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@ selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
