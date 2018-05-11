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
@synthesize SelectedPlace,segueUsed,sourceArrayName,UserAddedTitle,CheckedInLocations, favoriteBtn, favoritedLabel, placeNameLabel, placeAddressLabel, OneStarFull, OneStarEmpty, TwoStarsFull, TwoStarsEmpty, ThreeStarsFull, ThreeStarsEmpty, FourStarsFull, FourStarsEmpty, FiveStarsFull, FiveStarsEmpty, userPlaceRating, fullStarsArray, emptyStarsArray, backBarButtonItem, buttonsArray, oneStarBtn, TwoStarsBtn, ThreeStarsBtn, FourStarsBtn, FiveStarsBtn, rateLabel;

/*
 Below methods allow for user-friendly interaction of the ratings buttons - if they press, for example, the third star, then all of the first three stars are filled in order to reflect their choice. If they press the third star again, then the star goes empty, but the first two stars before it remain filled in order to indicated that they wished to undo the third star. Likewise, all stars above the star they pressed become or remain empty. The user's rating of a place is then set to the number of whatever star they pressed.
 */

- (IBAction)oneStarBtnPressed:(UIButton *)sender {
    
    static int numberOfTimesPressed = 1;
    numberOfTimesPressed ++;
    if(numberOfTimesPressed % 2 == 0){
        [OneStarFull setHidden:NO];
        [OneStarEmpty setHidden:YES];
        userPlaceRating = [NSNumber numberWithInt:1];
    }
    else{
        for(int i = 0; i < 5; i++){
            [[fullStarsArray objectAtIndex:i] setHidden:YES];
            [[emptyStarsArray objectAtIndex:i] setHidden:NO];
        }
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
        for(int i = 1; i < 5; i++){
            [[fullStarsArray objectAtIndex:i] setHidden:YES];
            [[emptyStarsArray objectAtIndex:i] setHidden:NO];
        }
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
        for(int i = 2; i < 5; i++){
            [[fullStarsArray objectAtIndex:i] setHidden:YES];
            [[emptyStarsArray objectAtIndex:i] setHidden:NO];
        }
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
        for(int i = 3; i < 5; i++){
            [[fullStarsArray objectAtIndex:i] setHidden:YES];
            [[emptyStarsArray objectAtIndex:i] setHidden:NO];
        }
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

/*
 If a user checks into a place, then the place's information is sent to the user's data as one of the user's visited places in Firebase.
 */
- (IBAction)CheckIntoPlace:(id)sender {
    
    SelectedPlace.CheckedIn=true;
    _CheckInButton.hidden=true;
    _IsCheckedIn.hidden=false;
    FIRUser *user = [FIRAuth auth].currentUser;
    _updateRef = [[[[self.ref child:@"users"] child:user.uid] child:@"Places Visited"] childByAutoId];
    [[_updateRef child:@"Name"] setValue:placeNameLabel.text];
    [[_updateRef child:@"Address"] setValue:SelectedPlace.formattedAddress];
    [[_updateRef child:@"placeID"] setValue:SelectedPlace.placeID];
    
}

/*
 Creates a separate node for the user that stores their rated places and the ratings of those places in Firebase.
 */
-(void)viewWillDisappear:(BOOL)animated{
    FIRUser *user = [FIRAuth auth].currentUser;
    _updateRef = [[[[self.ref child:@"users"] child:user.uid] child:@"Rated Places"] childByAutoId];
    [[_updateRef child:@"placeID"] setValue:SelectedPlace.placeID];
    [[_updateRef child:@"User's Place Rating"] setValue:userPlaceRating];
}

/*
 Alloc and init arrays of the star-buttons for easier use
 */
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
    [[_updateRef child:@"Address"] setValue:SelectedPlace.formattedAddress];
    [[_updateRef child:@"placeID"] setValue:SelectedPlace.placeID];
    [favoriteBtn setHidden:YES];
    [favoritedLabel setHidden:NO];
    
    NSMutableArray *favePlaces = [[NSMutableArray alloc]init];
    AppDelegate *favesDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [favePlaces addObject:SelectedPlace];
    favesDelegate.FavoritedPlaces = favePlaces;
}

- (void)viewWillAppear:(BOOL)animated{
    //sets buttons in info view controller based on if the button is pressed or not, location is user added or not, etc.
     AppDelegate* myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CLLocation*UserLocation = myDelegate.UserLocation;
    CLLocation*TemporarySelectedPlace = [[CLLocation alloc] initWithLatitude:SelectedPlace.coordinate.latitude longitude:SelectedPlace.coordinate.longitude];
    CLLocationDistance distance = [UserLocation distanceFromLocation:TemporarySelectedPlace];
    double DistanceInFeet = distance*3.28084;
    _DistanceFromUser.text=[[NSString alloc]initWithFormat:@"%.1f ft. away",DistanceInFeet];
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
        
        [rateLabel setHidden:YES];

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
    self.placeNameLabel.text=SelectedPlace.name;
    [self.placeAddressLabel setTitle:SelectedPlace.formattedAddress forState:UIControlStateNormal];
    NSLog(@"Current view controller");
    //hides labels based on relevant segue used
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

//Takes the user to Apple Maps if they click on the address of the displayed place.
- (IBAction)PressAddressButton:(id)sender {
    NSString* directionsURL = [NSString stringWithFormat:@"http://maps.apple.com/?q=%f,%f",self.SelectedPlace.coordinate.latitude, self.SelectedPlace.coordinate.longitude];
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: directionsURL] options:@{} completionHandler:^(BOOL success) {}];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: directionsURL]];
    }
}
@end
