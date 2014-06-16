//
//  ViewController.m
//  KeyboardManagement
//
//  Created by Yongwei on 6/16/14.
//  Copyright (c) 2014 EF. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardObserver.h"
#import "UIScrollView+UITouchEvent.h"

//https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html

// UIScrollView: Please make sure the scrollView is layout with 'AutoLayout' and FullScreen

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView; // for UIScrollView as container

@end

@implementation ViewController
{
    KeyboardObserver *ob; // put here to in order to retain it.
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    ob = [[KeyboardObserver alloc] init];
    if (self.scrollView) {
        [ob observeView:self.scrollView inMainView:self.view];
    }
    else {
        [ob observeView:self.view inMainView:self.view];
    }
    
}

// please #import "UIScrollView+UITouchEvent.h" if you want to support UIScrollView touch to hide keyboard
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end
