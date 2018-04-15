//
//  MapViewController.h
//  WayMap
//
//  Created by carlos arellano on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Mapbox;
@interface MapViewController : UIViewController <MGLMapViewDelegate>
- (IBAction)UserLocation:(id)sender;
@property (strong, nonatomic) IBOutlet MGLMapView *MapView;

@end
