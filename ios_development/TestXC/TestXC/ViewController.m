//
//  ViewController.m
//  TestXC
//
//  Created by Ranajit Chandra on 26/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import "ViewController.h"
@import GoogleMobileAdsMediationTestSuite;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GADRewardBasedVideoAd sharedInstance].delegate = self;

}

- (IBAction)cacheButton:(UIButton *)sender {
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ kGADSimulatorID ];
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request]
    withAdUnitID:@"ca-app-pub-6776391977517404/4109909204"];
}

-(void) updateString {
    self.string = @"this is a string";
}

-(int) addition: (int)num1 num2:(int)num2 {
    return num1+num2;
}

- (IBAction)debugButton:(UIButton *)sender {
    [GoogleMobileAdsMediationTestSuite presentOnViewController:self delegate:nil];
}

- (IBAction)showButton:(UIButton *)sender {
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
      [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }
}

@end
