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
@property (strong) FIRAuth *handle;

@end

@implementation LogInViewController

@synthesize isSignIn, ErrorLabel, emailTextField, passwordTextField;

- (void) viewWillAppear:(BOOL)animated{
    self.handle = [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                   }];
}

//testcase
- (void)viewDidLoad {
    [super viewDidLoad];
    [ErrorLabel setHidden:YES];
    isSignIn = true;
    
    emailTextField.delegate = self;
    passwordTextField.delegate = self;
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [emailTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    return true;
}

- (void)viewWillDisappear:(BOOL)animated {
    [[FIRAuth auth] removeAuthStateDidChangeListener:_handle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Change label of Sign In button if "Register" is clicked
- (IBAction)RegisterClicked:(UISegmentedControl *)sender {
    [ErrorLabel setHidden:YES];
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
    if(emailTextField.text && passwordTextField.text.length > 0){
        if(isSignIn){
            //Sign in the user using Firebase

            [[FIRAuth auth] signInWithEmail:emailTextField.text
                                   password:passwordTextField.text
                                 completion:^(FIRUser *user, NSError *error) {
                                     
                        /*Check that the user exists - if sign in was successful, then Firebase should be able
                        to retrieve a user for us */
                                     if(user){
                                         [self performSegueWithIdentifier:@"SignInSegue" sender:self];
                                     }
                                     else{
                                         NSString *errorMsg = [error localizedDescription];
                                         [ErrorLabel setText: errorMsg];
                                         [ErrorLabel setHidden:NO];
                                     }
                                 }];
        }
        
        else{
            //Register the user with Firebase
            [[FIRAuth auth] createUserWithEmail:emailTextField.text
                                       password:passwordTextField.text
                                     completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
                                        
                                         if(error){
                                             NSString *errorMsg = [error localizedDescription];
                                             [ErrorLabel setText: errorMsg];
                                             [ErrorLabel setHidden:NO];
                                         }
                                         
                                         else{
                                             [[FIRAuth auth].currentUser sendEmailVerificationWithCompletion:^(NSError *_Nullable error) {
                                                 
                                             }];
                                             
                                             [self performSegueWithIdentifier:@"RegisterSegue" sender:self];
                                         }
                                     }];
            
        }
    }
    
}

- (IBAction)forgotPWTapped:(UIButton *)sender {
    [[FIRAuth auth] sendPasswordResetWithEmail:emailTextField.text completion:^(NSError *_Nullable error) {
        if(error){
            NSString *errorMsg = [error localizedDescription];
            [ErrorLabel setText: errorMsg];
            [ErrorLabel setHidden:NO];
        }
        else{
            [ErrorLabel setText: @"Password Reset has been sent to the email associated with this account"];
            [ErrorLabel setHidden:NO];
        }
    }];
}


@end
