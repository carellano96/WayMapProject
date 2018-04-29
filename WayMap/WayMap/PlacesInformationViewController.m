//
//  PlacesInformationViewController.m
//  WayMap
//
//  Created by Carlos Arellano and Jean Jeon on 4/18/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "PlacesInformationViewController.h"
#import "AppDelegate.h"
@import FirebaseAuth;
@import FirebaseDatabase;

@interface PlacesInformationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *ReturnMaps;
@property (weak, nonatomic) IBOutlet UILabel *BasedOn;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRDatabaseReference *updateRef;

@end

@implementation PlacesInformationViewController
@synthesize SelectedPlace,segueUsed,sourceArrayName,UserAddedTitle,CheckedInLocations, favoriteBtn, favoritedLabel, placeNameLabel, placeAddressLabel, OneStarFull, OneStarEmpty, TwoStarsFull, TwoStarsEmpty, ThreeStarsFull, ThreeStarsEmpty, FourStarsFull, FourStarsEmpty, FiveStarsFull, FiveStarsEmpty, userPlaceRating, fullStarsArray, emptyStarsArray, backBarButtonItem, buttonsArray, oneStarBtn, TwoStarsBtn, ThreeStarsBtn, FourStarsBtn, FiveStarsBtn;

- (IBAction)oneStarBtnPressed:(UIButton *)sender {
    
    static int numberOfTimesPressed = 1;
    numberOfTimesPressed ++;
    if(numberOfTimesPressed % 2 == 0){
        [OneStarFull setHidden:NO];
        [OneStarEmpty setHidden:YES];
        userPlaceRating = [NSNumber numberWithInt:1];
    }
    else{
        [OneStarFull setHidden:YES];
        [OneStarEmpty setHidden:NO];
        userPlaceRating = [NSNumber numberWithInt:0];
    }
}

- (IBAction)twoStarBtnPressed:(UIButton *)sender {
    
    static int numberOfTimesPressed = 1;
    numberOfTimesPressed ++;
    if(numberOfTimesPressed % 2 == 0){
        
        for(int i = 0; i < 2; i++){
            [[fullStarsArray objectAtIndex:i] setHidden:NO];
            [[emptyStarsArray objectAtIndex:i] setHidden:YES];
        }
        userPlaceRating = [NSNumber numberWithInt:2];
    }
    else{
        [FourStarsFull setHidden:YES];
        [FourStarsEmpty setHidden:NO];
        userPlaceRating = [NSNumber numberWithInt:1];
    }
}

- (IBAction)ThreeStarBtnPressed:(UIButton *)sender {
    
    static int numberOfTimesPressed = 1;
    numberOfTimesPressed ++;
    if(numberOfTimesPressed % 2 == 0){
        
        for(int i = 0; i < 3; i++){
            [[fullStarsArray objectAtIndex:i] setHidden:NO];
            [[emptyStarsArray objectAtIndex:i] setHidden:YES];
        }
        userPlaceRating = [NSNumber numberWithInt:3];
    }
    else{
        [ThreeStarsFull setHidden:YES];
        [ThreeStarsEmpty setHidden:NO];
        userPlaceRating = [NSNumber numberWithInt:2];
    }
}

- (IBAction)FourStarBtnPressed:(UIButton *)sender {
    
    static int numberOfTimesPressed = 1;
    numberOfTimesPressed ++;
    if(numberOfTimesPressed % 2 == 0){
        
        for(int i = 0; i < 4; i++){
            [[fullStarsArray objectAtIndex:i] setHidden:NO];
            [[emptyStarsArray objectAtIndex:i] setHidden:YES];
        }
        userPlaceRating = [NSNumber numberWithInt:4];
    }
    else{
        [FourStarsFull setHidden:YES];
        [FourStarsEmpty setHidden:NO];
        userPlaceRating = [NSNumber numberWithInt:3];
    }
}

- (IBAction)FiveStarBtnPressed:(UIButton *)sender {
    static int numberOfTimesPressed = 1;
    numberOfTimesPressed ++;
    
    //If star is pressed at an even number (e.g. for a second time), then it reverts back to being empty
    if(numberOfTimesPressed % 2 == 0){
        
        for(int i = 0; i < 5; i++){
            [[fullStarsArray objectAtIndex:i] setHidden:NO];
            [[emptyStarsArray objectAtIndex:i] setHidden:YES];
        }
        userPlaceRating = [NSNumber numberWithInt:5];
    }
    else{
        [FiveStarsFull setHidden:YES];
        [FiveStarsEmpty setHidden:NO];
        userPlaceRating = [NSNumber numberWithInt:4];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"pushing back to da maps");
}
- (IBAction)CheckIntoPlace:(id)sender {
    //check in

    SelectedPlace.CheckedIn=true;
    _CheckInButton.hidden=true;
    _IsCheckedIn.hidden=false;
    FIRUser *user = [FIRAuth auth].currentUser;
    _updateRef = [[[[self.ref child:@"users"] child:user.uid] child:@"Places Visited"] childByAutoId];
    [[_updateRef child:@"Name"] setValue:placeNameLabel.text];
    [[_updateRef child:@"Address"] setValue:placeAddressLabel.text];
    [[_updateRef child:@"placeID"] setValue:SelectedPlace.placeID];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    FIRUser *user = [FIRAuth auth].currentUser;
    _updateRef = [[[[self.ref child:@"users"] child:user.uid] child:@"Rated Places"] childByAutoId];
    [[_updateRef child:@"placeID"] setValue:SelectedPlace.placeID];
    [[_updateRef child:@"User's Place Rating"] setValue:userPlaceRating];
    NSLog(@"Final rating is %@",userPlaceRating);
}
-(void)viewDidLoad{
    
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    fullStarsArray = [[NSArray alloc]initWithObjects: OneStarFull, TwoStarsFull, ThreeStarsFull, FourStarsFull, FiveStarsFull, nil];
    
    emptyStarsArray = [[NSArray alloc]initWithObjects: OneStarEmpty, TwoStarsEmpty, ThreeStarsEmpty, FourStarsEmpty, FiveStarsEmpty, nil];
    
    buttonsArray = [[NSArray alloc] initWithObjects:oneStarBtn, TwoStarsBtn, ThreeStarsBtn, FourStarsBtn, FiveStarsBtn, nil];
    
    self.ref = [[FIRDatabase database] reference];
    
}

- (void) backButtonPressed: (UIBarButtonItem *)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)favoriteBtnTapped:(UIButton *)sender {
    SelectedPlace.Favorited=true;
    FIRUser *user = [FIRAuth auth].currentUser;
    _updateRef = [[[[self.ref child:@"users"] child:user.uid] child:@"Favorite Places"] childByAutoId];
    [[_updateRef child:@"Name"] setValue:placeNameLabel.text];
    [[_updateRef child:@"Address"] setValue:placeAddressLabel.text];
    [[_updateRef child:@"placeID"] setValue:SelectedPlace.placeID];
    
    [favoriteBtn setHidden:YES];
    [favoritedLabel setHidden:NO];
    
    NSMutableArray *favePlaces = [[NSMutableArray alloc]init];
    AppDelegate *favesDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [favePlaces addObject:SelectedPlace];
    favesDelegate.FavoritedPlaces = favePlaces;
}

- (void)viewWillAppear:(BOOL)animated{
    if (SelectedPlace.UserAdded){
        
    if (!SelectedPlace.Rated){
        
        for(UIImageView *fullStar in fullStarsArray){
            [fullStar setHidden:YES];
        }
    }

    else if (SelectedPlace.Rating==1){
        
        [OneStarFull setHidden:NO];
        
        for(int i = 1; i < 5; i++){
            [[fullStarsArray objectAtIndex:i] setHidden:YES];
        }
    }
        
    else if (SelectedPlace.Rating==2){
        
        [OneStarFull setHidden:NO];
        [TwoStarsFull setHidden:NO];
        
        for(int i = 2; i < 5; i++){
            [[fullStarsArray objectAtIndex:i] setHidden:YES];
        }

    }
    
    else if (SelectedPlace.Rating==3){
        
        for(int i = 0; i < 3; i++){
            [[fullStarsArray objectAtIndex:i] setHidden:NO];
        }
        [FourStarsFull setHidden:YES];
        [FiveStarsFull setHidden:YES];
        
    }
    
    else if (SelectedPlace.Rating==4){
        
        for(int i = 0; i < 4; i++){
            [[fullStarsArray objectAtIndex:i] setHidden:NO];
        }

        [FiveStarsFull setHidden:YES];
    }
    
    else if (SelectedPlace.Rating==5){

        for(UIImageView *fullStar in fullStarsArray){
            [fullStar setHidden:NO];
        }

    }
    }
    
    else{
        
        for(UIImageView *fullStar in fullStarsArray){
            [fullStar setHidden:YES];
        }

        for(UITableView *emptyStar in emptyStarsArray){
            [emptyStar setHidden:YES];
        }

        for(UIButton *button in buttonsArray){
            [button setUserInteractionEnabled:NO];
        }

    }
    NSLog(@"Is checked in %d",SelectedPlace.CheckedIn);
    if (SelectedPlace.CheckedIn){
        _CheckInButton.hidden=true;
        _IsCheckedIn.hidden=false;
    }
    else{
        _IsCheckedIn.hidden=true;
        _CheckInButton.hidden=false;
    }
    if (SelectedPlace.Favorited){
        favoriteBtn.hidden=true;
        favoritedLabel.hidden=false;
    }
    else{
        favoritedLabel.hidden=true;
        favoriteBtn.hidden=false;
    }
    _BasedOn.text=[NSString stringWithFormat:@"Based on %@ Category:",sourceArrayName];
    self.ReturnMaps.userInteractionEnabled=true;
    self.title=SelectedPlace.name;
    self.placeNameLabel.adjustsFontSizeToFitWidth=YES;
    self.placeAddressLabel.adjustsFontSizeToFitWidth=YES;
    self.placeNameLabel.text=SelectedPlace.name;
    self.placeAddressLabel.text=SelectedPlace.formattedAddress;
    NSLog(@"Current view controller");
    if (![segueUsed isEqualToString:@"tapToLocation"]){
        self.ReturnMaps.hidden=true;
    }
    if (![segueUsed isEqualToString:@"SurpriseMe2"]){
        self.BasedOn.hidden=true;
    }
    if (!SelectedPlace.UserAdded){
        self.UserAddedTitle.hidden=true;
    }

    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
