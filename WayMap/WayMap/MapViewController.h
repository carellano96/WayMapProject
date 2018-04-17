//
//  MapViewController.h
//  WayMap
//
//  Created by carlos arellano on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Mapbox;
@import MapKit;
@import GooglePlaces;
@import GooglePlacePicker;
@interface MapViewController : UIViewController <MGLMapViewDelegate,CLLocationManagerDelegate,UITabBarControllerDelegate,UITabBarDelegate>
- (IBAction)UserLocation:(id)sender;
@property (strong, nonatomic) IBOutlet MGLMapView *MapView;
@property (strong,nonatomic) GMSPlaceLikelihoodList *LikelyList;

@end
