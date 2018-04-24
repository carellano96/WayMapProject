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
NSString* name;
@synthesize textField,picker,UserAddedPlace,nameTextField,PlaceTypes,Type;
- (void)viewDidLoad {
    [super viewDidLoad];
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
-(void)viewWillAppear:(BOOL)animated{
    name= [[NSString alloc]init];
    PlaceTypes=[[NSMutableArray alloc]init];
}
- (IBAction)addName:(id)sender {
    name=nameTextField.text;
}
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"User added Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    textField.text=place.formattedAddress;
    UserAddedPlace=[[GooglePlace alloc ]init];
    [UserAddedPlace Initiate:name :place.placeID :place.coordinate :place.types :place.openNowStatus :place.phoneNumber :place.formattedAddress :place.rating :place.priceLevel :place.website];
    NSLog (@"Google place name: %@",UserAddedPlace.name);
    UserAddedPlace.UserAdded=true;
    int row=[picker selectedRowInComponent:0];
    UserAddedPlace.types=[[NSMutableArray alloc] initWithObjects:pickerData[row], nil];
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
    NSString* Type = pickerData[row];
    PlaceTypes = [[NSMutableArray alloc] initWithObjects:Type, nil];
    NSLog(@"Type is %@", Type);
    UserAddedPlace.types=PlaceTypes;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (sender==self.saveButton&&![UserAddedPlace.name isEqualToString:nil]){
        self.AddedLocation=true;
        NSLog(@"saved!");
    }
    else if (sender==self.CancelButton){
        self.AddedLocation=false;
    }
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
