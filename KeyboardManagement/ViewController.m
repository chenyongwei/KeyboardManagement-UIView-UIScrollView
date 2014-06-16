//
//  ViewController.m
//  KeyboardManagement
//
//  Created by Yongwei on 6/16/14.
//  Copyright (c) 2014 EF. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+UITouchEvent.h"

/* https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html */

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController
{
    UITextField *activeField;
    CGSize kbSize;
    int viewHeight;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self registerForKeyboardNotifications];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    viewHeight = self.view.frame.size.height;
    NSDictionary *info = [aNotification userInfo];
    kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [self updateView];
    [self updateViewForUIView];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    [UIView animateWithDuration:0.5f animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x, 0, CGRectGetWidth(self.view.frame), viewHeight);
    }];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    [self updateView];
    [self updateViewForUIView];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

-(void)updateView
{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 10, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it s  o it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGRect targetFrame = CGRectMake(activeField.frame.origin.x, activeField.frame.origin.y + 10, CGRectGetWidth(activeField.frame), CGRectGetHeight(activeField.frame));
    if (!CGRectContainsPoint(aRect, targetFrame.origin) ) {
        [self.scrollView scrollRectToVisible:targetFrame animated:YES];
    }
}


-(void)updateViewForUIView
{
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGRect targetFrame = CGRectMake(activeField.frame.origin.x, activeField.frame.origin.y + 10, CGRectGetWidth(activeField.frame), CGRectGetHeight(activeField.frame));
    if (!CGRectContainsPoint(aRect, targetFrame.origin) ) {
        int moveUp = activeField.frame.origin.y + 10 -kbSize.height;
        int newHeight = viewHeight + moveUp;
        [UIView animateWithDuration:0.5f animations:^{
            self.view.frame = CGRectMake(self.view.frame.origin.x, -moveUp, CGRectGetWidth(self.view.frame), newHeight);
        }];
    }
}

-(void)updateView2
{
    CGRect bkgndRect = activeField.superview.frame;
    bkgndRect.size.height += kbSize.height;
    [activeField.superview setFrame:bkgndRect];
    [self.scrollView setContentOffset:CGPointMake(0.0, activeField.frame.origin.y-kbSize.height) animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
