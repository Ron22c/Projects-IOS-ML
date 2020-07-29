//
//  ConversionViewController.m
//  objectiveCApp
//
//  Created by Ranajit on 21/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import "ConversionViewController.h"
#import "TestController.h"

@interface ConversionViewController ()

@end

@implementation ConversionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"hello we are starting the application");
    TestController *obj = [[TestController alloc] init];
    NSLog(@"%i", [obj factorial:4]);
    obj.name = @"doggy";
    obj.age = 2;
    obj.breed = @"pug";
    
    [obj barkNumber:2 loud:NO];
    [obj bark];
    [obj barkNumber:24];
    [obj getDogYears:23];
    NSLog(@"%i",[obj getDogYears:23]);
    NSLog(@"%@",[obj getName]);
    NSLog(@"%i",[obj getAge:20]);
    NSLog(@"name is %@ age is %i breed is %@", obj.name, obj.age, obj.breed);
    obj = nil;
    NSLog(@"name is %@ age is %i breed is %@", obj.name, obj.age, obj.breed);
    
}
- (IBAction)button:(UIButton *)sender {
    float inputNumber = [self.textFieldInputNumber.text floatValue];
    float result = inputNumber/29000;

    self.resultOfFootballField.text= [[NSNumber numberWithFloat:result] stringValue];
    NSLog(@"Result is: %f", result);
}
@end
