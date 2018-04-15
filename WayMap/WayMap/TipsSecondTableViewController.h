//
//  TipsSecondTableViewController.h
//  WayMap
//
//  Created by carlos arellano on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipsSecondTableViewController : UITableViewController<UITabBarControllerDelegate>
@property (strong,nonatomic) NSString*LocationName;
@property (strong,nonatomic) NSMutableArray*Food;
@property (strong,nonatomic) NSMutableArray*Nature;
@property (strong,nonatomic) NSMutableArray*Entertainment;

@end
