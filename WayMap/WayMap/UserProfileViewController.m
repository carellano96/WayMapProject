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
@property (weak, nonatomic) IBOutlet UIImageView *ProfilePicture;

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation UserProfileViewController

@synthesize userAddedPlaces, favoritePlaces;

/*
 Instantiate the current user, pulling data from Firebase of the places they have favorited and the places they have added on their own.
 */
-(void) viewWillAppear:(BOOL)animated{
    [userAddedPlaces removeAllObjects];
    [favoritePlaces removeAllObjects];
    self.tabBarController.delegate=self;
    FIRUser *user = [FIRAuth auth].currentUser;
    
    self.ref = [[FIRDatabase database] reference];
    
    [[[[_ref child:@"users"] child:user.uid] child:@"Places Added"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        
        for (FIRDataSnapshot *addedPlace in snapshot.children){
            NSString *key = addedPlace.key;
            NSDictionary *addedPlacesDict = addedPlace.value;
            [addedPlacesDict objectForKey:key];
            [userAddedPlaces addObject:[addedPlacesDict objectForKey:@"Name"]];
            
        }
        
    }];
    
    [[[[_ref child:@"users"] child:user.uid] child:@"Favorite Places"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        
        for (FIRDataSnapshot *favoritePlace in snapshot.children){
            NSString *key = favoritePlace.key;
            NSDictionary *favoritePlacesDict = favoritePlace.value;
            [favoritePlacesDict objectForKey:key];
            [favoritePlaces addObject:[favoritePlacesDict objectForKey:@"Name"]];
        }
    }];
    
}

/*
 Initialize arrays to store the names of the user's added places and their favorite places, so that this data may be passed to the UserData View Controller
 */
- (void)viewDidLoad {
    
    userAddedPlaces = [[NSMutableArray alloc]init];
    favoritePlaces = [[NSMutableArray alloc]init];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Pass all of the user's data that was retrieved in this view controller into the user data VC, depending on which segue is happening (aka whethere the Favorites or the User Added button was pressed)
 */
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

/*
 Methods to allow the user to upload a profile photo either by opening their camera and taking on themselves, or choosing from their camera rolls.
 */
- (IBAction)ProfilePictureUpload:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Set Profile Picture" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped
        [actionSheet dismissViewControllerAnimated:YES completion:NULL];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController*pics =[[UIImagePickerController alloc ]init];
        pics.delegate=self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            pics.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        }
        [self presentViewController:pics animated:YES completion:NULL];
        // Photo Library button tapped.

    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // camera button tapped.
        UIImagePickerController*camera =[[UIImagePickerController alloc ]init];
        camera.delegate = self;
        camera.allowsEditing=YES;
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:camera animated:YES completion:NULL];
        
        

    }]];
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

        self.ProfilePicture.image=[info objectForKey:UIImagePickerControllerEditedImage];
        [self dismissViewControllerAnimated:YES completion:NULL];


    
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]){
        UINavigationController*Tips1 = (UINavigationController*)viewController;
        if ([Tips1.visibleViewController isKindOfClass:[TipsFirstTableViewController class]]){TipsFirstTableViewController*Tips=(TipsFirstTableViewController*)Tips1.visibleViewController;
            //Tips.NearbyLocations=self.LocationsNearby;
            //Tips.userLocation=self.userLocation;
            Tips.index=1;
            NSLog(@"Switching view controllers to TipsFirst");
        }
        else{
            NSLog(@"Type of current view %@",NSStringFromClass([Tips1.visibleViewController class]));
        }
    }
    else{
        NSLog(@"very confused");
    }
    return YES;
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}




@end
