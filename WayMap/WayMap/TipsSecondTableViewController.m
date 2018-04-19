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
@synthesize Food,Lifestyle,Culture,Entertainment,Leisure,Other,Shopping,LikelyList,Transportation,Occupational,Financial,userLocation,SelectedPlace;
- (id) initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self){
        
    }
    
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    userLocation=[[CLLocation alloc ]init];
    // Uncomment the following line to presrve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SelectedPlace=[[GooglePlace alloc ]init];

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
    GooglePlace*SelectedPlace1 = [[GooglePlace alloc]init];
    if ([_LocationName isEqualToString:@"Food"]){
        SelectedPlace1=[self.Food objectAtIndex:indexPath.row];
        NSLog(@"Showing food %@",SelectedPlace.name);
        cell.textLabel.text = SelectedPlace1.name;
    }
    else if ([_LocationName isEqualToString:@"Leisure"]){
        SelectedPlace1=[self.Leisure objectAtIndex:indexPath.row];
        cell.textLabel.text = SelectedPlace1.name;
        
    }else if ([_LocationName isEqualToString:@"Lifestyle"]){
        SelectedPlace1=[self.Lifestyle objectAtIndex:indexPath.row];
        cell.textLabel.text = SelectedPlace1.name;
    }
    else if ([_LocationName isEqualToString:@"Entertainment"]){
        SelectedPlace1=[self.Entertainment objectAtIndex:indexPath.row];
        cell.textLabel.text = SelectedPlace1.name;
    }
else if ([_LocationName isEqualToString:@"Financial"]){
    SelectedPlace1=[self.Financial objectAtIndex:indexPath.row];
    cell.textLabel.text = SelectedPlace1.name;
}else if ([_LocationName isEqualToString:@"Transportation"]){
    SelectedPlace1=[self.Transportation objectAtIndex:indexPath.row];
    cell.textLabel.text = SelectedPlace1.name;
}else if ([_LocationName isEqualToString:@"Occupational"]){
    SelectedPlace1=[self.Occupational objectAtIndex:indexPath.row];
    cell.textLabel.text = SelectedPlace1.name;
}else if ([_LocationName isEqualToString:@"Culture"]){
    SelectedPlace1=[self.Culture objectAtIndex:indexPath.row];
    cell.textLabel.text = SelectedPlace1.name;
    }
    else if ([_LocationName isEqualToString:@"Other"]){
        SelectedPlace1=[self.Other objectAtIndex:indexPath.row];
        cell.textLabel.text = SelectedPlace1.name;
    }
    else if ([_LocationName isEqualToString:@"Shopping"]){
        SelectedPlace1=[self.Shopping objectAtIndex:indexPath.row];
        cell.textLabel.text = SelectedPlace1.name;
    }
    
    // Configure the cell...
    
    return cell;
}

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_LocationName isEqualToString:@"Food"]){
        SelectedPlace=[self.Food objectAtIndex:indexPath.row];
        NSLog(@"Showing food %@",SelectedPlace.name);
    }
    else if ([_LocationName isEqualToString:@"Leisure"]){
        SelectedPlace=[self.Leisure objectAtIndex:indexPath.row];
        
    }else if ([_LocationName isEqualToString:@"Lifestyle"]){
        SelectedPlace=[self.Lifestyle objectAtIndex:indexPath.row];
    }
    else if ([_LocationName isEqualToString:@"Entertainment"]){
        SelectedPlace=[self.Entertainment objectAtIndex:indexPath.row];
    }
    else if ([_LocationName isEqualToString:@"Financial"]){
        SelectedPlace=[self.Financial objectAtIndex:indexPath.row];
    }else if ([_LocationName isEqualToString:@"Transportation"]){
        SelectedPlace=[self.Transportation objectAtIndex:indexPath.row];
    }else if ([_LocationName isEqualToString:@"Occupational"]){
        SelectedPlace=[self.Occupational objectAtIndex:indexPath.row];
    }else if ([_LocationName isEqualToString:@"Culture"]){
        SelectedPlace=[self.Culture objectAtIndex:indexPath.row];
    }
    else if ([_LocationName isEqualToString:@"Other"]){
        SelectedPlace=[self.Other objectAtIndex:indexPath.row];
    }
    else if ([_LocationName isEqualToString:@"Shopping"]){
        SelectedPlace=[self.Shopping objectAtIndex:indexPath.row];
    }
    return indexPath;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPlace"]){
        PlacesInformationViewController *Place = [segue destinationViewController];
        Place.SelectedPlace = self.SelectedPlace;
        
        
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
