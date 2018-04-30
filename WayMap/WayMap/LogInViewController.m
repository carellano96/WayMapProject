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

/*
 IBOutlets for later use
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *signInSelector;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (strong) FIRAuth *handle;

@end

@implementation LogInViewController

/*
 Synthesize Properties for programming convenience
 */
@synthesize isSignIn, ErrorLabel, emailTextField, passwordTextField;

/*
 Use Firebase listener to make sure that every time the Log-In VC is refreshed, the data it contains in the text fields is reloaded as well
 */
- (void) viewWillAppear:(BOOL)animated{
    self.handle = [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                   }];
}

/*
 - Set the Boolean isSignIn as true initially, because the Log-In VC always starts with the segmented control on "Sign In," not "Register."
 - Set the Error Label as hidden at first because the user has not made any mistakes in signing up or registering.
 - Set both email and password text fields' delegates to self so that the user may be givn permission to write data.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [ErrorLabel setHidden:YES];
    isSignIn = true;
    
    emailTextField.delegate = self;
    passwordTextField.delegate = self;
    
}

/*
 Hide the user's keyboard when they hit return.
 */
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [emailTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    return true;
}

/*
 Change listener initialized in viewWillAppear method - clearing data.
 */
- (void)viewWillDisappear:(BOOL)animated {
    [[FIRAuth auth] removeAuthStateDidChangeListener:_handle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
Change title of Sign In button to "Register" if "Register" is clicked on segmented control
 */
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
    
    /*
     Make sure the email and password text fields are NOT empty
     */
    if(emailTextField.text && passwordTextField.text.length > 0){
        if(isSignIn){
            /*
             Sign in the user using Firebase
             */
            [[FIRAuth auth] signInWithEmail:emailTextField.text
                                   password:passwordTextField.text
                                 completion:^(FIRUser *user, NSError *error) {
                        /*
                         Check that the user exists - if sign in was successful, then Firebase should be able
                        to retrieve a user and their data for us
                         */
                                     if(user){
                                         [self performSegueWithIdentifier:@"SignInSegue" sender:self];
                                     }
                                     /*
                                      If the user does not exist or the sign-in was not successful, then let the user know what went wrong (e.g. wrong password or e-mail)
                                      */
                                     else{
                                         NSString *errorMsg = [error localizedDescription];
                                         [ErrorLabel setText: errorMsg];
                                         [ErrorLabel setHidden:NO];
                                     }
                                 }];
        }
        
        else{
            /* Register the user with Firebase */
            [[FIRAuth auth] createUserWithEmail:emailTextField.text
                                       password:passwordTextField.text
                                     completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
                                        /*
                                         If there was an error in registering them, let the user know wheat the error was by changing the text inside of the error label (e.g. password is not long enough
                                         */
                                         if(error){
                                             NSString *errorMsg = [error localizedDescription];
                                             [ErrorLabel setText: errorMsg];
                                             [ErrorLabel setHidden:NO];
                                         }
                                         /*
                                          If the user was successfully registered, send the user a verification email to the email they used to register for an account
                                          */
                                         else{
                                             [[FIRAuth auth].currentUser sendEmailVerificationWithCompletion:^(NSError *_Nullable error) {
                                                 
                                             }];
                                             /*
                                              Perform segue to the Register View Controller to let the newly registered user know that registration has been successful
                                              */
                                             [self performSegueWithIdentifier:@"RegisterSegue" sender:self];
                                         }
                                     }];
            
        }
    }
    
}
/*
 If the user taps the "Forgot Password?" button, then they are sent a verification email to the email associated with their account, provided that there are no errors (such as the user not existing)
 */
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
