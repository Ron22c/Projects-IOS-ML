//
//  DogViewController.h
//  objectiveCApp
//
//  Created by Ranajit on 23/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DogViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *dogImage;
@property (weak, nonatomic) IBOutlet UILabel *dogName;
@property (weak, nonatomic) IBOutlet UILabel *dogBreed;
@property (nonatomic, strong) NSMutableArray *myDogs;
-(IBAction)navBarNewDog:(UIBarButtonItem *)sender;

@end
