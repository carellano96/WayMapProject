//
//  AppDelegate.h
//  WayMap
//
//  Created by Carlos Arellano and Jean Jeon on 4/5/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseDatabase;
@import FirebaseAuth;
@import MapKit;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NSMutableArray* CheckInLocations;
@property (strong,nonatomic) NSMutableArray* LocationsNearby;
@property (strong) NSMutableArray*UserAddedLocations;
@property (strong) NSMutableArray*FavoritedPlaces;
@property (strong) NSMutableArray*MyUserAddedLocations;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong) NSMutableArray*RatedPlaces;
@property (strong) CLLocation*UserLocation;


@end

