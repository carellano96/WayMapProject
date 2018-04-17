//
//  TipsFirstTableViewController.h
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
@interface TipsFirstTableViewController : UITableViewController <UITabBarControllerDelegate,UITabBarDelegate>
@property (strong,nonatomic) NSMutableArray*categories;
@property (strong) GMSPlaceLikelihoodList* LikelyList;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
@end
