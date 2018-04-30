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
@synthesize Food,Lifestyle,Culture,Entertainment,Leisure,Other,Shopping,Transportation,Occupational,Financial,userLocation,SelectedPlace;
- (id) initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self){
        
    }
    
    
    return self;
}
//allocates relevant memory
- (void)viewDidLoad {
    [super viewDidLoad];
    userLocation=[[CLLocation alloc ]init];

}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.tabBarController.delegate=self;
    [self.tableView reloadData];
    for (GooglePlace* location in Food){
        if (location.CheckedIn){
            NSLog(@"WOOOO CHECKED IN again!!! %@",location.name);
        }
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//shoes data to table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//based on location name, retrieves relevant array that was passed
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
    //shows relevant cell that was passd
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SpecificLocation"];
    }
    GooglePlace*SelectedPlace1=[[GooglePlace alloc]init];;
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
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
//if user clicks on cell, then the selected place will be segued into place info view controller
- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Checking food places:");
    for (GooglePlace* location in Food){
        NSLog(@"Name of food: %@, %d:",location.name,location.CheckedIn);
        if (location.Favorited){
            
            NSLog(@"WOOOO FAVORITED again x3!!! %@",location.name);
        }
        
    }
    if ([_LocationName isEqualToString:@"Food"]){
        SelectedPlace=[Food objectAtIndex:indexPath.row];
        NSLog(@"Showing food %d",SelectedPlace.Favorited);
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

#pragma mark - Navigation
//segues to information view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPlace"]){
        PlacesInformationViewController *Place = [segue destinationViewController];
        NSLog(@"Selected place check in %d",SelectedPlace.CheckedIn);
        Place.SelectedPlace = self.SelectedPlace;
        
        
        
    }
    //segues random location to info view controller
    else if ([segue.identifier isEqualToString:@"SurpriseMe2"]){
        PlacesInformationViewController *Random=[segue destinationViewController];
        NSMutableArray*ChosenArray;
        NSString*chosen;
        if ([_LocationName isEqualToString:@"Food"]){
            ChosenArray=Food;
            chosen=@"Food";
        }
        
        else if ([_LocationName isEqualToString:@"Leisure"]){
            ChosenArray=Leisure;
            chosen=@"Leisure";

        }else if ([_LocationName isEqualToString:@"Lifestyle"]){
            ChosenArray=Lifestyle;
            chosen=@"Lifestyle";

        }
        else if ([_LocationName isEqualToString:@"Entertainment"]){
            ChosenArray=Entertainment;
            chosen=@"Entertainment";

        }
        else if ([_LocationName isEqualToString:@"Financial"]){
            ChosenArray=Financial;
            chosen=@"Financial";

        }else if ([_LocationName isEqualToString:@"Transportation"]){
            ChosenArray=Transportation;
            chosen=@"Transportation";

        }else if ([_LocationName isEqualToString:@"Occupational"]){
            ChosenArray=Occupational;
            chosen=@"Occupational";

        }else if ([_LocationName isEqualToString:@"Culture"]){
            ChosenArray=Culture;
            chosen=@"Culture";

        }
        else if ([_LocationName isEqualToString:@"Other"]){
            ChosenArray=Other;
            chosen=@"Other";

        }
        else if ([_LocationName isEqualToString:@"Shopping"]){
            ChosenArray=Shopping;
            chosen=@"Shopping";

        }
        int RandomPlace = arc4random_uniform([ChosenArray count]);
        NSLog(@"random number is %d", RandomPlace);
        SelectedPlace = [ChosenArray objectAtIndex:RandomPlace];
        NSLog(@"random place again is %@", SelectedPlace.name);
        NSLog(@"Place random is %@",self.SelectedPlace.name);
        Random.SelectedPlace=self.SelectedPlace;
        Random.sourceArrayName=chosen;
        Random.segueUsed=[segue identifier];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
