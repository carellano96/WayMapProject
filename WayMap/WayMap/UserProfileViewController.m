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

@synthesize testLabel, userAddedPlaces, favoritePlaces;

-(void)configure:(NSString *)field {
    
    testLabel.text = field;
}
-(void) viewWillAppear:(BOOL)animated{
    [userAddedPlaces removeAllObjects];
    [favoritePlaces removeAllObjects];
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
    
    userAddedPlaces = [[NSMutableArray alloc]init];
    favoritePlaces = [[NSMutableArray alloc]init];
    [super viewDidLoad];
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

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}




@end
