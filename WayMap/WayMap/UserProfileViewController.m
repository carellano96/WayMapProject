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
@property (nonatomic) FIRDatabaseHandle *favoritesRef;

@end

@implementation UserProfileViewController

@synthesize userAddedPlaces, favoritePlaces, testLabel, favoritesHit, userAddedHit;

-(void)configure:(NSString *)field {
    
    testLabel.text = field;
}
-(void) viewDidAppear:(BOOL)animated{
    
    userAddedHit = false;
    favoritesHit = false;
    
    FIRUser *user = [FIRAuth auth].currentUser;
    
    userAddedPlaces = [[NSMutableArray alloc]init];
    favoritePlaces = [[NSMutableArray alloc]init];
    
    self.ref = [[FIRDatabase database] reference];
    
    [[[[_ref child:@"users"] child:user.uid] child:@"Places Added"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        
        for (FIRDataSnapshot *addedPlace in snapshot.children){
            NSString *key = addedPlace.key;
            NSDictionary *addedPlacesDict = addedPlace.value;
            [addedPlacesDict objectForKey:key];
            [self configure:[addedPlacesDict objectForKey:@"Name"]];
            [userAddedPlaces addObject:[addedPlacesDict objectForKey:@"Name"]];
        }
        
    }];
    
    [[[[_ref child:@"users"] child:user.uid] child:@"Favorite Places"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        
        for (FIRDataSnapshot *favoritePlace in snapshot.children){
            NSString *key = favoritePlace.key;
            NSDictionary *favoritePlacesDict = favoritePlace.value;
            [favoritePlacesDict objectForKey:key];
            [self configure:[favoritePlacesDict objectForKey:@"Name"]];
            [favoritePlaces addObject:[favoritePlacesDict objectForKey:@"Name"]];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)favoritesBtnPressed:(UIButton *)sender {
    favoritesHit = true;
    
}

- (IBAction)userAddedBtnPressed:(UIButton *)sender {
    userAddedHit = true;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UserDataTableViewController *UDVC;
    UDVC = [segue destinationViewController];
    UDVC.userAddedPlaces= userAddedPlaces;
    UDVC.favoritePlaces = favoritePlaces;
    UDVC.favoritesHit = favoritesHit;
    UDVC.userAddedHit = userAddedHit;
}

@end
