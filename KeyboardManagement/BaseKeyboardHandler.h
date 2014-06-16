//
//  BaseKeyboardHandler.h
//  KeyboardManagement
//
//  Created by Yongwei.Chen on 6/16/14.
//  Copyright (c) 2014 EF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseKeyboardHandler : NSObject <UITextFieldDelegate>
{
    int space; // the space between UITextField and Keyboard top
    CGSize kbSize;
    
    UITextField *activeField;
}

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *observeView;

-(void)keyboardWasShown:(NSNotification*)aNotification;
-(void)keyboardWillBeHidden:(NSNotification*)aNotification;

-(void)adjustFrame;

@end
