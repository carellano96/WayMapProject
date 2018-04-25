//
//  UserProfileViewController.m
//  WayMap
//
//  Created by Jean Jeon on 4/22/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "UserProfileViewController.h"
@import FirebaseDatabase;
@import Firebase;
@import FirebaseAuth;
@interface UserProfileViewController ()
    
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (nonatomic) FIRDatabaseHandle *refHandle;
@property (nonatomic) FIRDatabaseReference *postRef;
@property (nonatomic) NSMutableArray *Favorites;

@end

@implementation UserProfileViewController

@synthesize placesVisitedTest;

-(void)configure:(NSString *)field {
    
    placesVisitedTest.text = field;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    FIRUser *user = [FIRAuth auth].currentUser;
    [[[[_ref child:@"users"] child:user.uid] child:@"Places Added"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSDictionary *placesDict = snapshot.value;
        
        NSLog(@"%@",placesDict);
        
        [placesDict objectForKey:@"Places Added"];
        
        [self configure:[placesDict objectForKey:@"Name"]];
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
