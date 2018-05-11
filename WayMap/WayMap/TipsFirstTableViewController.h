//
//  TipsFirstTableViewController.h
//  WayMap
//
//  Created by Carlos Arellano and Jean Jeon on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipsSecondTableViewController.h"
#import "GooglePlace.h"
@import Mapbox;
@import MapKit;
@import GooglePlaces;
@import GooglePlacePicker;
@interface TipsFirstTableViewController : UITableViewController <UITabBarControllerDelegate,UITabBarDelegate>
@property (strong,nonatomic) NSMutableArray*categories;
@property (strong) NSMutableArray* NearbyLocations;
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
@property (strong,nonatomic) TipsSecondTableViewController*Tips1;
@property (strong )CLLocation*userLocation;
@property (strong,nonatomic)GooglePlace*SelectedPlace;
@property int index;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (void) CategorizeLocations
:(NSMutableArray*)NearbyLocations;
@end
