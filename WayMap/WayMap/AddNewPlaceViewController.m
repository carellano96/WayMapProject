//
//  AddNewPlaceViewController.m
//  WayMap
//
//  Created by Carlos Arellano and Jean Jeon on 4/23/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "AddNewPlaceViewController.h"
#import "AppDelegate.h"
@import GooglePlaces;
@import  GooglePlacePicker;
@import Firebase;
@import FirebaseDatabase;
@import FirebaseAuth;
@interface AddNewPlaceViewController ()  <GMSAutocompleteViewControllerDelegate>

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation
AddNewPlaceViewController
NSArray*pickerData;
NSString* name;
@synthesize textField,picker,UserAddedPlace,nameTextField,PlaceTypes,Type, addedPlaces;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    self.picker.delegate=self;
    self.picker.dataSource=self;
    pickerData = @[@"Food",@"Leisure",@"Shopping",@"Entertainment",@"Culture",@"Transportation",@"Financial",@"Occupational",@"Lifestyle",@"Other"];
    // Do any additional setup after loading the view.
    
    addedPlaces = [[NSMutableArray alloc]init];
    
    textField.delegate = self;
    nameTextField.delegate = self;
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)theTextField{
    [textField resignFirstResponder];
    [nameTextField resignFirstResponder];
    return true;
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
    Type = pickerData[row];
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

//Push user-added data to be stored under their respective UID in Firebase
- (IBAction)SaveBtnTapped:(UIButton *)sender {
    
    NSNumber *latitude = [NSNumber numberWithDouble:UserAddedPlace.coordinate.latitude];
    NSNumber *longitude = [NSNumber numberWithDouble:UserAddedPlace.coordinate.longitude];
    
    FIRUser *user = [FIRAuth auth].currentUser;
    FIRDatabaseReference *newReference= [[[[self.ref child:@"users"] child:user.uid] child:@"Places Added"] childByAutoId];
    [[newReference child:@"Name"] setValue:nameTextField.text];
    [[newReference child:@"Address"] setValue:textField.text];
    [[newReference child:@"Type"] setValue:Type];
    [[newReference child:@"placeID"] setValue: UserAddedPlace.placeID];
    [[newReference child:@"Latitude"] setValue: [latitude stringValue]];
    [[newReference child:@"Longitude"] setValue: [longitude stringValue]];
    
    AppDelegate* addedPlacesDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [addedPlaces addObject:UserAddedPlace];
    addedPlacesDelegate.MyUserAddedLocations = addedPlaces;
}

@end
