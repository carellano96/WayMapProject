//
//  PlacesInformationViewController.h
//  WayMap
//
//  Created by Carlos Arellano and Jean Jeon on 4/18/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GooglePlace.h"
@import Mapbox;
@import MapKit;
@import GooglePlaces;
@import GooglePlacePicker;

@interface PlacesInformationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *IsCheckedIn;
@property (weak, nonatomic) IBOutlet UIButton *CheckInButton;

@property (strong)  GooglePlace*SelectedPlace;
@property (strong)  NSString*segueUsed;
@property (weak, nonatomic) IBOutlet UILabel *UserAddedTitle;
@property (strong)  NSString*sourceArrayName;
@property (weak, nonatomic) IBOutlet UILabel *DistanceFromUser;
@property (strong) NSMutableArray*CheckedInLocations;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;
@property (weak, nonatomic) IBOutlet UILabel *favoritedLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *placeAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *OneStarEmpty;
@property (weak, nonatomic) IBOutlet UIImageView *OneStarFull;
@property (weak, nonatomic) IBOutlet UIImageView *TwoStarsEmpty;
@property (weak, nonatomic) IBOutlet UIImageView *TwoStarsFull;
@property (weak, nonatomic) IBOutlet UIImageView *ThreeStarsEmpty;
@property (weak, nonatomic) IBOutlet UIImageView *ThreeStarsFull;
@property (weak, nonatomic) IBOutlet UIImageView *FourStarsEmpty;
@property (weak, nonatomic) IBOutlet UIImageView *FourStarsFull;
@property (weak, nonatomic) IBOutlet UIImageView *FiveStarsEmpty;
@property (weak, nonatomic) IBOutlet UIImageView *FiveStarsFull;

@property (weak, nonatomic) IBOutlet UIButton *oneStarBtn;
@property (weak, nonatomic) IBOutlet UIButton *TwoStarsBtn;
@property (weak, nonatomic) IBOutlet UIButton *ThreeStarsBtn;
@property (weak, nonatomic) IBOutlet UIButton *FourStarsBtn;
@property (weak, nonatomic) IBOutlet UIButton *FiveStarsBtn;

@property (nonatomic) NSNumber *userPlaceRating;

@property (strong, nonatomic) NSArray *buttonsArray;
@property (strong, nonatomic) NSArray *fullStarsArray;
@property (strong, nonatomic) NSArray *emptyStarsArray;
- (IBAction)PressAddressButton:(id)sender;

@property(nonatomic, strong) UIBarButtonItem *backBarButtonItem;

@end
