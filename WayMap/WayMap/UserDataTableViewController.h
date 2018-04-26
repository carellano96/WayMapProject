//
//  UserDataTableViewController.h
//  WayMap
//
//  Created by Jean Jeon on 4/25/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDataTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *userAddedPlaces;
@property (strong, nonatomic) NSMutableArray *favoritePlaces;

@property (nonatomic) Boolean favoritesHit;
@property (nonatomic) Boolean userAddedHit;

@property (strong, nonatomic) NSString *sectionTitle;
@property (strong, nonatomic) NSString *placeName;

@property (strong, nonatomic) UITableViewCell *selectedPlace;

@end
