//
//  PlacesInformationViewController.m
//  WayMap
//
//  Created by carlos arellano on 4/18/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "PlacesInformationViewController.h"
#import "AppDelegate.h"

@interface PlacesInformationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *PlaceName;
@property (weak, nonatomic) IBOutlet UILabel *temp;
@property (weak, nonatomic) IBOutlet UIButton *ReturnMaps;
@property (weak, nonatomic) IBOutlet UILabel *BasedOn;

@property (weak, nonatomic) IBOutlet UILabel *PlaceAddress;

@end

@implementation PlacesInformationViewController
@synthesize SelectedPlace,segueUsed,sourceArrayName,UserAddedTitle,CheckedInLocations;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"pushing back to da maps");
}
- (IBAction)CheckIntoPlace:(id)sender {
    //check in
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    SelectedPlace.CheckedIn=true;
    [CheckedInLocations addObject:SelectedPlace];
    myDelegate.CheckInLocations=CheckedInLocations;
    _CheckInButton.hidden=true;
    _IsCheckedIn.hidden=false;
}
-(void)viewDidLoad{
    CheckedInLocations=[[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    if (SelectedPlace.CheckedIn){
        _CheckInButton.hidden=true;
        _IsCheckedIn.hidden=false;
    }
    else{
        _IsCheckedIn.hidden=true;
        _CheckInButton.hidden=false;
    }
    _BasedOn.text=[NSString stringWithFormat:@"Based on %@ Category:",sourceArrayName];
    self.ReturnMaps.userInteractionEnabled=true;
    self.title=SelectedPlace.name;
    self.PlaceName.adjustsFontSizeToFitWidth=YES;
    self.PlaceAddress.adjustsFontSizeToFitWidth=YES;
    self.PlaceName.text=SelectedPlace.name;
    self.PlaceAddress.text=SelectedPlace.formattedAddress;
    NSLog(@"Current view controller");
    if (![segueUsed isEqualToString:@"tapToLocation"]){
        self.ReturnMaps.hidden=true;
    }
    if (![segueUsed isEqualToString:@"SurpriseMe2"]){
        self.BasedOn.hidden=true;
    }
    if (!SelectedPlace.UserAdded){
        self.UserAddedTitle.hidden=true;
    }

    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
