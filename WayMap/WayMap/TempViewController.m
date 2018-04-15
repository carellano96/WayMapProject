//
//  TempViewController.m
//  WayMap
//
//  Created by carlos arellano on 4/14/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "TempViewController.h"

@interface TempViewController ()

@end

@implementation TempViewController
@synthesize categories,TempTable;
- (void)viewDidLoad {
    CGRect mainViewFrame = CGRectMake(20,10,0,20);
    self.view = [[UIView alloc] initWithFrame:mainViewFrame];
    
    // You could make this even simpler if you set the table view as
    // your main view
    CGRect tableViewFrame = self.view.bounds;
    UITableView* TempTable = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    TempTable.backgroundColor=[UIColor blueColor];
    [self.view addSubview:TempTable];
    self.TempTable.delegate=self;
    self.TempTable.dataSource=self;
    
    [categories addObject:@"Food"];
    [categories addObject:@"Nature"];
    [categories addObject:@"Entertainment"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
    [self.TempTable reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"does this work1");
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"does this work2");
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"does this work3");
    static NSString *simpleTableIdentifier = @"TypeOfLocation";
    UITableViewCell*cell = [[UITableView alloc] dequeueReusableCellWithIdentifier:@"TypeOfLocation" forIndexPath:indexPath];
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text= [categories objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
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

@end
