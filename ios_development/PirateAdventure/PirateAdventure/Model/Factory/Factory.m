//
//  Factory.m
//  PirateAdventure
//
//  Created by Ranajit Chandra on 27/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import "Factory.h"
#import "Tile.h"

@implementation Factory

- (NSArray *) tiles
{
    Tile *tile1 = [[Tile alloc] init];
    tile1.story = @"StoryOne";
    
    Tile *tile2 = [[Tile alloc] init];
    tile2.story = @"Story2";
    
    Tile *tile3 = [[Tile alloc] init];
    tile3.story = @"Story3";
    
    Tile *tile4 = [[Tile alloc] init];
    tile4.story = @"Story4";
    
    Tile *tile5 = [[Tile alloc] init];
    tile5.story = @"Story5";
    
    Tile *tile6 = [[Tile alloc] init];
    tile6.story = @"Story6";
    
    Tile *tile7 = [[Tile alloc] init];
    tile7.story = @"Story7";

    Tile *tile8 = [[Tile alloc] init];
    tile8.story = @"Story8";
    
    Tile *tile9 = [[Tile alloc] init];
    tile9.story = @"Story9";
    
    Tile *tile10 = [[Tile alloc] init];
    tile10.story = @"Story10";
    
    Tile *tile11 = [[Tile alloc] init];
    tile11.story = @"Story11";
    
    Tile *tile12 = [[Tile alloc] init];
    tile12.story = @"Story12";
    
    NSMutableArray *firstColumn = [[NSMutableArray alloc] init];
    NSMutableArray *secondColumn = [[NSMutableArray alloc] init];
    NSMutableArray *ThirdColumn = [[NSMutableArray alloc] init];
    NSMutableArray *fourthColumn = [[NSMutableArray alloc] init];
    
    [firstColumn addObject:tile1];
    [firstColumn addObject:tile2];
    [firstColumn addObject:tile3];
    
    [secondColumn addObject:tile4];
    [secondColumn addObject:tile5];
    [secondColumn addObject:tile6];
    
    [ThirdColumn addObject:tile7];
    [ThirdColumn addObject:tile8];
    [ThirdColumn addObject:tile9];
    
    [fourthColumn addObject:tile10];
    [fourthColumn addObject:tile11];
    [fourthColumn addObject:tile12];
    
    NSArray *tiles = [[NSArray alloc] initWithObjects:firstColumn, secondColumn, ThirdColumn, fourthColumn, nil];
    
    return tiles;
}

- (Character *) character {
    Character *character = [[Character alloc] init];
    Armor *armor = [[Armor alloc] init];
    Weapon *weapon = [[Weapon alloc] init];
    armor.name = @"clock";
    armor.health = 5;
    weapon.name = @"fists";
    weapon.damageNumber = 10;
    character.health = 100;
    character.armor = armor;
    character.weapon = weapon;
    return character;
}

@end
