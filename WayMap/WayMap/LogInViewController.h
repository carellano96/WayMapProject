//
//  LogInViewController.h
//  WayMap
//
//  Created by Jean Jeon and Carlos Arellano on 4/22/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController <UITextFieldDelegate>

/*
 Set properties and IBOutlets for later use
 */
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) IBOutlet UILabel *ErrorLabel;
@property (nonatomic) Boolean isSignIn;
@property (weak, nonatomic) IBOutlet UIButton *forgotPW;

@end
