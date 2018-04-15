//
//  ViewController.m
//  WayMap
//
//  Created by carlos arellano on 4/5/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "ViewController.h"
#import "TipsFirstTableViewController.h"
@interface ViewController ()

@end
@implementation ViewController
@synthesize categories;
- (void)viewDidLoad {
    self.tabBarController.delegate=self;
    NSLog(@"hello");
    [super viewDidLoad];
    [categories addObject:@"Food"];
    [categories addObject:@"Nature"];
    [categories addObject:@"Entertainment"];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if ([viewController isKindOfClass:[TipsFirstTableViewController class]]){
        TipsFirstTableViewController*Tips=(TipsFirstTableViewController*) viewController;
       Tips.categories=self.categories;
    }
    return YES;
}


@end
