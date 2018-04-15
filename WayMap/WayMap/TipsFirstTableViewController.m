//
//  TipsFirstTableViewController.m
//  WayMap
//
//  Created by carlos arellano on 4/12/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "TipsFirstTableViewController.h"
#import "MapViewController.h"
#import "TipsSecondTableViewController.h"
@interface TipsFirstTableViewController ()

@end
@implementation TipsFirstTableViewController
@synthesize categories;
NSIndexPath* SelectedIndexPath;
- (id) initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self){
       
    }
    
    
    return self;
}

- (void)viewDidLoad {
    categories = [[NSMutableArray alloc] init];
    self.tabBarController.delegate=self;
    [categories addObject:@"Food"];
    [categories addObject:@"Nature"];
    [categories addObject:@"Entertainment"];
    [super viewDidLoad];
    
    
    NSLog(@"Hello again");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"does this work1");
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"does this work2");
    NSLog(@"%lu",(unsigned long)[self.categories count]);
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"does this work3");
    static NSString *simpleTableIdentifier = @"TypeOfLocation";
    UITableViewCell*cell = [[UITableView alloc] dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text= [categories objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}


- (BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[MapViewController class]]){
        MapViewController *Map = (MapViewController* ) viewController;
    }
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"showMoreDetails" sender:self];
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"showMoreDetails"]){
        // NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         TipsSecondTableViewController *SecTip = [segue destinationViewController];
         SecTip.LocationName=[categories objectAtIndex:SelectedIndexPath.row];
         SecTip.title=SecTip.LocationName;
     }
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
