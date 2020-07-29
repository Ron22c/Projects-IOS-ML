//
//  Character.h
//  PirateAdventure
//
//  Created by Ranajit Chandra on 27/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weapon.h"
#import "Armor.h"

@interface Character : NSObject

@property (strong, nonatomic) Weapon *weapon;
@property (strong, nonatomic) Armor *armor;
@property (nonatomic) int health;
@property (nonatomic) int damage;

@end

