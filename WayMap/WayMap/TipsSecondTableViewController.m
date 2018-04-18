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
@synthesize Food,Lifestyle,Culture,Entertainment,Leisure,Other,Shopping,LikelyList,Transportation,Occupational,Financial;
- (id) initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self){
        
    }
    
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to presrve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.delegate=self;
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
    if ([_LocationName isEqualToString:@"Leisure"]){
        return [Leisure count];
    }
    else if ([_LocationName isEqualToString:@"Entertainment"]){
        return [Entertainment count];
    }else if ([_LocationName isEqualToString:@"Culture"]){
        return [Culture count];
    }else if ([_LocationName isEqualToString:@"Financial"]){
        return [Financial count];}
    else if ([_LocationName isEqualToString:@"Transportation"]){
        return [Transportation count];}else if ([_LocationName isEqualToString:@"Occupational"]){
            return [Occupational count];}
        else if ([_LocationName isEqualToString:@"Lifestyle"]){
            return [Lifestyle count];}
    else if ([_LocationName isEqualToString:@"Shopping"]){
        return [Shopping count];}
else if ([_LocationName isEqualToString:@"Other"]){
        return [Other count];
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
    else if ([_LocationName isEqualToString:@"Leisure"]){
        cell.textLabel.text = [self.Leisure objectAtIndex:indexPath.row];
    }else if ([_LocationName isEqualToString:@"Lifestyle"]){
        cell.textLabel.text = [self.Lifestyle objectAtIndex:indexPath.row];
    }
    else if ([_LocationName isEqualToString:@"Entertainment"]){
        cell.textLabel.text = [self.Entertainment objectAtIndex:indexPath.row];
    }
else if ([_LocationName isEqualToString:@"Financial"]){
        cell.textLabel.text = [self.Financial objectAtIndex:indexPath.row];
}else if ([_LocationName isEqualToString:@"Transportation"]){
    cell.textLabel.text = [self.Transportation objectAtIndex:indexPath.row];
}else if ([_LocationName isEqualToString:@"Occupational"]){
    cell.textLabel.text = [self.Occupational objectAtIndex:indexPath.row];
}else if ([_LocationName isEqualToString:@"Culture"]){
        cell.textLabel.text = [self.Culture objectAtIndex:indexPath.row];
    }
    else if ([_LocationName isEqualToString:@"Other"]){
        cell.textLabel.text = [self.Other objectAtIndex:indexPath.row];
    }
    else if ([_LocationName isEqualToString:@"Shopping"]){
        cell.textLabel.text = [self.Shopping objectAtIndex:indexPath.row];
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
