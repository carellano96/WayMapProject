//
//  AppDelegate.m
//  WayMap
//
//  Created by carlos arellano and jean jeon on 4/5/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "AppDelegate.h"
#import "LogInViewController.h"
#import "UserProfileViewController.h"
#import "MapViewController.h"
#import "TipsFirstTableViewController.h"

@import GooglePlaces;
@import UIKit;
@import Firebase;
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize CheckInLocations,LocationsNearby,UserAddedLocations,FavoritedPlaces;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GMSPlacesClient provideAPIKey:@"AIzaSyD1r1DuPCcwMFH50vV6hOLK14PWiFqq8DE"];
    [FIRApp configure];
    CheckInLocations=[[NSMutableArray alloc]init];
    LocationsNearby=[[NSMutableArray alloc]init];
    UserAddedLocations=[[NSMutableArray alloc]init];
    FavoritedPlaces=[[NSMutableArray alloc] init];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
