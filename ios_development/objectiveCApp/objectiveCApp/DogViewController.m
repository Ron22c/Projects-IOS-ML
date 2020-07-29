//
//  DogViewController.m
//  objectiveCApp
//
//  Created by Ranajit on 23/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import "DogViewController.h"
#import "TestController.h"
#import "Inheritace.h"
@interface DogViewController ()

@end

@implementation DogViewController

- (void)viewDidLoad{
    TestController *control = [[TestController alloc] init];
    
    control.name = @"BULLDOG";
    control.breed = @"PUG";
    control.image = [UIImage imageNamed:@"323472.jpg"];
    
    TestController *controlTwo = [[TestController alloc] init];
    
    controlTwo.name = @"Dog@";
    controlTwo.breed = @"beeed2";
    controlTwo.image = [UIImage imageNamed:@"323472.jpg"];
    
    TestController *controlThree = [[TestController alloc] init];
    
    controlThree.name = @"Dog3";
    controlThree.breed = @"beeed3";
    controlThree.image = [UIImage imageNamed:@"323472.jpg"];
    
    TestController *controlFour = [[TestController alloc] init];
    
    controlFour.name = @"Dog4";
    controlFour.breed = @"beeed4";
    controlFour.image = [UIImage imageNamed:@"323472.jpg"];
    
    self.myDogs = [[NSMutableArray alloc]init];
    [self.myDogs addObject:control];
    [self.myDogs addObject:controlTwo];
    [self.myDogs addObject:controlThree];
    [self.myDogs addObject:controlFour];
    
    self.dogBreed.text = control.breed;
    self.dogName.text = control.name;
    self.dogImage.image = control.image;
    NSLog(@"%@", self.myDogs);
    
    Inheritace *obj = [[Inheritace alloc]init];
    [obj getPuppyEyes];
    [obj bark];
    
}

- (IBAction)navBarNewDog:(UIBarButtonItem *)sender {
    int countOfDogs = (int)[self.myDogs count];
    int randomNumber = arc4random() % countOfDogs;
    TestController *dog = [self.myDogs objectAtIndex:randomNumber];
    
    [UIView transitionWithView:self.view duration:2.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.dogBreed.text = dog.breed;
        self.dogName.text = dog.name;
        self.dogImage.image = dog.image;
    } completion:^(BOOL finished) {
    }];
    sender.title = @"Add another";
}

@end
