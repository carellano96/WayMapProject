//
//  AddNewPlaceViewController.h
//  WayMap
//
//  Created by carlos arellano on 4/23/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GooglePlace.h"
@interface AddNewPlaceViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
- (IBAction)textFieldClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong) GooglePlace* UserAddedPlace;

@end
