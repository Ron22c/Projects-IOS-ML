//
//  ConversionViewController.h
//  objectiveCApp
//
//  Created by Ranajit on 21/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ConversionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *resultOfFootballField;
@property (weak, nonatomic) IBOutlet UITextField *textFieldInputNumber;

- (IBAction)button:(UIButton *)sender;

@end

