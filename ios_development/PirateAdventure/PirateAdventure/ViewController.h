//
//  ViewController.h
//  PirateAdventure
//
//  Created by Ranajit Chandra on 27/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model/Character.h"

@interface ViewController : UIViewController

@property (nonatomic) CGPoint currentPoint;
@property (nonatomic, strong) NSArray *tiles;
@property (nonatomic, strong) Character *character;

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *healthLavel;
@property (strong, nonatomic) IBOutlet UILabel *damageLavel;
@property (strong, nonatomic) IBOutlet UILabel *weaponLavel;
@property (strong, nonatomic) IBOutlet UILabel *armurLavel;
@property (strong, nonatomic) IBOutlet UILabel *storyLavel;
@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@property (strong, nonatomic) IBOutlet UIButton *northButton;
@property (strong, nonatomic) IBOutlet UIButton *southButton;
@property (strong, nonatomic) IBOutlet UIButton *eastButton;
@property (strong, nonatomic) IBOutlet UIButton *westButton;


- (IBAction)actionButtonPressed:(UIButton *)sender;
- (IBAction)northButtonPressed:(UIButton *)sender;
- (IBAction)southButtonPressed:(UIButton *)sender;
- (IBAction)eastButtonPressed:(UIButton *)sender;
- (IBAction)westButtonPressed:(UIButton *)sender;
- (IBAction)resetToDefaultButtonPressed:(UIButton *)sender;



@end

