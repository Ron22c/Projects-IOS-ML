//
//  ViewController.h
//  TestXC
//
//  Created by Ranajit Chandra on 26/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAdsMediationTestSuite;


@interface ViewController : UIViewController
- (IBAction)showButton:(UIButton *)sender;
@property(strong, nonatomic) NSString *string;
- (IBAction)cacheButton:(UIButton *)sender;
-(void) updateString;
-(int) addition: (int)num1 num2:(int)num2;
- (IBAction)debugButton:(UIButton *)sender;
@end

