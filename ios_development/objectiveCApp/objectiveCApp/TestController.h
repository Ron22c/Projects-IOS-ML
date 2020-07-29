//
//  TestController.h
//  objectiveCApp
//
//  Created by Ranajit on 22/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TestController : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) int age;
@property (nonatomic, strong) NSString *breed;
@property (nonatomic, strong) UIImage *image;

-(void) bark;
-(void) barkNumber:(int)number;
-(void) barkNumber:(int)number loud:(BOOL)isLoud;
-(int) getAge: (int) multiplier;
-(int) getDogYears: (int) regularAge;
-(NSString *) getName;
-(int)factorial:(int) number;

@end
