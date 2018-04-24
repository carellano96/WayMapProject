//
//  LogInViewController.m
//  WayMap
//
//  Created by Jean Jeon on 4/22/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "LogInViewController.h"
#import "AppDelegate.h"

@import FirebaseAuth;
@import Firebase;

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *signInSelector;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@end

@implementation LogInViewController

@synthesize isSignIn;

//testcase
- (void)viewDidLoad {
    [super viewDidLoad];
    isSignIn = true;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)RegisterClicked:(UISegmentedControl *)sender {
    isSignIn = !isSignIn;
    
    if(isSignIn){
        [_signInButton setTitle:@"SIGN IN" forState:normal];
    }
    else{
        [_signInButton setTitle:@"REGISTER" forState:normal];
    }
}

- (IBAction)signInButtonTapped:(UIButton *)sender {
    
    
    //Make sure the email and password text fields are NOT empty
    if(_emailTextField.text && _passwordTextField.text.length > 0){
        if(isSignIn){
            //Sign in the user using Firebase
            [[FIRAuth auth] signInWithEmail:_emailTextField.text
                                   password:_passwordTextField.text
                                 completion:^(FIRUser *user, NSError *error) {
                                 }];
        
            /*Check that user isn't nil - if sign in was successful, then Firebase should be able
            to retrieve a user for us */
            //FIRUser *user;
            if([FIRAuth auth].currentUser != nil){
                 [self performSegueWithIdentifier:@"SignInSegue" sender:self];
            }
            
        }
    
        else{
            //Register the user with Firebase
            [[FIRAuth auth] createUserWithEmail:_emailTextField.text
                                       password:_passwordTextField.text
                                     completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
                                     }];
            
            [self performSegueWithIdentifier:@"RegisterSegue" sender:self];
            
        }
    }
     

    
}

@end
