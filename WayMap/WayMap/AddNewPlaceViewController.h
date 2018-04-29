//
//  AddNewPlaceViewController.h
//  WayMap
//
//  Created by Carlos Arellano and Jean Jeon on 4/23/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GooglePlace.h"
@interface AddNewPlaceViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate>
- (IBAction)textFieldClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong,nonatomic) GooglePlace* UserAddedPlace;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property Boolean AddedLocation;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *CancelButton;
@property (strong) NSMutableArray* PlaceTypes;
@property (strong) NSString* Type;

@property (strong, nonatomic) NSMutableArray *addedPlaces;

@end
