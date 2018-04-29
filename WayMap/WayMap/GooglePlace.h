//
//  GooglePlace.h
//  WayMap
//
//  Created by carlos arellano on 4/18/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapkit/Mapkit.h>
#import "CustomAnnotation.h"
@import Mapbox;
@import GooglePlaces;
@import GooglePlacePicker;
@class GooglePlace;
@interface GooglePlace : NSObject
@property NSString*name;
@property NSString*placeID;
@property CLLocationCoordinate2D coordinate;
@property GMSPlacesOpenNowStatus openNow;
@property NSString*phoneNumber;
@property NSString*formattedAddress;
@property GMSPlacesPriceLevel priceLevel;
@property NSURL*website;
@property NSMutableArray* types;
@property CustomAnnotation* AnnotationPointer;
@property Boolean UserAdded;
@property Boolean CheckedIn;
@property Boolean Favorited;
@property Boolean Rated;
@property int Rating;
-(void)Initiate:(NSString*)name:(NSString*)placeID:(CLLocationCoordinate2D)coordinate:(NSArray<NSString*>*) types:(GMSPlacesOpenNowStatus)openNow:(NSString*)phoneNumber:(NSString*)formattedAddress:(float)rating: (GMSPlacesPriceLevel)priceLevel:(NSURL*)website;
@end
