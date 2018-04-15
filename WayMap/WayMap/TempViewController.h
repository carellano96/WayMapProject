//
//  TempViewController.h
//  WayMap
//
//  Created by carlos arellano on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "ViewController.h"

@interface TempViewController : ViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray*categories;
@property (strong,nonatomic) UITableView* TempTable;
@end
