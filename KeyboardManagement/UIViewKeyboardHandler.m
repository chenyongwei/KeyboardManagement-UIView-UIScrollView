//
//  UIViewKeyboardHandler.m
//  KeyboardManagement
//
//  Created by Yongwei.Chen on 6/16/14.
//  Copyright (c) 2014 EF. All rights reserved.
//

#import "UIViewKeyboardHandler.h"

@implementation UIViewKeyboardHandler
{
    int viewHeight; // for UIVIew as container
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    viewHeight = self.mainView.frame.size.height;
    NSDictionary *info = [aNotification userInfo];
    kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [self adjustFrame];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.5f animations:^{
        self.observeView.frame = CGRectMake(self.mainView.frame.origin.x, 0, CGRectGetWidth(self.mainView.frame), viewHeight);
    }];
}

-(void)adjustFrame
{
    CGRect aRect = self.mainView.frame;
    aRect.size.height -= kbSize.height;
    CGRect targetFrame = CGRectMake(activeField.frame.origin.x, activeField.frame.origin.y + space, CGRectGetWidth(activeField.frame), CGRectGetHeight(activeField.frame));
    if (!CGRectContainsPoint(aRect, targetFrame.origin) ) {
        int moveUp = activeField.frame.origin.y + space -kbSize.height;
        int newHeight = viewHeight + moveUp;
        [UIView animateWithDuration:0.5f animations:^{
            self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, -moveUp, CGRectGetWidth(self.mainView.frame), newHeight);
        }];
    }
}

@end
