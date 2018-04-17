//
//  TipsSecondTableViewController.h
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
@interface TipsSecondTableViewController : UITableViewController<UITabBarControllerDelegate,UITableViewDelegate>
@property (strong,nonatomic) NSString*LocationName;
@property (strong,nonatomic) NSMutableArray*Food;
@property (strong,nonatomic) NSMutableArray*Nature;
@property (strong,nonatomic) NSMutableArray*Entertainment;
@property (strong) GMSPlaceLikelihoodList* LikelyList;


@end
