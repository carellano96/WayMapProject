//
//  UserProfileViewController.m
//  WayMap
//
//  Created by Jean Jeon on 4/22/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserDataTableViewController.h"
@import FirebaseDatabase;
@import Firebase;
@import FirebaseAuth;
@interface UserProfileViewController ()

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRDatabaseReference *userAddedref;
@property (nonatomic) FIRDatabaseHandle *favoritesRef;
@property (nonatomic) NSMutableArray *favoritePlaces;

@end

@implementation UserProfileViewController

@synthesize userAddedPlaces, testLabel;

-(void)configure:(NSString *)field {
    
    testLabel.text = field;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FIRUser *user = [FIRAuth auth].currentUser;
    
    userAddedPlaces = [[NSMutableArray alloc]init];
    
    self.ref = [[FIRDatabase database] reference];
    
    [[[[_ref child:@"users"] child:user.uid] child:@"Places Added"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        
        for (FIRDataSnapshot *place in snapshot.children){
            NSString *key = place.key;
            NSDictionary *placesDict = place.value;
            [placesDict objectForKey:key];
            [self configure:[placesDict objectForKey:@"Name"]];
            [userAddedPlaces addObject:[placesDict objectForKey:@"Name"]];
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UserDataTableViewController *UDVC;
    UDVC = [segue destinationViewController];
    UDVC.userAddedPlaces= userAddedPlaces;
}

@end
