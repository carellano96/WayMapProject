//
//  MapViewController.h
//  WayMap
//
//  Created by carlos arellano on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GooglePlace.h"
@import Mapbox;
@import MapKit;
@import GooglePlaces;
@import GooglePlacePicker;

@interface MapViewController : UIViewController <MGLMapViewDelegate,CLLocationManagerDelegate,UITabBarControllerDelegate,UITabBarDelegate>
- (IBAction)UserLocation:(id)sender;
@property (strong, nonatomic) IBOutlet MGLMapView *MapView;
@property (strong,nonatomic) GMSPlaceLikelihoodList *LikelyList;
@property (strong )CLLocation*userLocation;
@property (strong) NSMutableArray*LocationsNearby;
@property (strong) NSMutableArray *Annotations;
@property (strong) GooglePlace*SelectedPlace;
- (IBAction)backToStart:(UIStoryboardSegue*) segue;
@property (strong) NSMutableArray* MasterLocations;
@property (strong)NSMutableArray* RemoveAnnotations;
@end
