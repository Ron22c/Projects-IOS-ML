//
//  ViewController.h
//  objectiveCApp
//
//  Created by Ranajit on 21/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
- (IBAction)button:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property(strong, nonatomic) NSString *stringOne;
- (void) changeString;
@end
