//
//  ViewController.m
//  PirateAdventure
//
//  Created by Ranajit Chandra on 27/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import "ViewController.h"
#import "Model/Tile.h"
#import "Model/Character.h"
#import "Model/Factory/Factory.h"
#import <PokktSDK/PokktSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Factory *factory = [[Factory alloc] init];
    self.tiles = [factory tiles];
    self.character = [factory character];
    self.currentPoint = CGPointMake(0, 0);
    [self loadContent];
    [self updateTile];
    
}

- (IBAction)actionButtonPressed:(UIButton *)sender {
}

- (IBAction)northButtonPressed:(UIButton *)sender {
    self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y+1);
    [self updateTile];
    [self loadContent];
}

- (IBAction)southButtonPressed:(UIButton *)sender {
    self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y-1);
    [self updateTile];
    [self loadContent];
}

- (IBAction)eastButtonPressed:(UIButton *)sender {
    self.currentPoint = CGPointMake(self.currentPoint.x+1, self.currentPoint.y);
    [self updateTile];
    [self loadContent];
}

- (IBAction)westButtonPressed:(UIButton *)sender {
    self.currentPoint = CGPointMake(self.currentPoint.x-1, self.currentPoint.y);
    [self updateTile];
    [self loadContent];
}

- (IBAction)resetToDefaultButtonPressed:(UIButton *)sender {
//    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
//    [settings setValue:@"6ac9e68606ecde2274822f7c8d2f24f7" forKey:@"appId"];
//    [settings setValue:@"65939a8e21ead5c5aadb83032ddf2bd8" forKey:@"secKey"];
//    NSString *appiId = [settings objectForKey:@"appId"];
//    NSString *sec = [settings objectForKey:@"secKey"];
//    NSLog(@"%@ , %@", appiId, sec);
//    [PokktAds setPokktConfigWithAppId:appiId securityKey:sec];
//    [PokktDebugger setDebug: YES];
//    [PokktVideoAds cacheNonRewarded:@"1234567"];
}

- (void)loadContent {
    Tile *tileModel = [[self.tiles objectAtIndex:self.currentPoint.x] objectAtIndex:self.currentPoint.y];
    
    self.storyLavel.text = tileModel.story;
    self.healthLavel.text = [NSString stringWithFormat:@"%i", self.character.health];
    self.armurLavel.text = self.character.armor.name;
    self.weaponLavel.text = self.character.weapon.name;
    self.damageLavel.text = [NSString stringWithFormat:@"%i", self.character.damage];
}

- (void)updateTile {
    self.eastButton.hidden = [self isTileExists: CGPointMake(self.currentPoint.x+1, self.currentPoint.y)];
    
    self.westButton.hidden = [self isTileExists: CGPointMake(self.currentPoint.x-1, self.currentPoint.y)];
    
    self.northButton.hidden = [self isTileExists: CGPointMake(self.currentPoint.x, self.currentPoint.y+1)];
    
    self.southButton.hidden = [self isTileExists: CGPointMake(self.currentPoint.x, self.currentPoint.y-1)];
}

- (BOOL)isTileExists:(CGPoint) point {
    if(point.y >=0 && point.x >=0 && point.x < [self.tiles count] && point.y < [[self.tiles objectAtIndex:point.x] count]){
        return NO;
    }
    else{
        return YES;
    }
}

-(void) updateCharacterStatsWithArmor:(Armor *) armor withWeapon:(Weapon *) weapon withHealthEffect: (int) healthEffect {
    if(armor != nil) {
        self.character.health = self.character.armor.health + armor.health;
        self.character.armor = armor;
    } else if (weapon != nil) {
        self.character.damage = self.character.damage - self.character.weapon.damageNumber + weapon.damageNumber;
        self.character.weapon = weapon;
    }
}

@end
