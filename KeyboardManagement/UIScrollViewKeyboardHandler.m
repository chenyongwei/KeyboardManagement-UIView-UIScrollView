//
//  UIScrollViewKeyboardHandler.m
//  KeyboardManagement
//
//  Created by Yongwei.Chen on 6/16/14.
//  Copyright (c) 2014 EF. All rights reserved.
//

#import "UIScrollViewKeyboardHandler.h"


@implementation UIScrollViewKeyboardHandler

// Called when the UIKeyboardDidShowNotification is sent.
-(void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [self adjustFrame];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIScrollView *scrollView = (UIScrollView *)self.observeView;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

-(void)adjustFrame
{
    UIScrollView *scrollView = (UIScrollView *)self.observeView;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + space, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it s  o it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.mainView.frame;
    aRect.size.height -= kbSize.height;
    CGRect targetFrame = CGRectMake(activeField.frame.origin.x, activeField.frame.origin.y + space, CGRectGetWidth(activeField.frame), CGRectGetHeight(activeField.frame));
    if (!CGRectContainsPoint(aRect, targetFrame.origin) ) {
        [scrollView scrollRectToVisible:targetFrame animated:YES];
    }
}

@end
