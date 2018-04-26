//
//  UserProfileViewController.h
//  WayMap
//
//  Created by Jean Jeon on 4/22/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GooglePlace.h"
@interface UserProfileViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *userAddedPlaces;
@property (strong, nonatomic) NSMutableArray *favoritePlaces;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (nonatomic) Boolean favoritesHit;
@property (nonatomic) Boolean userAddedHit;

@end
