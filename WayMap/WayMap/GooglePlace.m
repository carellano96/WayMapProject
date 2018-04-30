//
//  GooglePlace.m
//  WayMap
//
//  Created by carlos arellano on 4/18/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "GooglePlace.h"

@implementation GooglePlace
@synthesize name,placeID,priceLevel,phoneNumber,coordinate,openNow,formattedAddress,website,AnnotationPointer,UserAdded,CheckedIn,Favorited,Rating,Rated;
-(void)Initiate:(NSString*)name:(NSString*)placeID:(CLLocationCoordinate2D)coordinate:(NSArray<NSString*>*) types:(GMSPlacesOpenNowStatus)openNow:(NSString*)phoneNumber:(NSString*)formattedAddress:(float)rating: (GMSPlacesPriceLevel)priceLevel:(NSURL*)website{
    UserAdded=false;
    CheckedIn=false;
    AnnotationPointer = [[CustomAnnotation alloc ]init];
    self.name = [[NSString alloc ]init];
    self.types = [NSMutableArray arrayWithArray:types];
    self.placeID=[[NSString alloc ]init];
    self.phoneNumber=[[NSString alloc]init];
    self.formattedAddress=[[NSString alloc]init];
    self.website=[[NSURL alloc]init];
    self.name=name;
    self.placeID=placeID;
    self.coordinate=coordinate;
    self.openNow=openNow;
    self.phoneNumber=phoneNumber;
    self.formattedAddress=formattedAddress;
    self.priceLevel=priceLevel;
    self.website=website;
    self.Rated=false;
    Favorited=false;
    //this contains all relevant and useful information for the Google Place, provided by Google Places API
    // Information was passed from google into our own object type
}

- (void) initiateRating:(float)rating{
    if (UserAdded){
        self.Rating=0;
    }
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
