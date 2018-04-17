//
//  TipsSecondTableViewController.m
//  WayMap
//
//  Created by carlos arellano on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "TipsSecondTableViewController.h"

@interface TipsSecondTableViewController ()

@end

@implementation TipsSecondTableViewController
@synthesize Food,Nature,Entertainment,LikelyList;
- (id) initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self){
        
    }
    
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    Food = [[NSMutableArray alloc]init];
    //add objects here
    [Food addObject:@"Halal"];
    [Food addObject:@"McDonalds"];
    [Food addObject:@"Five Guys"];
    Nature = [[NSMutableArray alloc]init];
    //add more objects here 
    [Nature addObject:@"WSP"];
    [Nature addObject:@"Central Park"];
    [Nature addObject:@"Gramercy Park"];
    Entertainment = [[NSMutableArray alloc]init];
    [Entertainment addObject:@"AMC"];
    [Entertainment addObject:@"Regal"];
    [Entertainment addObject:@"the QUAD"];
    
    // Uncomment the following line to presrve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    int count=0;
    for (GMSPlaceLikelihood *likehood in LikelyList.likelihoods){
        count++;        
        NSLog(@"ADDED TO FOOD ARRAY!");
        GMSPlace* place = likehood.place;
        [Food addObject:place.name];
        NSLog(@"Current Place name %@ at likelihood %g", place.name, likehood.likelihood);

    }
    NSLog(@"COUNTFOR: %d",count);
    
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_LocationName isEqualToString:@"Food"]){
        return [Food count];
    }
    if ([_LocationName isEqualToString:@"Nature"]){
        return [Nature count];
    }
    else if ([_LocationName isEqualToString:@"Entertainment"]){
        return [Entertainment count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpecificLocation" forIndexPath:indexPath];
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SpecificLocation"];
    }
    if ([_LocationName isEqualToString:@"Food"]){
        cell.textLabel.text = [self.Food objectAtIndex:indexPath.row];
    }
    if ([_LocationName isEqualToString:@"Nature"]){
        cell.textLabel.text = [self.Nature objectAtIndex:indexPath.row];
    }
    else if ([_LocationName isEqualToString:@"Entertainment"]){
        cell.textLabel.text = [self.Entertainment objectAtIndex:indexPath.row];
    }
    
    // Configure the cell...
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
