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
@synthesize categories,LikelyList,Transportation,Occupational,Financial,Food,Lifestyle,Culture,Entertainment,Leisure,Other,Shopping,Tips1,userLocation,SelectedPlace;
NSString* SelectedIndexPath;
- (id) initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self){
       
    }
    
    
    return self;
}

- (void)viewDidLoad {
    userLocation=[[CLLocation alloc ]init];
    categories = [[NSMutableArray alloc] init];
    self.tabBarController.delegate=self;
    SelectedIndexPath = [[NSString alloc ]init];
    [super viewDidLoad];
    
    
    NSLog(@"Hello again");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    Food = [[NSMutableArray alloc ]init];
    Leisure = [[NSMutableArray alloc ]init];
    Financial = [[NSMutableArray alloc ]init];
    Occupational = [[NSMutableArray alloc ]init];
    Transportation = [[NSMutableArray alloc ]init];
    Other = [[NSMutableArray alloc ]init];
    Culture = [[NSMutableArray alloc ]init];
    Entertainment = [[NSMutableArray alloc ]init];
    Lifestyle = [[NSMutableArray alloc ]init];
    Shopping = [[NSMutableArray alloc ]init];
    SelectedPlace=[[GooglePlace alloc]init];
    self.tabBarController.delegate=self;
    int count=0;
    for (GMSPlaceLikelihood *likehood in LikelyList.likelihoods){
        count++;
        NSLog(@"ADDED TO FOOD ARRAY!");
        GMSPlace* place = likehood.place;
        NSLog(@"Current Place name %@ at likelihood %g", place.name, likehood.likelihood);
        
    }
    [categories removeAllObjects];
    [self CategorizeLocations:LikelyList];
    if ([Food count]!=0){
        [categories addObject:@"Food"];
    }
    if ([Leisure count]!=0){
        [categories addObject:@"Leisure"];
        
    }if ([Financial count]!=0){
        [categories addObject:@"Financial"];
        
    }if ([Transportation count]!=0){
        [categories addObject:@"Transportation"];
        
    }if ([Occupational count]!=0){
        [categories addObject:@"Occupational"];
        
    }if ([Culture count]!=0){
        [categories addObject:@"Culture"];
        
    }if ([Entertainment count]!=0){
        NSLog(@"Entertainment is: %lu",[Entertainment count]);
        [categories addObject:@"Entertainment"];
        
    }
    if ([Lifestyle count]!=0){
        [categories addObject:@"Lifestyle"];
        
    }if ([Shopping count]!=0){
        [categories addObject:@"Shopping"];
        
    }if ([Other count]!=0){
        [categories addObject:@"Other"];
        
    }
    NSLog(@"COUNTFOR1: %d",count);
    
    [self.tableView reloadData];
    
}

- (void) CategorizeLocations
:(GMSPlaceLikelihoodList*)LikelyList{
    for (GMSPlaceLikelihood *likehood in LikelyList.likelihoods){
        NSLog(@"ADDED TO FOOD ARRAY!");
        GMSPlace* CurrentPlace = likehood.place;
        GooglePlace* place = [[GooglePlace alloc] init];
        [place Initiate:CurrentPlace.name:CurrentPlace.placeID :CurrentPlace.coordinate :CurrentPlace.types :CurrentPlace.openNowStatus :CurrentPlace.phoneNumber :CurrentPlace.formattedAddress :CurrentPlace.rating :CurrentPlace.priceLevel :CurrentPlace.website];
        NSArray *typeplace = place.types;
        NSLog(@"PLACE TYPE for %@",place.name);
        for (NSString* type in typeplace){
            NSLog(@"iterating through stuff");
            if ([type isEqualToString:@"bakery"]||[type isEqualToString:@"cafe"]||[type isEqualToString:@"restaurant"]||[type isEqualToString:@"meal_delivery"]||[type isEqualToString:@"meal_takeaway"]){
                if (![Food containsObject:place]){
                    [Food addObject:place];
                    NSLog(@"adding to food array in first view, Food count %lu",[Food count]);
                }
                
            }
            else if ([type isEqualToString:@"department_store"]||[type isEqualToString:@"beauty_salon"]||[type isEqualToString:@"clothing_store"]||[type isEqualToString:@"book_store"]||[type isEqualToString:@"hair_care"]||[type isEqualToString:@"gym"]||[type isEqualToString:@"shopping_mall"]||[type isEqualToString:@"spa"]||[type isEqualToString:@"museum"]||[type isEqualToString:@"park"]||[type isEqualToString:@"library"]){
                if (![Leisure containsObject:place]){
                    [Leisure addObject:place];}
            }
            else if ([type isEqualToString:@"beauty_salon"]||[type isEqualToString:@"hair_care"]||[type isEqualToString:@"gym"]||[type isEqualToString:@"spa"]||[type isEqualToString:@"museum"]||[type isEqualToString:@"park"]||[type isEqualToString:@"library"]){
                if (![Leisure containsObject:place]){
                    [Leisure addObject:place];}
            }
            else if ([type isEqualToString:@"department_store"]||[type isEqualToString:@"shoe_store"]||[type isEqualToString:@"shopping_mall"]||[type isEqualToString:@"clothing_store"]||[type isEqualToString:@"book_store"]||[type isEqualToString:@"electronics_store"]||[type isEqualToString:@"bicycle_store"]||[type isEqualToString:@"home_goods_store"]||[type isEqualToString:@"jewelry_store"]||[type isEqualToString:@"pet_store"]||[type isEqualToString:@"convenience_store"]||[type isEqualToString:@"hardware_store"]||[type isEqualToString:@"store"]){
                if (![Shopping containsObject:place]){
                    [Shopping addObject:place];}
            }
            else if ([type isEqualToString:@"aquarium"]||[type isEqualToString:@"casino"]||[type isEqualToString:@"bowling_alley"]||[type isEqualToString:@"amusement_park"]||[type isEqualToString:@"zoo"]||[type isEqualToString:@"art_gallery"]||[type isEqualToString:@"bar"]||[type isEqualToString:@"campground"]||[type isEqualToString:@"night_club"]||[type isEqualToString:@"movie_rental"]||[type isEqualToString:@"movie_theater"]||[type isEqualToString:@"stadium"]){
                if (![Entertainment containsObject:place]){
                    [Entertainment addObject:place];
                    NSLog(@"count for entertain: %@ %lu",place,[Entertainment count]);
                }
            }
            else if ([type isEqualToString:@"synagogue"]||[type isEqualToString:@"hindu_temple"]||[type isEqualToString:@"church"]||[type isEqualToString:@"city_hall"]||[type isEqualToString:@"mosque"]){
                if (![Culture containsObject:place]){
                    [Culture addObject:place];}
            }
            else if ([type isEqualToString:@"airport"]||[type isEqualToString:@"bus_station"]||[type isEqualToString:@"gas_station"]||[type isEqualToString:@"car_dealer"]||[type isEqualToString:@"car_rental"]||[type isEqualToString:@"car_repair"]||[type isEqualToString:@"car_wash"]||[type isEqualToString:@"car_wash"]||[type isEqualToString:@"taxi_stand"]||[type isEqualToString:@"train_station"]||[type isEqualToString:@"travel_agency"]||[type isEqualToString:@"parking"]||[type isEqualToString:@"subway_station"]||[type isEqualToString:@"moving_company"]||[type isEqualToString:@"lodging"]){
                if (![Transportation containsObject:place]){
                    [Transportation addObject:place];}
            }
            else if ([type isEqualToString:@"accounting"]||[type isEqualToString:@"atm"]||[type isEqualToString:@"bank"]||[type isEqualToString:@"insurance_agency"]){
                if (![Financial containsObject:place]){
                    [Financial addObject:place];}
            }
            else if ([type isEqualToString:@"dentist"]||[type isEqualToString:@"doctor"]||[type isEqualToString:@"electrician"]||[type isEqualToString:@"florist"]||[type isEqualToString:@"locksmith"]||[type isEqualToString:@"painter"]||[type isEqualToString:@"physiotherapist"]||[type isEqualToString:@"plumber"]||[type isEqualToString:@"lawyer"]||[type isEqualToString:@"real_estate_agency"]||[type isEqualToString:@"roofing_contractor"]){
                if (![Occupational containsObject:place]){
                    [Occupational addObject:place];}
            }
            else if ([type isEqualToString:@"funeral_home"]||[type isEqualToString:@"furniture_store"]||[type isEqualToString:@"embassy"]||[type isEqualToString:@"fire_station"]||[type isEqualToString:@"cemetery"]||[type isEqualToString:@"veterinary_care"]||[type isEqualToString:@"courthouse"]||[type isEqualToString:@"rv_park"]||[type isEqualToString:@"police"]||[type isEqualToString:@"hospital"]){
                if (![Other containsObject:place]){
                    [Other addObject:place];}
            }
            else if ([type isEqualToString:@"laundry"]||[type isEqualToString:@"pharmacy"]||[type isEqualToString:@"post_office"]||[type isEqualToString:@"supermarket"]||[type isEqualToString:@"storage"]||[type isEqualToString:@"school"]||[type isEqualToString:@"local_government_office"]){
                if (![Lifestyle containsObject:place]){
                    [Lifestyle addObject:place];}
            }
        }
        
        
        NSLog(@"Current Place name %@ at likelihood %g", place.name, likehood.likelihood);
        
    }
    NSLog(@"done with loop");
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
    cell.textLabel.text= [self.categories objectAtIndex:indexPath.row];;
    // Configure the cell...
    
    return cell;
}


- (BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[MapViewController class]]){
        MapViewController *Map = (MapViewController* ) viewController;
        NSLog(@"Switching from tips to map");

    }
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectedIndexPath = [self.categories objectAtIndex:indexPath.row];
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
         SecTip.LocationName=SelectedIndexPath;
         SecTip.title=SecTip.LocationName;
         SecTip.LikelyList=LikelyList;
         SecTip.Food=Food;
         SecTip.Transportation=Transportation;
         SecTip.Shopping=Shopping;
         SecTip.Other=Other;
         SecTip.Occupational=Occupational;
         SecTip.Leisure=Leisure;
         SecTip.Lifestyle=Lifestyle;
         SecTip.Culture=Culture;
         SecTip.Entertainment=Entertainment;
         SecTip.Financial=Financial;
         NSLog(@"Food count:%lu",[Food count]);
     }
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
