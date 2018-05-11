//
//  TipsSecondTableViewController.h
//  WayMap
//
//  Created by Carlos Arellano and Jean Jeon on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlacesInformationViewController.h"
#import "GooglePlace.h"
@import Mapbox;
@import MapKit;
@import GooglePlaces;
@import GooglePlacePicker;

@interface TipsSecondTableViewController : UITableViewController<UITabBarControllerDelegate,UITableViewDelegate>
@property (strong,nonatomic) NSString*LocationName;
@property (strong,nonatomic) NSMutableArray*Food;
@property (strong,nonatomic) NSMutableArray*Leisure;
@property (strong,nonatomic) NSMutableArray*Entertainment;
@property (strong,nonatomic) NSMutableArray*Culture;

@property (strong,nonatomic) NSMutableArray*Other;
@property (strong,nonatomic) NSMutableArray*Shopping;
@property (strong,nonatomic) NSMutableArray*Transportation;
@property (strong,nonatomic) NSMutableArray*Financial;
@property (strong,nonatomic) NSMutableArray*Occupational;
@property (strong,nonatomic) NSMutableArray*ServicesOther;

@property (strong,nonatomic) NSMutableArray*Lifestyle;


@property (strong) GooglePlace* SelectedPlace;
@property (strong )CLLocation*userLocation;
/*[categories addObject:@"Food"];
 [categories addObject:@"Bars"];
 [categories addObject:@"Shopping"];
 [categories addObject:@"Culture"];
 [categories addObject:@"Entertainment"];
 [categories addObject:@"Nature"];
 [categories addObject:@"Other"];*/

@end
