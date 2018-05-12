//
//  UserDataTableViewController.h
//  WayMap
//
//  Created by Jean Jeon and Carlos Arellano on 4/25/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDataTableViewController : UITableViewController <UITableViewDelegate>

/*
 Properties and outlets for use in the implementation file
 */
@property (strong, nonatomic) NSMutableArray *userAddedPlaces;
@property (strong, nonatomic) NSMutableArray *favoritePlaces;

@property (nonatomic) Boolean favoritesHit;
@property (nonatomic) Boolean userAddedHit;

@property (strong, nonatomic) NSString *sectionTitle;
@property (strong, nonatomic) NSString *placeName;

@property (strong, nonatomic) UITableViewCell *selectedPlace;

@property(nonatomic, strong) UIBarButtonItem *backBarButtonItem;

@property(nonatomic, strong) NSString *sectionName;

@end
