//
//  GooglePlace.m
//  WayMap
//
//  Created by carlos arellano on 4/18/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "GooglePlace.h"

@implementation GooglePlace
@synthesize name,placeID,priceLevel,phoneNumber,coordinate,openNow,formattedAddress,rating,website;
-(void)Initiate:(NSString*)name:(NSString*)placeID:(CLLocationCoordinate2D)coordinate:(NSArray<NSString*>*) types:(GMSPlacesOpenNowStatus)openNow:(NSString*)phoneNumber:(NSString*)formattedAddress:(float)rating: (GMSPlacesPriceLevel)priceLevel:(NSURL*)website{
    self.name = [[NSString alloc ]init];
    self.types = [NSMutableArray arrayWithArray:types];
    self.name=name;
    /*placeID=self.placeID;
    coordinate=self.coordinate;
    openNow=self.openNow;
    phoneNumber=self.phoneNumber;
    formattedAddress=self.formattedAddress;
    rating=self.rating;
    priceLevel=self.priceLevel;
    website=self.website;*/
}
@end
/*@property NSString*name;
 @property NSString*placeID;
 @property CLLocationCoordinate2D coordinate;
 @property GMSPlacesOpenNowStatus* openNow;
 @property NSString*phoneNumber;
 @property NSString*formattedAddress;
 @property float*rating;
 @property GMSPlacesPriceLevel* priceLevel;
 @property NSURL*website;*/
