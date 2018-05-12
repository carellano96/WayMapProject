//
//  UserDataTableViewController.m
//  WayMap
//
//  Created by Jean Jeon and Carlos Arelano on 4/25/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "UserDataTableViewController.h"
#import "PlacesInformationViewController.h"
#import "AppDelegate.h"

@interface UserDataTableViewController ()

@end

@implementation UserDataTableViewController

@synthesize sectionTitle, favoritesHit, userAddedHit, selectedPlace, placeName, backBarButtonItem, userAddedPlaces, favoritePlaces, sectionName;

/*
 Set a navigation bar button item that will pop the current VC and go back to the User Profile VC if pressed
 */
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
}
/*
 Method for above mentioned button
 */
- (void) backButtonPressed: (UIBarButtonItem *)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 Check user's rated places against their checked in places and favorited places in order to preserve their ratings
 */

- (void)viewWillAppear:(BOOL)animated{
    AppDelegate* myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    for (GooglePlace* useraddedLocation in myDelegate.MyUserAddedLocations){
        for (GooglePlace* favs in myDelegate.FavoritedPlaces){
            if ([useraddedLocation.placeID isEqualToString:favs.placeID]){
                useraddedLocation.Favorited = true;
            }
        }
        for (GooglePlace* checkedIn in myDelegate.CheckInLocations)
        {
            if ([useraddedLocation.placeID isEqualToString:checkedIn.placeID]){
                useraddedLocation.CheckedIn = true;
        }    }
        for (GooglePlace* ratedPlaces in myDelegate.RatedPlaces){
            if ([useraddedLocation.placeID isEqualToString:ratedPlaces.placeID]){
                useraddedLocation.Rated=true;
                useraddedLocation.Rating=ratedPlaces.Rating;
            }
        }
        useraddedLocation.UserAdded=true;
}
    for (GooglePlace*FavPlaces in myDelegate.FavoritedPlaces){
        FavPlaces.Favorited=true;
        for (GooglePlace* checkedIn in myDelegate.CheckInLocations)
        {
            if ([FavPlaces.placeID isEqualToString:checkedIn.placeID]){
                FavPlaces.CheckedIn = true;
            }    }
        for (GooglePlace* ratedPlaces in myDelegate.RatedPlaces){
            if ([FavPlaces.placeID isEqualToString:ratedPlaces.placeID]){
                FavPlaces.Rated=true;
                FavPlaces.Rating=ratedPlaces.Rating;
            }
        }
    }
}

/*
 Set number of rows and cells to 1 and the number of places the user has added or the places they have favorited, depending on which segue was performed from the last VC.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(favoritesHit == true){
        if([favoritePlaces count] > 0){
            return [favoritePlaces count];
        }
    }
    else if (userAddedHit == true){
        if([userAddedPlaces count] > 0){
            return [userAddedPlaces count];
        }
    }
    return 0;
}
/*
 Display above-mentioned arrays, one array-item per cell. Also set cells' accessory to Disclosure Indicator in order to let the user know that the cells can be clicked on
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(userAddedHit == true){
        cell.textLabel.text = userAddedPlaces[indexPath.row];
    }
    
    else{
        cell.textLabel.text = favoritePlaces[indexPath.row];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

/*
 Change title of the table depending on the segue that was last performed
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(userAddedHit == true){
        sectionName = @"ADDED BY USER";
    }
    else{
        sectionName = @"FAVORITES";
    }
    
    return sectionName;
}


-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedPlace = [tableView cellForRowAtIndexPath:indexPath];
    placeName = selectedPlace.textLabel.text;
    return indexPath;
}

/*
 Pass data of the selected cell (the place's name, address, type) into the Places Info VC.
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"placesInfoSegue"]){
        
        PlacesInformationViewController *PIVC;
        PIVC = [segue destinationViewController];
        
        [PIVC.rateLabel setHidden:YES];
        
        for(UIImageView *FullStar in PIVC.fullStarsArray){
            [FullStar setHidden:YES];
        }
        
        for(UIImageView *EmptyStar in PIVC.emptyStarsArray){
            [EmptyStar setHidden:YES];
        }
        
        for(UIButton *button in PIVC.buttonsArray){
            [button setUserInteractionEnabled:NO];
        }
        
        AppDelegate *userAddedOrFavesDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        if([sectionName isEqualToString:@"ADDED BY USER"]){
            NSMutableArray *tempUserAdded = userAddedOrFavesDelegate.MyUserAddedLocations;
            
            for(GooglePlace *userPlace in tempUserAdded){
                if([userPlace.name isEqualToString:placeName]){
                    PIVC.SelectedPlace = userPlace;
                }
            }
        }
        else{
            NSMutableArray *tempFaves = userAddedOrFavesDelegate.FavoritedPlaces;
            
            for(GooglePlace *userPlace in tempFaves){
                if([userPlace.name isEqualToString:placeName]){
                    PIVC.SelectedPlace = userPlace;
                }

        }
    }
}
}

@end
    
