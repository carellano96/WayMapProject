//
//  TipsFirstTableViewController.m
//  WayMap
//
//  Created by carlos arellano and jean jeon on 4/12/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "TipsFirstTableViewController.h"
#import "MapViewController.h"
#import "TipsSecondTableViewController.h"
#import "AppDelegate.h"
@interface TipsFirstTableViewController ()


@end
@implementation TipsFirstTableViewController
AppDelegate* myDelegate1;
@synthesize categories,NearbyLocations,Transportation,Occupational,Financial,Food,Lifestyle,Culture,Entertainment,Leisure,Other,Shopping,Tips1,userLocation,SelectedPlace,index;
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
    SelectedPlace= [[GooglePlace alloc ]init];
    [super viewDidLoad];
    
    
    NSLog(@"Hello again");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//creates an array of categories and retrieves information from delegate controller
-(void) viewWillAppear:(BOOL)animated{
    if (index==1){
        myDelegate1 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.NearbyLocations=myDelegate1.LocationsNearby;
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
    self.tabBarController.delegate=self;
    int count=0;
    for (GooglePlace*place in self.NearbyLocations){
        count++;
        NSLog(@"ADDED TO FOOD ARRAY!");
        NSLog(@"Current Place name %@", place.name);
        
    }
    [categories removeAllObjects];
//Only shows categories that are present
    [self CategorizeLocations:NearbyLocations];
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
        for (GooglePlace* location in NearbyLocations){
            if (location.Favorited){
                NSLog(@"WOOOO FAVORITED!!! %@",location.name);
            }
        }
        index=0;
        [self.tableView reloadData];

    }

    else{
        [self.tableView reloadData];
    }
    
}
//categorizes different data based on Types array provided by Google Places API
- (void) CategorizeLocations
:(GooglePlace*)place{
    for (GooglePlace*place in NearbyLocations){
        NSLog(@"ADDED TO FOOD ARRAY!");

        NSArray *typeplace = place.types;
        NSLog(@"PLACE TYPE for %@",place.name);
        for (NSString* type in typeplace){
            NSLog(@"iterating through stuff");
            if ([type isEqualToString:@"bakery"]||[type isEqualToString:@"cafe"]||[type isEqualToString:@"restaurant"]||[type isEqualToString:@"meal_delivery"]||[type isEqualToString:@"meal_takeaway"]||[type isEqualToString:@"Food"]){
                if (![Food containsObject:place]){
                    [Food addObject:place];
                    NSLog(@"adding to food array in first view, Food count %lu",[Food count]);
                }
                
            }
            else if ([type isEqualToString:@"beauty_salon"]||[type isEqualToString:@"hair_care"]||[type isEqualToString:@"gym"]||[type isEqualToString:@"spa"]||[type isEqualToString:@"museum"]||[type isEqualToString:@"park"]||[type isEqualToString:@"library"]||[type isEqualToString:@"Leisure"]){
                if (![Leisure containsObject:place]){
                    [Leisure addObject:place];}
            }
            else if ([type isEqualToString:@"department_store"]||[type isEqualToString:@"shoe_store"]||[type isEqualToString:@"shopping_mall"]||[type isEqualToString:@"clothing_store"]||[type isEqualToString:@"book_store"]||[type isEqualToString:@"electronics_store"]||[type isEqualToString:@"bicycle_store"]||[type isEqualToString:@"home_goods_store"]||[type isEqualToString:@"jewelry_store"]||[type isEqualToString:@"pet_store"]||[type isEqualToString:@"convenience_store"]||[type isEqualToString:@"hardware_store"]||[type isEqualToString:@"store"]||[type isEqualToString:@"Shopping"]){
                if (![Shopping containsObject:place]){
                    [Shopping addObject:place];}
            }
            else if ([type isEqualToString:@"aquarium"]||[type isEqualToString:@"casino"]||[type isEqualToString:@"bowling_alley"]||[type isEqualToString:@"amusement_park"]||[type isEqualToString:@"zoo"]||[type isEqualToString:@"art_gallery"]||[type isEqualToString:@"bar"]||[type isEqualToString:@"campground"]||[type isEqualToString:@"night_club"]||[type isEqualToString:@"movie_rental"]||[type isEqualToString:@"movie_theater"]||[type isEqualToString:@"stadium"]||[type isEqualToString:@"Entertainment"]){
                if (![Entertainment containsObject:place]){
                    [Entertainment addObject:place];
                    NSLog(@"count for entertain: %@ %lu",place,[Entertainment count]);
                }
            }
            else if ([type isEqualToString:@"synagogue"]||[type isEqualToString:@"hindu_temple"]||[type isEqualToString:@"church"]||[type isEqualToString:@"city_hall"]||[type isEqualToString:@"mosque"]||[type isEqualToString:@"Culture"]){
                if (![Culture containsObject:place]){
                    [Culture addObject:place];}
            }
            else if ([type isEqualToString:@"airport"]||[type isEqualToString:@"bus_station"]||[type isEqualToString:@"gas_station"]||[type isEqualToString:@"car_dealer"]||[type isEqualToString:@"car_rental"]||[type isEqualToString:@"car_repair"]||[type isEqualToString:@"car_wash"]||[type isEqualToString:@"car_wash"]||[type isEqualToString:@"taxi_stand"]||[type isEqualToString:@"train_station"]||[type isEqualToString:@"travel_agency"]||[type isEqualToString:@"parking"]||[type isEqualToString:@"subway_station"]||[type isEqualToString:@"moving_company"]||[type isEqualToString:@"lodging"]||[type isEqualToString:@"Transportation"]){
                if (![Transportation containsObject:place]){
                    [Transportation addObject:place];}
            }
            else if ([type isEqualToString:@"accounting"]||[type isEqualToString:@"atm"]||[type isEqualToString:@"bank"]||[type isEqualToString:@"insurance_agency"]||[type isEqualToString:@"Financial"]){
                if (![Financial containsObject:place]){
                    [Financial addObject:place];}
            }
            else if ([type isEqualToString:@"dentist"]||[type isEqualToString:@"doctor"]||[type isEqualToString:@"electrician"]||[type isEqualToString:@"florist"]||[type isEqualToString:@"locksmith"]||[type isEqualToString:@"painter"]||[type isEqualToString:@"physiotherapist"]||[type isEqualToString:@"plumber"]||[type isEqualToString:@"lawyer"]||[type isEqualToString:@"real_estate_agency"]||[type isEqualToString:@"roofing_contractor"]||[type isEqualToString:@"Occupational"]){
                if (![Occupational containsObject:place]){
                    [Occupational addObject:place];}
            }
            else if ([type isEqualToString:@"funeral_home"]||[type isEqualToString:@"furniture_store"]||[type isEqualToString:@"embassy"]||[type isEqualToString:@"fire_station"]||[type isEqualToString:@"cemetery"]||[type isEqualToString:@"veterinary_care"]||[type isEqualToString:@"courthouse"]||[type isEqualToString:@"rv_park"]||[type isEqualToString:@"police"]||[type isEqualToString:@"hospital"]||[type isEqualToString:@"Other"]){
                if (![Other containsObject:place]){
                    [Other addObject:place];}
            }
            else if ([type isEqualToString:@"laundry"]||[type isEqualToString:@"pharmacy"]||[type isEqualToString:@"post_office"]||[type isEqualToString:@"supermarket"]||[type isEqualToString:@"storage"]||[type isEqualToString:@"school"]||[type isEqualToString:@"local_government_office"]||[type isEqualToString:@"Lifestyle"]){
                if (![Lifestyle containsObject:place]){
                    [Lifestyle addObject:place];}
            }
        }
        
        

        
    }
    NSLog(@"done with loop");
}
//insert information in table view controller

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"does this work1");
    
    return 1;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"does this work2");
    NSLog(@"%lu",(unsigned long)[self.categories count]);
    return [self.categories count];
}
//chooses random location when button is pressed
- (IBAction)SurpriseMe:(id)sender {
    int cat = arc4random_uniform([categories count]);
    NSString* Chosen = [categories objectAtIndex:cat];
    NSMutableArray*ArrayChosen;
    if ([Chosen isEqualToString:@"Food"]){
        ArrayChosen=Food;
    }
    if ([Chosen isEqualToString:@"Leisure"]){
        ArrayChosen=Leisure;
    }
    else if ([Chosen isEqualToString:@"Entertainment"]){
        ArrayChosen=Entertainment;
    }else if ([Chosen isEqualToString:@"Culture"]){
        ArrayChosen=Culture;
    }else if ([Chosen isEqualToString:@"Financial"]){
        ArrayChosen=Financial;}
    else if ([Chosen isEqualToString:@"Transportation"]){
        ArrayChosen=Transportation;
    }else if ([Chosen isEqualToString:@"Occupational"]){
        ArrayChosen=Occupational;
}
        else if ([Chosen isEqualToString:@"Lifestyle"]){
            ArrayChosen=Lifestyle;
}
        else if ([Chosen isEqualToString:@"Shopping"]){
            ArrayChosen=Shopping;}
        else if ([Chosen isEqualToString:@"Other"]){
            ArrayChosen=Other;
        }
    int SpecificCategory = arc4random_uniform([ArrayChosen count]);
    GooglePlace* RandomPlace = [ArrayChosen objectAtIndex:SpecificCategory];
    SelectedPlace=RandomPlace;
    [self performSegueWithIdentifier:@"SurpriseMe" sender:self];
}
//shows information for category

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"does this work3");
    static NSString *simpleTableIdentifier = @"TypeOfLocation";
    UITableViewCell*cell = [[UITableView alloc] dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text= [self.categories objectAtIndex:indexPath.row];;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
//unwind segue
- (IBAction)FirstTipsBackToStart:(UIStoryboardSegue*) segue{
    NSLog(@"Returned again!");
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
//segues to next table view which has specific category location
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"showMoreDetails"]){
        // NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         TipsSecondTableViewController *SecTip = [segue destinationViewController];
         SecTip.LocationName=SelectedIndexPath;
         SecTip.title=SecTip.LocationName;
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
     else if ([segue.identifier isEqualToString:@"SurpriseMe"]){
         PlacesInformationViewController* Random = [segue destinationViewController];
         Random.SelectedPlace=SelectedPlace;
         Random.segueUsed=segue.identifier;
     }
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
