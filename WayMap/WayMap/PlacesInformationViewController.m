//
//  PlacesInformationViewController.m
//  WayMap
//
//  Created by carlos arellano on 4/18/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "PlacesInformationViewController.h"

@interface PlacesInformationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *PlaceName;

@end

@implementation PlacesInformationViewController
@synthesize SelectedPlace;

- (void)viewWillAppear:(BOOL)animated{
    self.title=SelectedPlace.name;
    self.PlaceName.text=SelectedPlace.name;
    NSLog(@"Current view controller");

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
