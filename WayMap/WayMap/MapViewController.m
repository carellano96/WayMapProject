//
//  MapViewController.m
//  WayMap
//
//  Created by carlos arellano on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize MapView;
- (void)viewDidLoad {
    [super viewDidLoad];
    MapView.delegate=self;
    MapView.showsUserLocation=YES;
    // Do any additional setup after loading the view.
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

- (IBAction)UserLocation:(id)sender {
    MGLMapCamera *camera = [MGLMapCamera cameraLookingAtCenterCoordinate:MapView.userLocation.coordinate fromDistance:4000 pitch:0 heading:0];
    [MapView setCamera:camera animated:YES];
}
@end
