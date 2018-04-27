//
//  UserDataTableViewController.m
//  WayMap
//
//  Created by Jean Jeon on 4/25/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "UserDataTableViewController.h"
#import "PlacesInformationViewController.h"

@interface UserDataTableViewController ()

@end

@implementation UserDataTableViewController

@synthesize userAddedPlaces, favoritePlaces, sectionTitle, favoritesHit, userAddedHit, selectedPlace, placeName, backBarButtonItem;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
}

- (void) backButtonPressed: (UIBarButtonItem *)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

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
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    if(userAddedHit == true){
        sectionName = @"ADDED BY USER";
    }
    else{
        sectionName = @"FAVORITES";
    }
    
    return sectionName;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        selectedPlace = [tableView cellForRowAtIndexPath:indexPath];
        placeName = selectedPlace.textLabel.text;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"placesInfoSegue"]){
        PlacesInformationViewController *PIVC;
        PIVC = [segue destinationViewController];
        PIVC.placeNameLabel.text = placeName;
    }
    //PIVC.placeAddressLabel.text = 
}


@end
