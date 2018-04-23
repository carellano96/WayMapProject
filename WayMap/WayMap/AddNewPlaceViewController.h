//
//  AddNewPlaceViewController.h
//  WayMap
//
//  Created by carlos arellano on 4/23/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewPlaceViewController : UIViewController
- (IBAction)textFieldClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
