//
//  UserProfileViewController.m
//  WayMap
//
//  Created by Jean Jeon and Carlos Arellanoon 4/22/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserDataTableViewController.h"
@import FirebaseDatabase;
@import Firebase;
@import FirebaseAuth;
@interface UserProfileViewController ()

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation UserProfileViewController

@synthesize testLabel, userAddedPlaces, favoritePlaces;

-(void)configure:(NSString *)field {
    
    testLabel.text = field;
}
-(void) viewWillAppear:(BOOL)animated{
    
    FIRUser *user = [FIRAuth auth].currentUser;
    
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
    userAddedPlaces = [[NSMutableArray alloc]init];
    favoritePlaces = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"favoritesSegue"]){
        UserDataTableViewController *UDVC;
        UDVC = [segue destinationViewController];
        UDVC.userAddedPlaces = userAddedPlaces;
        UDVC.favoritePlaces = favoritePlaces;
        UDVC.favoritesHit = true;
        UDVC.userAddedHit = false;
        
    }
    
    else if([segue.identifier isEqualToString:@"userAddedSegue"]){
        UserDataTableViewController *UDVC;
        UDVC = [segue destinationViewController];
        UDVC.userAddedPlaces = userAddedPlaces;
        UDVC.favoritePlaces = favoritePlaces;
        UDVC.favoritesHit = false;
        UDVC.userAddedHit = true;
    }
    
}

@end
