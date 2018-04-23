//
//  AddNewPlaceViewController.m
//  WayMap
//
//  Created by carlos arellano on 4/23/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "AddNewPlaceViewController.h"
@import GooglePlaces;
@import  GooglePlacePicker;
@interface AddNewPlaceViewController ()  <GMSAutocompleteViewControllerDelegate>

@end

@implementation
AddNewPlaceViewController
NSArray*pickerData;

@synthesize textField,picker,UserAddedPlace;
- (void)viewDidLoad {
    [super viewDidLoad];
    UserAddedPlace=[[GooglePlace alloc]init];
    self.picker.delegate=self;
    self.picker.dataSource=self;
    pickerData = @[@"Food",@"Leisure",@"Shopping",@"Entertainment",@"Culture",@"Transportation",@"Financial",@"Occupational",@"Lifestyle",@"Other"];
    // Do any additional setup after loading the view.
}
- (void)textFieldClick:(id)sender{
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    textField.text=place.name;
    [UserAddedPlace Initiate:place.name :place.placeID :place.coordinate :place.types :place.openNowStatus :place.phoneNumber :place.formattedAddress :place.rating :place.priceLevel :place.website];
    UserAddedPlace.UserAdded=true;
    
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerData[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
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
